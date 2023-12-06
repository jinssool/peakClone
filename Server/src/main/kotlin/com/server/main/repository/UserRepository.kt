package com.server.main.repository

import com.server.main.entity.User
import org.springframework.data.jpa.repository.JpaRepository

interface UserRepository : JpaRepository<User, Long> {
    fun findByPhone(phone: String): User?
}