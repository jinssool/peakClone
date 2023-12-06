package com.server.main.entity

import jakarta.persistence.*
import org.springframework.format.annotation.DateTimeFormat
import java.sql.Date

@Table(name = "users") // table name
@Entity
class User(phone: String, nickname: String, birthday: Date, password: String, bio: String?, role: Role) {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    val id : Long? = null

    @Column(name = "phone")
    var phone: String = phone

    @Column(name = "nickname")
    var nickname: String = nickname

    @Column(name = "birthday")
    @DateTimeFormat(style = "YYYY-MM-DD")
    var birthday: Date = birthday

    @Column(name = "password")
    var password: String = password

    @Column(name = "role")
    @Enumerated(value = EnumType.STRING)
    var role: Role = role

    @Column(name="bio")
    var bio: String? = bio

    @OneToMany(mappedBy = "user", cascade = [CascadeType.ALL])
    var hobbies: MutableList<Hobby> = mutableListOf()
    val hobbyNameList: List<String>
        get() = hobbies.map { it.name }
    fun addHobby(hobby: Hobby) = hobbies.add(hobby)
    fun deleteHobby(hobbyName: String) {
        hobbies.removeIf { it.name == hobbyName }
    }

    override fun toString(): String {

        var userInfo = "ID: $id | User(phone: $phone, nickname: $nickname, birthday: $birthday, password: $password, bio: $bio, role: $role)"

        if(hobbies.isNotEmpty())
            userInfo += "\n\t  | Hobbies: ${hobbies.map { it.name }}"

        return userInfo

    }

}