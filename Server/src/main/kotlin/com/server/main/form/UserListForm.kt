package com.server.main.form

import com.server.main.entity.User
import java.util.*

data class UserListForm(val message:String?, val users: List<UserDTO>?
) {}