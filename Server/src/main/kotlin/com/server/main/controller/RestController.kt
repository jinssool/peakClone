package com.server.main.controller

import com.server.main.entity.Role
import com.server.main.entity.User
import com.server.main.entity.UserGeo
import com.server.main.form.*
import com.server.main.service.UserGeoService
import com.server.main.jwt.JwtTokenProvider
import com.server.main.service.UserService
import io.swagger.v3.oas.annotations.OpenAPIDefinition
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.geo.Point
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.web.bind.annotation.*
import java.sql.Date
import java.util.*
import kotlin.jvm.optionals.getOrNull

@CrossOrigin
@RestController
@OpenAPIDefinition
class DataController {

    @Autowired
    lateinit var userGeoService: UserGeoService

    @Autowired
    lateinit var userService: UserService

    @Autowired
    lateinit var passwordEncoder: PasswordEncoder

    @Autowired
    lateinit var jwtTokenProvider: JwtTokenProvider

    @PostMapping("/signup")
    @ResponseBody
    fun signup(@RequestHeader("Authorization") authorizationHeader: String): ResponseForm? {

        if(!authorizationHeader.startsWith("Basic ")){
            return ResponseForm("Invalid authorization header", null)
        }
        val base64Credentials = authorizationHeader.substring("Basic ".length).trim()
        val userSignup = String(Base64.getDecoder().decode(base64Credentials))
        println(userSignup)

        val (phone, nickname,birthday, password) = userSignup.split(":")
        println("$phone, $nickname,$birthday,$password")
        if(!userService.checkUser(phone)) {



            val newUser = User(phone, nickname, Date.valueOf(birthday), passwordEncoder.encode(password),null,Role.ROLE_USER)


            userService.insertUser(newUser)
            return ResponseForm("signup done", null)
        }
        else {
            return ResponseForm("duplicated", null)
        }
    }

    @PostMapping("/login")
    @ResponseBody
    fun login(@RequestHeader("Authorization") authorizationHeader: String): UserForm? {
        if(!authorizationHeader.startsWith("Basic ")){
            return UserForm("Invalid authorization header", null)
        }

        val base64Credentials = authorizationHeader.substring("Basic ".length).trim()
        val userLogin = String(Base64.getDecoder().decode(base64Credentials))

        val (phone, password) = userLogin.split(":")

        val foundUser:User?=userService.findUser(phone)

        if(passwordEncoder.matches(password, foundUser?.password)) {

            return UserForm("login done", foundUser!!, jwtTokenProvider.generateAccessToken(foundUser), jwtTokenProvider.generateRefreshToken(foundUser))
        }else if(foundUser==null){
            return UserForm("no user")
        }
        else {
            return UserForm("pw mismatch")
        }
    }

//    @GetMapping("/token/access")
//    @ResponseBody
//    fun validateAccessToken(@RequestHeader("Authorization") authorizationHeader: String): UserForm? {
//        if(!authorizationHeader.startsWith("Bearer ")){
//            return UserForm("Invalid authorization header", null)
//        }
//        val accessToken = authorizationHeader.substring("Bearer ".length).trim()
//        return if(jwtTokenProvider.validateToken(accessToken)
//            && jwtTokenProvider.refreshTokenRepository.existsById(jwtTokenProvider.getUserIdByAccessToken(accessToken).toLong()))
//            UserForm("login done")
//        else UserForm("invalid Access Token")
//
//    }
//
//    @GetMapping("/token/refresh")
//    @ResponseBody
//    fun validateRefreshToken(@RequestHeader("Authorization") authorizationHeader: String): UserForm? {
//        if(!authorizationHeader.startsWith("Bearer ")){
//            return UserForm("Invalid authorization header", null)
//        }
//        val refreshToken = authorizationHeader.substring("Bearer ".length).trim()
//        return if(jwtTokenProvider.validateToken(refreshToken))
//            UserForm("login done")
//        else UserForm("invalid Refresh Token")
//
//    }

    @PostMapping("/splash")
    @ResponseBody
    fun splash(@RequestHeader("Authorization") authorizationHeader: String): UserForm?{
        if(!authorizationHeader.startsWith("Bearer ")){
            return UserForm("Invalid authorization header",null)
        }

        val accessToken=authorizationHeader.substring("Bearer ".length).trim()
        println("0--------------------------------$accessToken")

       if(!jwtTokenProvider.validateToken(accessToken))
             return UserForm("reissue token")
             else{
                  val user =userService.findUserById( jwtTokenProvider.getUserIdByAccessToken(accessToken).toLong())
                println("0--------------------------------$user")
                 return UserForm("login done", user,null,null )
             }



    }

//    @PostMapping("/reissue")
//    @ResponseBody
//    fun reissueToken(@RequestHeader("Authorization") authorizationHeader: String): UserForm? {
//        if(!authorizationHeader.startsWith("Bearer ")) {
//            return UserForm("Invalid authorization header", null)
//        }
//        var accessToken = authorizationHeader.substring("Bearer ".length).trim()
//
//        val id = jwtTokenProvider.getUserIdByAccessToken(accessToken).toLong()
//
//        return if(jwtTokenProvider.validateToken(accessToken)) {
//            val foundUser: User? = userService.findUserById(id)
//            if (foundUser != null) {
//                val newAccessToken = jwtTokenProvider.generateAccessToken(foundUser)
//                val refreshToken = jwtTokenProvider.refreshTokenRepository.findById(id).toString()
//                UserForm("Login done", foundUser, newAccessToken, refreshToken)
//            } else {
//            UserForm("User not found")
//        }
//    } else {
//        val refreshToken = jwtTokenProvider.refreshTokenRepository.findById(id).getOrNull()
//
//        return if (refreshToken != null) {
//            val newAccessToken = jwtTokenProvider.generateAccessToken(userService.findUserById(id)!!)
//            UserForm("Reissue access token", accessToken = newAccessToken)
//        } else {
//            UserForm("Logout")
//        }
//    }
//
//}







