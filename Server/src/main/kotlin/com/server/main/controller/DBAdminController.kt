package com.server.main.controller

import com.server.main.entity.Hobby
import com.server.main.entity.Role
import com.server.main.entity.User
import com.server.main.service.UserService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import java.sql.Date
import java.text.SimpleDateFormat
import kotlin.random.Random
import kotlin.random.nextInt

@Controller
@RequestMapping("/dbAdmin")
class DBAdminController {

    @Autowired
    private lateinit var userService: UserService

    @Autowired
    lateinit var passwordEncoder: PasswordEncoder // 비밀번호 암호화

    private val dummyName: String = "LK"
    private val dummyPhone: String = "010"
    private val count: Int
        get() = userService.getUsersList().filter { it -> it.nickname.contains(dummyName) }.size

    @GetMapping
    fun showDBAdminPage(): String {
        return "admin/dbAdminPage"
    }

    @GetMapping("*")
    fun redirect(): String {
        return "redirect:/dbAdmin"
    }

    // users 테이블 내용 콘솔에 출력
    @GetMapping("/showDB")
    fun showDB(): String {
        val userList = userService.getUsersList()
        println("---------------------------- USERS TABLE LIST ----------------------------")
        if(userList.isNotEmpty()) {
            for (user in userList) {
                println(user)
            }
        } else {
            println("EMPTY TABLE")
        }
        println("---------------------------- USERS TABLE DONE ----------------------------")
        return "redirect:/dbAdmin"
    }

    // users table 데이터 초기화 (AUTO_INCREMENT 초기화 안됨)
    @GetMapping("/cleanDB")
    fun cleanUsersTable(): String? {
        userService.deleteAllUsers()
        println("-------------------------- DELETE ALL USERS DONE -------------------------")
        return "redirect:/dbAdmin"
    }

    // users table 더미 데이터 추가
    @GetMapping("/addDummyData")
    fun addDummyData(): String? {

        /* 비밀번호 암호화 테스트 */
        var randPw = Random.nextInt(1000..9999).toString()

        // encode(): 단방향 암호화 (복호화 불가능)
        var randPwEncoded = passwordEncoder.encode(randPw)

        // matches(): 일치 여부 확인
        if(passwordEncoder.matches(randPw, randPwEncoded)) {
            println("PASSWORD ENCODE: $randPw -> $randPwEncoded")
        }

        val randAge = Random.nextInt(1..99)

        // 1. String -> java.util.Date -> java.sql.Date -> stored in DB
        var dateString = "2023-08-25"
        var birthday = SimpleDateFormat("yyyy-MM-dd").parse(dateString)
        var sqlDate = Date(birthday.time)
//        println(sqlDate)

        // 2. java.sql.Date.valueOf(String)
        println(Date.valueOf(dateString))

        val user: User = User("$dummyPhone${count + 1}","$dummyName${count + 1}", Date.valueOf("2023-08-25"), randPwEncoded, null, Role.ROLE_USER)

        // add hobbies in hobby list
        user.addHobby(Hobby("programming", user))
        user.addHobby(Hobby("traveling", user))
        println(user)

        //delete hobbies in hobby list by hobbyName
        user.deleteHobby("programming")
        println(user)

        userService.insertUser(user)

        return "redirect:/dbAdmin"
    }
}