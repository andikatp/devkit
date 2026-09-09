package com.andikatp.devkit

import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.nsd.NsdManager
import android.net.nsd.NsdServiceInfo
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val PERMISSIONS_CHANNEL = "com.andikatp.devkit/permissions"
    private val SETTINGS_CHANNEL = "com.andikatp.devkit/settings"

    @Volatile
    private var discoveredAdbPort: Int? = null
    private var nsdManager: NsdManager? = null
    private var discoveryListener: NsdManager.DiscoveryListener? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        startAdbMdnsDiscovery()

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PERMISSIONS_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "checkWriteSecureSettings" -> {
                    val isGranted = checkSelfPermission(android.Manifest.permission.WRITE_SECURE_SETTINGS) == PackageManager.PERMISSION_GRANTED
                    result.success(isGranted)
                }
                "openDeveloperSettings" -> {
                    try {
                        val intent = Intent(Settings.ACTION_APPLICATION_DEVELOPMENT_SETTINGS)
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        startActivity(intent)
                        result.success(true)
                    } catch (e: Exception) {
                        try {
                            val intent = Intent(Settings.ACTION_SETTINGS)
                            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                            startActivity(intent)
                            result.success(true)
                        } catch (ex: Exception) {
                            result.success(false)
                        }
                    }
                }
                else -> result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SETTINGS_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getSystemSettings" -> {
                    try {
                        val devOptionsGlobal = Settings.Global.getInt(contentResolver, Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, 0) == 1
                        val devOptionsSecure = try {
                            Settings.Secure.getInt(contentResolver, "development_settings_enabled", 0) == 1
                        } catch (e: Exception) {
                            false
                        }
                        val devOptions = devOptionsGlobal || devOptionsSecure

                        val usbDebugging = Settings.Global.getInt(contentResolver, Settings.Global.ADB_ENABLED, 0) == 1
                        val wirelessDebugging = try {
                            Settings.Global.getInt(contentResolver, "adb_wifi_enabled", 0) == 1
                        } catch (e: Exception) {
                            false
                        }

                        var adbPort = discoveredAdbPort ?: 5555
                        if (discoveredAdbPort == null) {
                            try {
                                val sysPort = System.getProperty("service.adb.tcp.port")
                                    ?: System.getProperty("persist.adb.tcp.port")
                                    ?: System.getProperty("service.adb.tls.port")
                                if (!sysPort.isNullOrEmpty() && sysPort.toIntOrNull() != null) {
                                    val parsedPort = sysPort.toInt()
                                    if (parsedPort > 0) adbPort = parsedPort
                                }
                            } catch (e: Exception) {
                                adbPort = 5555
                            }
                        }

                        val map = mapOf(
                            "isDevOptionsOn" to devOptions,
                            "isUsbDebuggingOn" to usbDebugging,
                            "isWirelessDebuggingOn" to wirelessDebugging,
                            "adbPort" to adbPort
                        )
                        result.success(map)
                    } catch (e: Exception) {
                        result.error("GET_SETTINGS_ERROR", e.message, null)
                    }
                }
                "setDevOptions" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val targetVal = if (enabled) 1 else 0
                    writeSettingInt(Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, targetVal)
                    val actualGlobal = try { Settings.Global.getInt(contentResolver, Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, -1) } catch (e: Exception) { -1 }
                    result.success(actualGlobal == targetVal)
                }
                "setUsbDebugging" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val targetVal = if (enabled) 1 else 0
                    writeSettingInt(Settings.Global.ADB_ENABLED, targetVal)
                    val actualGlobal = try { Settings.Global.getInt(contentResolver, Settings.Global.ADB_ENABLED, -1) } catch (e: Exception) { -1 }
                    result.success(actualGlobal == targetVal)
                }
                "setWirelessDebugging" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val targetVal = if (enabled) 1 else 0
                    writeSettingInt("adb_wifi_enabled", targetVal)
                    val actualGlobal = try { Settings.Global.getInt(contentResolver, "adb_wifi_enabled", -1) } catch (e: Exception) { -1 }
                    result.success(actualGlobal == targetVal)
                }
                "getToolsState" -> {
                    try {
                        val showTaps = Settings.System.getInt(contentResolver, "show_touches", 0) == 1
                        val showPointerLocation = Settings.System.getInt(contentResolver, "pointer_location", 0) == 1
                        val stayAwake = Settings.Global.getInt(contentResolver, Settings.Global.STAY_ON_WHILE_PLUGGED_IN, 0) != 0
                        val animScale = Settings.Global.getFloat(contentResolver, Settings.Global.WINDOW_ANIMATION_SCALE, 1.0f).toDouble()
                        val demoMode = Settings.Global.getInt(contentResolver, "sysui_demo_allowed", 0) == 1
                        val forceDarkMode = Settings.Secure.getInt(contentResolver, "ui_night_mode", 1) == 2
                        val fontScale = Settings.System.getFloat(contentResolver, "font_scale", 1.0f).toDouble()

                        val map = mapOf(
                            "showLayoutBounds" to false,
                            "showTaps" to showTaps,
                            "showPointerLocation" to showPointerLocation,
                            "stayAwake" to stayAwake,
                            "animationScale" to animScale,
                            "demoMode" to demoMode,
                            "forceDarkMode" to forceDarkMode,
                            "fontScale" to fontScale,
                            "gpuProfiling" to false,
                            "strictMode" to false
                        )
                        result.success(map)
                    } catch (e: Exception) {
                        result.error("GET_TOOLS_STATE_ERROR", e.message, null)
                    }
                }
                "setStayAwake" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val targetVal = if (enabled) 7 else 0
                    writeSettingInt(Settings.Global.STAY_ON_WHILE_PLUGGED_IN, targetVal)
                    val actualGlobal = try { Settings.Global.getInt(contentResolver, Settings.Global.STAY_ON_WHILE_PLUGGED_IN, -1) } catch (e: Exception) { -1 }
                    result.success(actualGlobal == targetVal || (enabled && actualGlobal > 0))
                }
                "setDemoMode" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val targetVal = if (enabled) 1 else 0
                    writeSettingInt("sysui_demo_allowed", targetVal)
                    try {
                        val intent = Intent("com.android.systemui.demo")
                        if (enabled) {
                            intent.putExtra("command", "enter")
                            sendBroadcast(intent)
                            intent.putExtra("command", "clock")
                            intent.putExtra("hhmm", "0940")
                            sendBroadcast(intent)
                            intent.putExtra("command", "battery")
                            intent.putExtra("plugged", "false")
                            intent.putExtra("level", "100")
                            sendBroadcast(intent)
                            intent.putExtra("command", "network")
                            intent.putExtra("wifi", "show")
                            intent.putExtra("level", "4")
                            sendBroadcast(intent)
                        } else {
                            intent.putExtra("command", "exit")
                            sendBroadcast(intent)
                        }
                    } catch (e: Exception) {}
                    val actualGlobal = try { Settings.Global.getInt(contentResolver, "sysui_demo_allowed", -1) } catch (e: Exception) { -1 }
                    result.success(actualGlobal == targetVal)
                }
                "setForceDarkMode" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val targetVal = if (enabled) 2 else 1
                    writeSettingInt("ui_night_mode", targetVal)
                    val actualSecure = try { Settings.Secure.getInt(contentResolver, "ui_night_mode", -1) } catch (e: Exception) { -1 }
                    result.success(actualSecure == targetVal)
                }
                "setFontScale" -> {
                    val scale = (call.argument<Double>("scale") ?: 1.0).toFloat()
                    writeSettingFloat("font_scale", scale)
                    val actualSys = try { Settings.System.getFloat(contentResolver, "font_scale", 1.0f) } catch (e: Exception) { 1.0f }
                    result.success(Math.abs(actualSys - scale) < 0.05f)
                }
                "setShowTaps" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val targetVal = if (enabled) 1 else 0
                    val targetStr = targetVal.toString()
                    writeSettingInt("show_touches", targetVal)
                    writeSystemProperty("persist.sys.show_touches", targetStr)
                    val actualSysInt = try { Settings.System.getInt(contentResolver, "show_touches", -1) } catch (e: Exception) { -1 }
                    val actualProp = getSystemProperty("persist.sys.show_touches", "")
                    val isVerified = (actualSysInt == targetVal) || (actualProp == targetStr)
                    result.success(isVerified)
                }
                "setPointerLocation" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val targetVal = if (enabled) 1 else 0
                    val targetStr = targetVal.toString()
                    writeSettingInt("pointer_location", targetVal)
                    writeSystemProperty("persist.sys.pointer_location", targetStr)
                    val actualSysInt = try { Settings.System.getInt(contentResolver, "pointer_location", -1) } catch (e: Exception) { -1 }
                    val actualProp = getSystemProperty("persist.sys.pointer_location", "")
                    val isVerified = (actualSysInt == targetVal) || (actualProp == targetStr)
                    result.success(isVerified)
                }
                "setAnimationScale" -> {
                    val scale = (call.argument<Double>("scale") ?: 1.0).toFloat()
                    val scaleStr = scale.toString()
                    writeSettingFloat(Settings.Global.WINDOW_ANIMATION_SCALE, scale)
                    writeSettingFloat(Settings.Global.TRANSITION_ANIMATION_SCALE, scale)
                    writeSettingFloat(Settings.Global.ANIMATOR_DURATION_SCALE, scale)
                    writeSystemProperty("persist.sys.window_anim_scale", scaleStr)
                    writeSystemProperty("persist.sys.transition_anim_scale", scaleStr)
                    writeSystemProperty("persist.sys.animator_duration_scale", scaleStr)
                    val actualGlobal = try { Settings.Global.getFloat(contentResolver, Settings.Global.WINDOW_ANIMATION_SCALE, -1f) } catch (e: Exception) { -1f }
                    val actualProp = getSystemProperty("persist.sys.window_anim_scale", "")
                    val isVerified = (actualProp == scaleStr) || (Math.abs(actualGlobal - scale) < 0.01f)
                    result.success(isVerified)
                }
                "setGpuProfiling" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val targetVal = if (enabled) "visual_bars" else "false"
                    writeSettingString("track_frame_time", targetVal)
                    writeSystemProperty("debug.hwui.profile", targetVal)
                    val isVerified = getSystemProperty("debug.hwui.profile", "") == targetVal
                    result.success(isVerified)
                }
                "setStrictMode" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val targetVal = if (enabled) 1 else 0
                    val targetStr = targetVal.toString()
                    writeSettingInt("strict_mode_visual", targetVal)
                    writeSystemProperty("persist.sys.strictmode.visual", targetStr)
                    val isVerified = getSystemProperty("persist.sys.strictmode.visual", "") == targetStr
                    result.success(isVerified)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getSystemProperty(key: String, defaultValue: String = ""): String {
        return try {
            val c = Class.forName("android.os.SystemProperties")
            val get = c.getMethod("get", String::class.java, String::class.java)
            (get.invoke(null, key, defaultValue) as? String) ?: defaultValue
        } catch (e: Exception) {
            defaultValue
        }
    }

    private fun writeSettingInt(key: String, value: Int): Boolean {
        try {
            Settings.Global.putInt(contentResolver, key, value)
            if (verifySettingInt(key, value)) return true
        } catch (e: Exception) {}
        try {
            Settings.System.putInt(contentResolver, key, value)
            if (verifySettingInt(key, value)) return true
        } catch (e: Exception) {}
        try {
            Settings.Secure.putInt(contentResolver, key, value)
            if (verifySettingInt(key, value)) return true
        } catch (e: Exception) {}
        runShellCommand("settings put global $key $value")
        runShellCommand("settings put system $key $value")
        runShellCommand("settings put secure $key $value")
        return verifySettingInt(key, value)
    }

    private fun verifySettingInt(key: String, value: Int): Boolean {
        val g = try { Settings.Global.getInt(contentResolver, key, -1) } catch (e: Exception) { -1 }
        if (g == value) return true
        val s = try { Settings.System.getInt(contentResolver, key, -1) } catch (e: Exception) { -1 }
        if (s == value) return true
        val sec = try { Settings.Secure.getInt(contentResolver, key, -1) } catch (e: Exception) { -1 }
        return sec == value
    }

    private fun writeSettingString(key: String, value: String): Boolean {
        try {
            Settings.Global.putString(contentResolver, key, value)
            if (verifySettingString(key, value)) return true
        } catch (e: Exception) {}
        try {
            Settings.System.putString(contentResolver, key, value)
            if (verifySettingString(key, value)) return true
        } catch (e: Exception) {}
        try {
            Settings.Secure.putString(contentResolver, key, value)
            if (verifySettingString(key, value)) return true
        } catch (e: Exception) {}
        runShellCommand("settings put global $key $value")
        runShellCommand("settings put system $key $value")
        runShellCommand("settings put secure $key $value")
        return verifySettingString(key, value)
    }

    private fun verifySettingString(key: String, value: String): Boolean {
        val g = try { Settings.Global.getString(contentResolver, key) } catch (e: Exception) { null }
        if (g == value) return true
        val s = try { Settings.System.getString(contentResolver, key) } catch (e: Exception) { null }
        if (s == value) return true
        val sec = try { Settings.Secure.getString(contentResolver, key) } catch (e: Exception) { null }
        return sec == value
    }

    private fun writeSettingFloat(key: String, value: Float): Boolean {
        try {
            Settings.Global.putFloat(contentResolver, key, value)
            if (verifySettingFloat(key, value)) return true
        } catch (e: Exception) {}
        try {
            Settings.System.putFloat(contentResolver, key, value)
            if (verifySettingFloat(key, value)) return true
        } catch (e: Exception) {}
        try {
            Settings.Secure.putFloat(contentResolver, key, value)
            if (verifySettingFloat(key, value)) return true
        } catch (e: Exception) {}
        runShellCommand("settings put global $key $value")
        runShellCommand("settings put system $key $value")
        runShellCommand("settings put secure $key $value")
        return verifySettingFloat(key, value)
    }

    private fun verifySettingFloat(key: String, value: Float): Boolean {
        val g = try { Settings.Global.getFloat(contentResolver, key, -1f) } catch (e: Exception) { -1f }
        if (Math.abs(g - value) < 0.01f) return true
        val s = try { Settings.System.getFloat(contentResolver, key, -1f) } catch (e: Exception) { -1f }
        if (Math.abs(s - value) < 0.01f) return true
        val sec = try { Settings.Secure.getFloat(contentResolver, key, -1f) } catch (e: Exception) { -1f }
        return Math.abs(sec - value) < 0.01f
    }

    private fun writeSystemProperty(key: String, value: String): Boolean {
        var success = false
        try {
            val c = Class.forName("android.os.SystemProperties")
            val set = c.getMethod("set", String::class.java, String::class.java)
            set.invoke(null, key, value)
            success = true
        } catch (e: Exception) {}
        if (!success) {
            success = runShellCommand("setprop $key $value")
        }
        return success
    }

    private fun runShellCommand(cmd: String): Boolean {
        val success = try {
            val process = Runtime.getRuntime().exec(cmd)
            val exitCode = process.waitFor()
            exitCode == 0
        } catch (e: Exception) {
            false
        }
        return if (success) true else runSuCommand(cmd)
    }

    private fun runSuCommand(cmd: String): Boolean {
        return try {
            val process = Runtime.getRuntime().exec(arrayOf("su", "-c", cmd))
            val exitCode = process.waitFor()
            exitCode == 0
        } catch (e: Exception) {
            false
        }
    }

    private fun startAdbMdnsDiscovery() {
        if (nsdManager != null) return
        try {
            nsdManager = getSystemService(Context.NSD_SERVICE) as NsdManager
            discoveryListener = object : NsdManager.DiscoveryListener {
                override fun onDiscoveryStarted(regType: String) {}
                override fun onServiceFound(serviceInfo: NsdServiceInfo) {
                    val type = serviceInfo.serviceType ?: ""
                    if (type.contains("adb-tls-connect") || type.contains("adb")) {
                        try {
                            nsdManager?.resolveService(serviceInfo, object : NsdManager.ResolveListener {
                                override fun onResolveFailed(serviceInfo: NsdServiceInfo, errorCode: Int) {}
                                override fun onServiceResolved(resolvedService: NsdServiceInfo) {
                                    val port = resolvedService.port
                                    if (port > 0) {
                                        discoveredAdbPort = port
                                    }
                                }
                            })
                        } catch (e: Exception) {
                            // Resolve failed or busy
                        }
                    }
                }
                override fun onServiceLost(serviceInfo: NsdServiceInfo) {}
                override fun onDiscoveryStopped(serviceType: String) {}
                override fun onStartDiscoveryFailed(serviceType: String, errorCode: Int) {}
                override fun onStopDiscoveryFailed(serviceType: String, errorCode: Int) {}
            }
            nsdManager?.discoverServices("_adb-tls-connect._tcp.", NsdManager.PROTOCOL_DNS_SD, discoveryListener)
        } catch (e: Exception) {
            // NsdManager not supported or restricted
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        try {
            if (nsdManager != null && discoveryListener != null) {
                nsdManager?.stopServiceDiscovery(discoveryListener)
            }
        } catch (e: Exception) {
            // Discovery already stopped
        }
    }
}
