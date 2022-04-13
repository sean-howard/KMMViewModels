package com.example.viewmodelsample

import kotlinx.coroutines.flow.MutableStateFlow

class PickerViewModel {

    private companion object {
        const val changeValue: Float = 50.0f
    }

    private val _xOffset = MutableStateFlow(0.0f)

    var xOffset: CFlow<Float> = _xOffset.wrap()
        private set

    fun increment() {
        _xOffset.value += changeValue
    }

    fun decrement() {
        _xOffset.value -= changeValue
    }
}