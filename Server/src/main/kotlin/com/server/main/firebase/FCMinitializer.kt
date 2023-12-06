package com.server.main.firebase

import com.google.auth.oauth2.GoogleCredentials
import com.google.firebase.FirebaseApp
import com.google.firebase.FirebaseOptions
import javax.annotation.PostConstruct
import org.slf4j.LoggerFactory
import org.springframework.core.io.ClassPathResource
import org.springframework.stereotype.Service
import java.io.*


@Service
class FCMInitializer {

    companion object {
        private val logger = LoggerFactory.getLogger(FCMInitializer::class.java)
        private const val FIREBASE_CONFIG_PATH = "C:\\Users\\parkSJ\\Desktop\\p\\Peaktew\\Server\\src\\main\\resources\\push.json"
    }

    @PostConstruct
    fun initialize() {
        try {
            val options = FirebaseOptions.Builder()
                .setCredentials(
                    GoogleCredentials.fromStream(
                        ClassPathResource(
                            FIREBASE_CONFIG_PATH
                        ).inputStream
                    )
                )
                .build()
            if (FirebaseApp.getApps().isEmpty()) {
                FirebaseApp.initializeApp(options)
                logger.info("Firebase application has been initialized")
            }
        } catch (e: IOException) {
            logger.error(e.message)
        }
    }
}