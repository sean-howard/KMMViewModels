package com.example.viewmodelsample

class Greeting {
    fun greeting(): String {
        return "Hello, ${Platform().platform}!"
    }
}
