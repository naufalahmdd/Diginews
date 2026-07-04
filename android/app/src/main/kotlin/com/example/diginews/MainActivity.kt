package com.example.diginews

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.diginews/nim_reverser"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "reverseNIM") {
                val nim = call.argument<String>("nim")
                if (nim != null) {
                    // Logika membalikkan string NIM menggunakan fungsi bawaan Kotlin
                    val reversedNIM = nim.reversed()
                    result.success(reversedNIM)
                } else {
                    result.error("INVALID_ARGUMENT", "NIM tidak boleh kosong", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}