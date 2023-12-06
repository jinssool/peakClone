package com.server.main.service

import com.server.main.entity.User

interface UserService {
    fun insertUser(user: User)
    fun updateUser(user: User)
    fun deleteUser(user: User)
    fun checkUser(nickname: String): Boolean
    fun findUser(nickname: String): User?
    fun findUserById(Id: Long): User?
    fun getUsersList(): List<User>
    fun deleteAllUsers()
}