package com.server.main.config

import com.server.main.jwt.JwtAuthenticationFilter
import com.server.main.jwt.JwtTokenProvider
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.invoke
import org.springframework.security.config.http.SessionCreationPolicy
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.security.web.SecurityFilterChain
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter

@Configuration
class SecurityConfig {
    @Bean
    fun getJwtTokenProvider(): JwtTokenProvider = JwtTokenProvider()

    @Bean
    fun securityFilterChain(http: HttpSecurity): SecurityFilterChain {
        http.invoke {
            authorizeRequests {
                authorize("/signup", permitAll)
                authorize("/login", permitAll)
                authorize("/**", permitAll)
            }
            csrf { disable() } // Cross-Site Request Forgery
            cors {} // Cross-Origin Resource Sharing
            sessionManagement { SessionCreationPolicy.STATELESS }
            formLogin { disable() } // Spring Security Login Page disable
            httpBasic { disable() }
            addFilterBefore<UsernamePasswordAuthenticationFilter>(JwtAuthenticationFilter(JwtTokenProvider()))
        }

        return http.build()
    }
    @Bean
    fun getPasswordEncoder(): PasswordEncoder = BCryptPasswordEncoder()
}