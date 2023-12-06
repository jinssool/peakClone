package com.server.main.controller


import com.server.main.entity.UserGeo
import com.server.main.service.UserGeoService
import org.springframework.data.geo.Point
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController
//
//@RestController
//@RequestMapping("/api/usergeo")
//class TestController(private val userGeoService: UserGeoService) {
//
//    @PostMapping("/saveAndSearch")
//    fun saveAndSearch(
//        @RequestParam("id") id: String,
//        @RequestParam("latitude") latitude: Double,
//        @RequestParam("longitude") longitude: Double
//    ): ResponseEntity<List<UserGeo>> {
//        val newpoint = Point(latitude, longitude)
//        val userGeo = UserGeo(id, newpoint)
//        userGeoService.saveUserGeo(userGeo)
//        val usersWithinRadius = userGeoService.findUsersWithinRadius(latitude, longitude,1)
//        return ResponseEntity(usersWithinRadius, HttpStatus.OK)
//    }
//}