package com.server.main.entity

import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType
import jakarta.persistence.Id
import jakarta.persistence.JoinColumn
import jakarta.persistence.ManyToOne

@Entity
class Hobby(name: String, user: User) {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "hobby_id")
    val id: Long? = null

    @ManyToOne
    @JoinColumn
    val user: User = user

    @Column(name = "name")
    var name: String = name

}