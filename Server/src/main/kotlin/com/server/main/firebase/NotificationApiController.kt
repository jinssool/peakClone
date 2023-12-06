package com.server.main.firebase

import com.server.main.entity.User
import com.server.main.service.NotificationServiceImpl
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;


@RestController
class NotificationApiController(private val notificationService: NotificationServiceImpl) {

    @PostMapping("/register")  //login에 들어가면 될듯
    fun register(@RequestBody token: String?, user: User): ResponseEntity<*> {
        notificationService.register(user.id!!, token!!)   //user.getId()에 들어갈만한 값 뭐잇는지 물어보기.. (userSession(로그인된 유저).getId()등을 넣을 수 있음)
        return ResponseEntity.ok().build<Any>()
    }
}