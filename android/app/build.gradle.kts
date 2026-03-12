plugins {
    id("com.android.application")
    kotlin("android")
    id("dev.flutter.flutter-gradle-plugin") // لازم بعد Android و Kotlin
}

// تفعيل Google Services بعد كل البلجنات
apply(plugin = "com.google.gms.google-services")

android {
    namespace = "com.example.joride_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    defaultConfig {
        applicationId = "com.example.joride_app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // تفعيل MultiDex
        multiDexEnabled = true
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // MultiDex مكتبة حديثة متوافقة مع AndroidX
    implementation("androidx.multidex:multidex:2.0.1")

    // باقي dependencies الخاصة بمشروعك (Firebase وغيرها)
    // مثال:
    // implementation("com.google.firebase:firebase-analytics-ktx:21.2.0")
}