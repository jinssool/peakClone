package com.server.main.jwt

import com.server.main.entity.RefreshToken
import com.server.main.entity.Role
import com.server.main.entity.User
import com.server.main.repository.RefreshTokenRepository
import com.server.main.service.UserDetailsServiceImpl
import io.jsonwebtoken.Claims
import io.jsonwebtoken.Jwts
import io.jsonwebtoken.SignatureAlgorithm
import io.jsonwebtoken.io.Decoders
import io.jsonwebtoken.security.Keys
import jakarta.annotation.PostConstruct
import jakarta.servlet.http.HttpServletRequest
import jakarta.servlet.http.HttpServletResponse
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.beans.factory.annotation.Value
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.stereotype.Component
import org.springframework.util.StringUtils
import java.security.Key
import java.util.*

@Component
class JwtTokenProvider {

    @Value("\${jwt.secret-key}")
    private lateinit var key: String

    private val expiration: Long = 60000 * 30L // 30 minutes

    private val refresh_expiration: Long = 60000 * 60 * 24 * 14L // 2 weeks

    private val AUTHORIZATION_HEADER: String = "Authorization"

    private val TOKEN_PREFIX: String = "Bearer "

    private lateinit var secretKey: Key

    @PostConstruct
    fun setSecretKey() {
        secretKey = Keys.hmacShaKeyFor(Decoders.BASE64.decode(key))
    }

    @Autowired
    lateinit var userDetailsServiceImpl: UserDetailsServiceImpl

    @Autowired
    lateinit var refreshTokenRepository: RefreshTokenRepository

    // generate access token
    fun generateAccessToken(user: User): String {
        val now = Date()
        var claims: Claims = Jwts.claims().setSubject("access_token")
            .setIssuedAt(now)
            .setExpiration(Date(now.time.plus(expiration)))

        claims["id"] = user.id
        claims["phone"] = user.phone
        claims["nickname"] = user.nickname
        claims["birth"] = user.birthday
        claims["password"] = user.password
        claims["role"] = user.role
        claims["bio"]=user.bio


        return Jwts.builder()
            .setHeaderParam("typ", "JWT")
            .setClaims(claims)
            .setIssuer("server")
            .signWith(secretKey, SignatureAlgorithm.HS512)
            .compact()!!
    }

    // generate refresh token
    fun generateRefreshToken(user: User): String {
        val now = Date()
        var claims: Claims = Jwts.claims().setSubject("refresh_token")
            .setIssuedAt(now)
            .setExpiration(Date(now.time.plus(refresh_expiration)))

        claims["id"] = user.id
        claims["nickname"] = user.nickname

        var refreshToken = RefreshToken(user.id!!, Jwts.builder()
            .setHeaderParam("typ", "JWT")
            .setClaims(claims)
            .setIssuer("server")
            .signWith(secretKey, SignatureAlgorithm.HS512)
            .compact()!!)

        refreshTokenRepository.save(refreshToken)
        println("RefreshToken save : "+refreshTokenRepository.findById(user.id!!).get())

        return refreshToken.refreshToken
    }

    // extract phone from access token
    fun getUserIdByAccessToken(accessToken: String): String {
        val claims: Claims = Jwts.parserBuilder()
            .setSigningKey(secretKey)
            .build()
            .parseClaimsJws(accessToken).body

        return claims["id"].toString()
    }

    fun getAuthentication(token: String): UsernamePasswordAuthenticationToken {
        val userDetails: UserDetails = userDetailsServiceImpl.loadUserByUsername(getUserIdByAccessToken(token))
        return UsernamePasswordAuthenticationToken(userDetails, "", userDetails.authorities)
    }

    // validate token
    fun validateToken(token: String): Boolean {
        val claims: Claims = Jwts.parserBuilder()
                .setSigningKey(secretKey)
            .build()
            .parseClaimsJws(token)
            .body

        return !claims.expiration.before(Date())
    }

    fun parseBearerToken(request: HttpServletRequest): String? {
        val bearerToken = request.getHeader(AUTHORIZATION_HEADER)
        return if (StringUtils.hasText(bearerToken) && bearerToken.startsWith(TOKEN_PREFIX)) {
            bearerToken.substring(TOKEN_PREFIX.length)
        } else null
    }

//    fun setHeaderTokens(response: HttpServletResponse, accessToken: String, refreshToken: String) {
//        setHeaderAccessToken(response, accessToken)
//        setHeaderRefreshToken(response, refreshToken)
//    }
//
//    fun setHeaderRefreshToken(response: HttpServletResponse, refreshToken: String) {
//        response.setHeader(REFRESH_HEADER, "$TOKEN_PREFIX $refreshToken")
//    }
//
//    fun setHeaderAccessToken(response: HttpServletResponse, accessToken: String) {
//        response.setHeader(AUTHORIZATION_HEADER, "$TOKEN_PREFIX $accessToken")
//    }

}