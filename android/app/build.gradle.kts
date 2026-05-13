plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.stl_manager"
    compileSdk = 36 // تم التحديث لـ 36 بناءً على طلب النظام

    ndkVersion = "28.2.13676358" // تم التحديث بناءً على طلب النظام

    defaultConfig {
        applicationId = "com.example.stl_manager"
        minSdk = 23
        targetSdk = 36 // تم التحديث لـ 36
        versionCode = 1
        versionName = "1.0"
        multiDexEnabled = true
    }
    // ... باقي الكود كما هو    }

    buildTypes {
        release {
            // سنبقيها debug حالياً للتجربة، ولكن تأكد من إعداد مفتاح حقيقي لاحقاً
            signingConfig = signingConfigs.getByName("debug")
            minifyEnabled = false
            shrinkResources = false
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
    // إضافة مكتبة التوافق لدعم العدد الكبير من المكتبات في مشروعك
    implementation("androidx.multidex:multidex:2.0.1")
}