plugins {
    id("com.android.application")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.diginews"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.example.diginews"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        
        // Default app name
        resValue("string", "app_name", "DigiNews")
    }

    // TANTANGAN FLAVOR: Kita buat Product Flavors resmi di sisi Android
    flavorDimensions.add("mode")
    productFlavors {
        create("dev") {
            dimension = "mode"
            applicationIdSuffix = ".dev"
            resValue("string", "app_name", "DigiNews DEV")
        }
        create("prod") {
            dimension = "mode"
            resValue("string", "app_name", "DigiNews")
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
