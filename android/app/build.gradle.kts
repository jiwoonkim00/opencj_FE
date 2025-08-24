plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.opencj_fe"
    compileSdk = flutter.compileSdkVersion.toInt()    // ✅ .toInt() 권장
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.opencj_fe"
        minSdk = maxOf(23, flutter.minSdkVersion.toInt()) // ✅ 네이버맵은 23+
        targetSdk = flutter.targetSdkVersion.toInt()       // ✅ .toInt() 권장 (또는 34)
        versionCode = 1
        versionName = "1.0.0"
    }

    buildTypes {
        release {
            // 시연용: debug 키로 서명
            signingConfig = signingConfigs.getByName("debug")
            // isMinifyEnabled = false  // 필요시
        }
    }
}

flutter {
    source = "../.."
}
