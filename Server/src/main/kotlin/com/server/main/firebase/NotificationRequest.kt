package com.server.main.firebase

data class NotificationRequest(
    val title: String,
    val message: String,
    val token: String
)