// === Force all repositories (including included builds) to use your Nexus ===
val nexusUrl = uri("https://repo.notavaa.com/repository/maven-public/")

settingsEvaluated {
    // Force pluginManagement (plugins { ... })
    pluginManagement {
        repositories.clear()
        repositories.maven { url = nexusUrl }
    }
    // Force dependencyResolutionManagement (settings-level repos)
    dependencyResolutionManagement {
        repositoriesMode.set(RepositoriesMode.PREFER_SETTINGS)
        repositories.clear()
        repositories.maven { url = nexusUrl }
    }
}

gradle.beforeProject {
    // buildscript {} repositories (legacy)
    buildscript.repositories.clear()
    buildscript.repositories.maven { setUrl(nexusUrl) }

    // project repositories (allprojects/subprojects)
    repositories.clear()
    repositories.maven { setUrl(nexusUrl) }
}

