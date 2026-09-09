package com.andikatp.devkit

import android.content.Context
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
            if (call.method == "checkWriteSecureSettings") {
                val isGranted = checkSelfPermission(android.Manifest.permission.WRITE_SECURE_SETTINGS) == PackageManager.PERMISSION_GRANTED
                result.success(isGranted)
            } else {
                result.notImplemented()
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
                    try {
                        val targetValue = if (enabled) 1 else 0
                        val written = Settings.Global.putInt(contentResolver, Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, targetValue)
                        val actualValue = Settings.Global.getInt(contentResolver, Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, 0)
                        val isSuccess = written && (actualValue == targetValue)
                        result.success(isSuccess)
                    } catch (e: Exception) {
                        result.success(false)
                    }
                }
                "setUsbDebugging" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    try {
                        val targetValue = if (enabled) 1 else 0
                        val written = Settings.Global.putInt(contentResolver, Settings.Global.ADB_ENABLED, targetValue)
                        val actualValue = Settings.Global.getInt(contentResolver, Settings.Global.ADB_ENABLED, 0)
                        val isSuccess = written && (actualValue == targetValue)
                        result.success(isSuccess)
                    } catch (e: Exception) {
                        result.success(false)
                    }
                }
                "setWirelessDebugging" -> {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    try {
                        val targetValue = if (enabled) 1 else 0
                        val written = Settings.Global.putInt(contentResolver, "adb_wifi_enabled", targetValue)
                        val actualValue = try {
                            Settings.Global.getInt(contentResolver, "adb_wifi_enabled", 0)
                        } catch (e: Exception) {
                            0
                        }
                        val isSuccess = written && (actualValue == targetValue)
                        result.success(isSuccess)
                    } catch (e: Exception) {
                        result.success(false)
                    }
                }
                else -> result.notImplemented()
            }
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


