package com.server.main.service

import com.server.main.firebase.FCMService
import com.server.main.firebase.NotificationRequest
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import java.util.concurrent.ExecutionException

@Service
class NotificationServiceImpl(private val fcmService: FCMService) {
    private val tokenMap: MutableMap<Long, String> = HashMap()

    fun register(userId: Long, token: String) {
        tokenMap[userId] = token
    }

    fun deleteToken(userId: Long) {
        tokenMap.remove(userId)
    }

    fun getToken(userId: Long): String? {
        return tokenMap[userId]
    }

    fun sendNotification(request: NotificationRequest?) {
        try {
            fcmService.send(request!!)
        } catch (e: InterruptedException) {
            logger.error(e.message)
        } catch (e: ExecutionException) {
            logger.error(e.message)
        }
    }

    companion object {
        private val logger = LoggerFactory.getLogger(NotificationServiceImpl::class.java)
    }
}