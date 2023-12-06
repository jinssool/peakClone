package com.server.main.service

import com.server.main.entity.User
import com.server.main.repository.UserRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@Service
class UserServiceImpl : UserService {

    @Autowired
    lateinit var repository : UserRepository

    override fun insertUser(user: User) {
        repository.save(user)
    }

    override fun updateUser(user: User) {
        repository.save(user)
    }

    override fun deleteUser(user: User) {
        repository.delete(user)
    }

   override fun checkUser(phone: String): Boolean {
      return repository.findByPhone(phone) != null
   }

    override fun findUser(phone: String): User? {
        return repository.findByPhone(phone)
    }

    override fun findUserById(id: Long): User? {
        return repository.findById(id).orElse(null)
    }

    override fun getUsersList(): List<User> {
        return repository.findAll()
    }

    override fun deleteAllUsers() {
        repository.deleteAll()
    }
}