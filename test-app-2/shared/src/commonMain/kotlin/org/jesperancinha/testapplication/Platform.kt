package org.jesperancinha.testapplication

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform