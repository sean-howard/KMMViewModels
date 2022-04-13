package com.example.viewmodelsample

import kotlinx.coroutines.*
import kotlinx.coroutines.flow.*

data class Band(val id: String, val members: MutableList<Member>)
data class Member(val name: String)

class MockBandViewModel {

    private companion object {
        val dataSource = listOf("John", "Paul", "George", "Ringo")
    }

    private var band = Band(id = "", members = mutableListOf())

    private val _bandFlow = MutableStateFlow(band)

    val bandFlow: StateFlow<Band> = _bandFlow

    var cBandFlow: CFlow<Band> = _bandFlow.wrap()
        private set

    val scope = MainScope()

    init {
        load()
    }

    private fun load() {
        scope.launch {
            dataSource
                .asFlow()
                .onEach {
                    delay(1000)
                }
                .map { createMember(it) }
                .collect {
                    band.members.add(it)
                    println(band)
                    _bandFlow.emit(band)
                }
        }
    }

    private fun createMember(name: String): Member {
        return Member(name = name)
    }
}