package com.server.main.entity

import org.springframework.data.annotation.Id
import org.springframework.data.redis.core.RedisHash

@RedisHash(value = "refreshtoken", timeToLive = 3600) // key: value + @Id, expiration: 60 seconds
class RefreshToken(@Id val id: Long, val refreshToken: String) {
    override fun toString(): String {
        return "id: $id / refreshToken: $refreshToken"
    }
}