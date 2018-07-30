package com.kotlinflutter.flutterapp

import android.content.Intent
import android.os.Bundle
import android.support.design.widget.FloatingActionButton
import android.support.v7.app.AppCompatActivity
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BasicMessageChannel.MessageHandler
import io.flutter.plugin.common.StringCodec
import io.flutter.view.FlutterMain
import io.flutter.view.FlutterView
import java.util.*
import android.widget.TextView




class MainActivity() : AppCompatActivity() {
    private var flutterView: FlutterView? = null
    private var counter: Int = 0
    private val CHANNEL = "increment"
    private val EMPTY_MESSAGE = ""
    private val PING = "ping"
    private var messageChannel: BasicMessageChannel<String>? = null

    private fun getArgsFromIntent(intent: Intent): Array<String>? {
        // Before adding more entries to this list, consider that arbitrary
        // Android applications can generate intents with extra data and that
        // there are many security-sensitive args in the binary.
        val args = ArrayList<String>()
        if (intent.getBooleanExtra("trace-startup", false)) {
            args.add("--trace-startup")
        }
        if (intent.getBooleanExtra("start-paused", false)) {
            args.add("--start-paused")
        }
        if (intent.getBooleanExtra("enable-dart-profiling", false)) {
            args.add("--enable-dart-profiling")
        }
        if (!args.isEmpty()) {
            val argsArray = arrayOfNulls<String>(args.size)
            return args.toArray(argsArray)
        }
        return null
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val args = getArgsFromIntent(intent)
        FlutterMain.ensureInitializationComplete(applicationContext, args)
        setContentView(R.layout.flutter_view_layout)
        val supportActionBar = supportActionBar
        supportActionBar?.hide()

        flutterView = findViewById(R.id.flutter_view)
        flutterView?.runFromBundle(FlutterMain.findAppBundlePath(applicationContext), null)

        messageChannel = BasicMessageChannel(flutterView, CHANNEL, StringCodec.INSTANCE)
        messageChannel?.setMessageHandler(MessageHandler { s, reply ->
            onFlutterIncrement()
            reply.reply(EMPTY_MESSAGE)
        })

        val fab = findViewById<FloatingActionButton>(R.id.button)
        fab.setOnClickListener { sendAndroidIncrement() }

    }

    private fun sendAndroidIncrement() {
        messageChannel?.send(PING)
    }

    private fun onFlutterIncrement() {
        counter++
        val textView = findViewById<TextView>(R.id.button_tap)
        val value = "Flutter button tapped " + counter + if (counter === 1) " time" else " times"
        textView.setText(value)
    }

    override fun onDestroy() {
        if (flutterView != null) {
            flutterView?.destroy()
        }
        super.onDestroy()
    }

    override fun onPause() {
        super.onPause()
        flutterView?.onPause()
    }

    override fun onPostResume() {
        super.onPostResume()
        flutterView?.onPostResume()
    }
}
