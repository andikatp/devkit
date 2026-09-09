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
                    result.success(writeGlobalInt(Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, targetVal))
                }
                "setUsbDebugging" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val targetVal = if (enabled) 1 else 0
                    result.success(writeGlobalInt(Settings.Global.ADB_ENABLED, targetVal))
                }
                "setWirelessDebugging" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val targetVal = if (enabled) 1 else 0
                    result.success(writeGlobalInt("adb_wifi_enabled", targetVal))
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
                "setShowTaps" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val targetVal = if (enabled) 1 else 0
                    result.success(writeSystemInt("show_touches", targetVal))
                }
                "setPointerLocation" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val targetVal = if (enabled) 1 else 0
                    result.success(writeSystemInt("pointer_location", targetVal))
                }
                "setStayAwake" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val targetVal = if (enabled) 7 else 0
                    result.success(writeGlobalInt(Settings.Global.STAY_ON_WHILE_PLUGGED_IN, targetVal))
                }
                "setDemoMode" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val targetVal = if (enabled) 1 else 0
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
                    result.success(writeGlobalInt("sysui_demo_allowed", targetVal))
                }
                "setForceDarkMode" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val targetVal = if (enabled) 2 else 1
                    result.success(writeSecureInt("ui_night_mode", targetVal))
                }
                "setFontScale" -> {
                    val scale = (call.argument<Double>("scale") ?: 1.0).toFloat()
                    result.success(writeSystemFloat("font_scale", scale))
                }
                "setAnimationScale" -> {
                    val scale = (call.argument<Double>("scale") ?: 1.0).toFloat()
                    val s1 = writeGlobalFloat(Settings.Global.WINDOW_ANIMATION_SCALE, scale)
                    val s2 = writeGlobalFloat(Settings.Global.TRANSITION_ANIMATION_SCALE, scale)
                    val s3 = writeGlobalFloat(Settings.Global.ANIMATOR_DURATION_SCALE, scale)
                    result.success(s1 && s2 && s3)
                }
                "setGpuProfiling" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val targetVal = if (enabled) "visual_bars" else "false"
                    result.success(writeGlobalString("track_frame_time", targetVal))
                }
                "setStrictMode" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val targetVal = if (enabled) 1 else 0
                    result.success(writeSystemInt("strict_mode_visual", targetVal))
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun writeGlobalInt(key: String, value: Int): Boolean {
        return try {
            val success = Settings.Global.putInt(contentResolver, key, value)
            val readback = Settings.Global.getInt(contentResolver, key, -1)
            success && readback == value
        } catch (e: Exception) {
            false
        }
    }

    private fun writeSystemInt(key: String, value: Int): Boolean {
        return try {
            val success = Settings.System.putInt(contentResolver, key, value)
            val readback = Settings.System.getInt(contentResolver, key, -1)
            success && readback == value
        } catch (e: Exception) {
            false
        }
    }

    private fun writeSecureInt(key: String, value: Int): Boolean {
        return try {
            val success = Settings.Secure.putInt(contentResolver, key, value)
            val readback = Settings.Secure.getInt(contentResolver, key, -1)
            success && readback == value
        } catch (e: Exception) {
            false
        }
    }

    private fun writeGlobalString(key: String, value: String): Boolean {
        return try {
            val success = Settings.Global.putString(contentResolver, key, value)
            val readback = Settings.Global.getString(contentResolver, key)
            success && readback == value
        } catch (e: Exception) {
            false
        }
    }

    private fun writeSystemFloat(key: String, value: Float): Boolean {
        return try {
            val success = Settings.System.putFloat(contentResolver, key, value)
            val readback = Settings.System.getFloat(contentResolver, key, -1f)
            success && Math.abs(readback - value) < 0.05f
        } catch (e: Exception) {
            false
        }
    }

    private fun writeGlobalFloat(key: String, value: Float): Boolean {
        return try {
            val success = Settings.Global.putFloat(contentResolver, key, value)
            val readback = Settings.Global.getFloat(contentResolver, key, -1f)
            success && Math.abs(readback - value) < 0.05f
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
