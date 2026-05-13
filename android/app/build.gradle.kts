plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.stl_manager"
    compileSdk = 36 // الترقية لـ 36 ضرورية جداً الآن

    defaultConfig {
        applicationId = "com.example.stl_manager"
        minSdk = 23
        targetSdk = 36 
        versionCode = 1
        versionName = "1.0"
        multiDexEnabled = true
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            isShrinkResources = false
            // استخدام debug لضمان البناء بدون ملف توقيع حالياً
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("androidx.multidex:multidex:2.0.1")
}