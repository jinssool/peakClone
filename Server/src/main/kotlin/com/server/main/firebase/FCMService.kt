package com.server.main.firebase

import com.google.firebase.messaging.FirebaseMessaging
import com.google.firebase.messaging.Message
import com.google.firebase.messaging.WebpushConfig
import com.google.firebase.messaging.WebpushNotification
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import java.util.concurrent.ExecutionException

@Service
class FCMService {
    @Throws(InterruptedException::class, ExecutionException::class)
    fun send(notificationRequest: NotificationRequest) {
        val message = Message.builder()
            .setToken(notificationRequest.token)
            .setWebpushConfig(
                WebpushConfig.builder().putHeader("ttl", "300")
                    .setNotification(
                        WebpushNotification(
                            notificationRequest.title,
                            notificationRequest.message
                        )
                    )
                    .build()
            )
            .build()
        val response = FirebaseMessaging.getInstance().sendAsync(message).get()
        logger.info("Sent message: $response")
    }

    companion object {
        private val logger = LoggerFactory.getLogger(FCMService::class.java)
    }
}