    @GetMapping("/explore")
    @ResponseBody
    fun getProfileList(@RequestHeader("Authorization") authorizationHeader: String): UserListForm?{
         if(!authorizationHeader.startsWith("Bearer ")){
            return UserListForm("Invalid authorization header", null)
        }
        val accessToken = authorizationHeader.substring("Bearer ".length).trim()
        if(!jwtTokenProvider.validateToken(accessToken)){
            return null
        }
         val users=userService.getUsersList()
        val userDTOs=users.map{user-> UserDTO(nickname=user.nickname,birthday=user.birthday,bio=user.bio,longitude = null,latitude = null) }
        return UserListForm("userlist", userDTOs)
    }

    @PostMapping("/geo")
    @ResponseBody
    fun saveAndSearch(
        @RequestHeader("Authorization") authorizationHeader: String,
        @RequestBody coord : Coord
    ): UserListForm {
        print(coord);
        if(!authorizationHeader.startsWith("Bearer")){
            return UserListForm("Invalid authorization header", null)
        }
        val accessToken=authorizationHeader.substring("Bearer ".length).trim()
        if(!jwtTokenProvider.validateToken(accessToken)||jwtTokenProvider.getUserIdByAccessToken(accessToken)==null){
            return UserListForm("Invalid access token", null)
        }
        val id=jwtTokenProvider.getUserIdByAccessToken(accessToken)
        val point=Point(coord.longitude, coord.latitude     )
        val userGeo = UserGeo(id, point)
        userGeoService.saveUserGeo(userGeo)
        val usersWithinRadius = userGeoService.findUsersWithinRadius(point,0.05)
        println(usersWithinRadius)
        val UserDtos=usersWithinRadius?.map{UserGeo -> UserDTO(UserGeo.longitude,userGeo.latitude, userService.findUserById(UserGeo.id.toLong()))}
        println(UserDtos)

        return UserListForm("gps saved", UserDtos)
    }

    @PostMapping("/editProfile")
    @ResponseBody
    fun editProfile(
        @RequestHeader("Authorization") authorizationHeader: String,
        @RequestBody userForm: UserForm ):UserForm? {
        if(!authorizationHeader.startsWith("Bearer ")){
            return UserForm("Invalid authorization header", null)
        }
        val bio=userForm.bio
        val accessToken=authorizationHeader.substring("Bearer ".length).trim()
        println(jwtTokenProvider.getUserIdByAccessToken(accessToken))
        if(jwtTokenProvider.validateToken(accessToken) && jwtTokenProvider.refreshTokenRepository.existsById(jwtTokenProvider.getUserIdByAccessToken(accessToken).toLong())) {
            val user: User?=userService.findUserById(jwtTokenProvider.getUserIdByAccessToken(accessToken).toLong())
            println(user)
            user!!.bio=bio
            println(user.bio)
            userService.updateUser(user)

            return UserForm("edit done", user, accessToken, null)
        }
        else{
            return UserForm("invalid refresh token")
        }
    }

    @GetMapping("/test")
    fun test(@RequestHeader("Authorization") authorizationHeader: String): UserForm? {
        if(!authorizationHeader.startsWith("Bearer ")){
            return UserForm("Invalid authorization header", null)
        }

        val accessToken = authorizationHeader.substring("Bearer ".length).trim()
        println("asdfasdfasdfasdfasdfasdf------------------------+++++++++++++++++++++++++++++++++++ $accessToken")

        return if(jwtTokenProvider.validateToken(accessToken)
            && jwtTokenProvider.refreshTokenRepository.existsById(jwtTokenProvider.getUserIdByAccessToken(accessToken).toLong()))
            UserForm("ok")
        else UserForm("no")

    }

//     jwtTokenProvider 테스트용

//    @GetMapping("/jwttest")
//    @ResponseBody
//    fun jwtTest(): String {
//
//        val accessToken: String = jwtTokenProvider.generateAccessToken(1)
//        println("accessToken: $accessToken")
//
//        val refreshToken: String = jwtTokenProvider.generateRefreshToken(2)
//        println("refreshToken: $refreshToken")
//
//        return "$accessToken $refreshToken"

}