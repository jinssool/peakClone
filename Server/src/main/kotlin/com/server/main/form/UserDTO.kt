package com.server.main.form

import com.server.main.entity.Role
import com.server.main.entity.User
import java.util.*

data class UserDTO(
    val nickname: String?,
    val birthday: Date?,
    val bio: String?,
    val longitude: Double?,
    val latitude: Double?)
{
     constructor(longitude: Double?,latitude: Double?, user: User? ) : this(
        user?.nickname,
        user?.birthday,
        user?.bio,
         longitude,
         latitude
    )
}
