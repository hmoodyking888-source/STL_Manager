plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    // تم التأكد من مطابقة الـ namespace لاسم مشروعك
    namespace = "com.example.stl_manager"
    compileSdk = 35 

    // حذفنا رقم الـ NDK المحدد لترك النظام يختار النسخة المتوافقة تلقائياً
    
    defaultConfig {
        applicationId = "com.example.stl_manager"
        // رفعنا الـ minSdk لـ 23 ليتوافق مع مكتبات التخزين الآمن التي تستخدمها
        minSdk = 23
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"
        multiDexEnabled = true
    }

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