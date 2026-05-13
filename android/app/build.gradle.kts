plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.stl_manager"
    compileSdk = 35 

    ndkVersion = "28.2.13676358"

    defaultConfig {
        applicationId = "com.example.stl_manager"
        minSdk = 23
        targetSdk = 35 
        versionCode = 1
        versionName = "1.0"
        multiDexEnabled = true

        // إجبار النظام على معمارية الهواتف فقط لتجنب خطأ jni
        ndk {
            abiFilters.add("arm64-v8a")
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            isShrinkResources = false
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