package com.example.test_map

import androidx.annotation.NonNull
import com.yandex.mapkit.MapKitFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    @Override
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("0b71c593-a64e-4a3d-b2b9-1019d4caae60")
        super.configureFlutterEngine(flutterEngine)
    }
}
