allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// Taruh di PALING BAWAH file android/build.gradle.kts
// Taruh di PALING BAWAH file android/build.gradle.kts (Level Root Project)
subprojects {
    project.evaluationDependsOn(":app")
    
    if (project.name == "isar_flutter_libs") {
        // 1. Suntik namespace otomatis ke Isar
        plugins.withId("com.android.library") {
            configure<com.android.build.gradle.LibraryExtension> {
                namespace = "dev.isar.isar_flutter_libs"
            }
        }
        
        // 2. Trik Pamungkas: Paksa hapus atribut 'package' dari AndroidManifest milik Isar sebelum dicompile
        tasks.matching { it.name.contains("process") && it.name.contains("Manifest") }.configureEach {
            doFirst {
                val manifestFile = file("src/main/AndroidManifest.xml")
                if (manifestFile.exists()) {
                    var content = manifestFile.readText()
                    // Kita cari tulisan package="..." lalu kita hapus total lewat regex
                    if (content.contains("package=")) {
                        content = content.replace(Regex("""package="[^"]*""""), "")
                        manifestFile.writeText(content)
                    }
                }
            }
        }
    }
}