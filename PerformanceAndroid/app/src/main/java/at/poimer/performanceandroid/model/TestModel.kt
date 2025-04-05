package at.poimer.performanceandroid.model

import kotlinx.serialization.Serializable

@Serializable
data class TestModel(
    val name: String,
    val language: String,
    val id: String,
    val bio: String,
    val version: Double
)