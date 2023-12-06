package com.server.main.form

import com.server.main.entity.Role
import com.server.main.entity.User
import java.util.*

data class UserForm(
    var message: String? = null,
    var phone: String? = null,
    var nickname: String? = null,
    var birthday: Date? = null,
    var password: String? = null,
    var role: Role? = null,
    var accessToken: String? = null,
    var refreshToken: String? = null,
    var bio: String?=null
) {
    constructor(message: String, user: User?, accessToken:String?,refreshToken: String? ) : this(
        message,
        user?.phone,
        user?.nickname,
        user?.birthday,
        user?.password,
        user?.role,
        accessToken, // Initialize accessToken and refreshToken as null
        refreshToken,
        user?.bio
    )
}
