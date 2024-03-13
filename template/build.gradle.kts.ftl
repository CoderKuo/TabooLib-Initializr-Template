import org.jetbrains.kotlin.gradle.tasks.KotlinCompile
import io.izzel.taboolib.gradle.*

plugins {
    java
    id("io.izzel.taboolib") version "2.0.9"
    id("org.jetbrains.kotlin.jvm") version "1.8.22"
}

group="${group}"
version="1.0.0"

taboolib {
    env {
        // 安装模块
        <#list env.modules as module>
        install(${module.name}) <#if module.desc ??>//${module.desc}</#if>
        </#list>
    }
    classifier = null
    version { taboolib = "6.1.0" }
    <#if description ??>
    description {
        <#if description.name ??>
        name = "${description.name}"
        </#if>
        <#if description.contributors ??>
        contributors {
            <#list description.contributors as contributor>
            name("${contributor.name}")<#if contributor.description ??>.description("${contributor.description}")</#if>
            </#list>
        }
        </#if>
        <#if description.links ??>
        links {
            <#list description.links as link>
            name("${link.name}")<#if link.url ??>.url("${link.url}")</#if>
            </#list>
        }
        </#if>
        dependencies {
            name("PlaceholderAPI").optional(true)
        }
    }
    </#if>

}

repositories {
    mavenCentral()
}

dependencies {
    compileOnly("ink.ptms.core:v12004:12004:mapped")
    compileOnly("ink.ptms.core:v12004:12004:universal")
    compileOnly(kotlin("stdlib"))
    compileOnly(fileTree("libs"))
}

tasks.withType<JavaCompile> {
    options.encoding = "UTF-8"
}

tasks.withType<KotlinCompile> {
    kotlinOptions {
        jvmTarget = "1.8"
        freeCompilerArgs = listOf("-Xjvm-default=all")
    }
}

configure<JavaPluginConvention> {
    sourceCompatibility = JavaVersion.VERSION_1_8
    targetCompatibility = JavaVersion.VERSION_1_8
}
