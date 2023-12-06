package com.server.main.controller

import com.server.main.service.UserService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping

@Controller
class Controller {

    @Autowired
    lateinit var userService: UserService

    @GetMapping("/login")
    fun index(): String {
        return "index"
    }

}