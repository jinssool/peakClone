package com.server.main.service

import com.server.main.entity.User
import com.server.main.jwt.UserDetailsImpl
import com.server.main.repository.UserRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.stereotype.Service
import java.lang.Exception

@Service
class UserDetailsServiceImpl: UserDetailsService {

    @Autowired
    lateinit var userRepository: UserRepository
    override fun loadUserByUsername(id: String?): UserDetails {
        var user: User = userRepository.findById(id!!.toLong()).get() ?: throw Exception("NO USER")

        return UserDetailsImpl(user)
    }
}