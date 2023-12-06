package com.server.main.service

import com.server.main.firebase.NotificationRequest


interface NotificationService {
    fun register(userId: Long, token: String)

    fun deleteToken(userId: Long)

    fun getToken(userId: Long): String?
    fun sendNotification(request: NotificationRequest?)
}
