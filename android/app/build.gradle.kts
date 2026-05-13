plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.stl_manager"
    
    // التعديل المطلوب: رفعه إلى 36 كما طلبت رسالة الخطأ
    compileSdk = 36 

    ndkVersion = "28.2.13676358"

    defaultConfig {
        applicationId = "com.example.stl_manager"
        minSdk = 23
        
        // رفعه أيضاً لـ 36 لضمان التوافق التام
        targetSdk = 36 
        
        versionCode = 1
        versionName = "1.0"
        multiDexEnabled = true

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