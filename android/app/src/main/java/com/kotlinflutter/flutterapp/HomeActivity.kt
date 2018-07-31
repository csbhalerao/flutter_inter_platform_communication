package com.kotlinflutter.flutterapp

import android.content.Intent
import android.os.Bundle
import android.util.Log

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.StringCodec
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel





class HomeActivity : FlutterActivity() {
    private val CHANNEL = "test_activity"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        Log.i("HomeActivity", "oncreate")
        MethodChannel(flutterView, CHANNEL).setMethodCallHandler(
                object : MethodCallHandler {
                    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
                        startNewActivity()
                    }
                })

    }

    private fun startNewActivity() {
        val intent = Intent(this, SecondActivity::class.java)
        startActivity(intent)
    }
}
