package com.muslim.muaazin

import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.view.FlutterNativeView

val CHANNEL_NAME ="send_app_to_background"
class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_NAME).setMethodCallHandler { call, result ->
            if (call.method.equals("sendToBackground")) {
                moveTaskToBack(true)

            }else{
                result.notImplemented()
            }
        }
    }


    override fun onDestroy() {
        super.onDestroy()
        moveTaskToBack(true)
    }
}
