package com.server.main.service

import com.server.main.entity.UserGeo
import com.server.main.repository.UserGeoRepository
import org.springframework.data.geo.Distance
import org.springframework.data.geo.Metrics
import org.springframework.data.geo.Point
import org.springframework.stereotype.Service

@Service
class UserGeoService(val userGeoRepository: UserGeoRepository) {


    fun saveUserGeo(userGeo: UserGeo): UserGeo {
        return userGeoRepository.save(userGeo);

    }


    fun findUsersWithinRadius(point: Point, radius: Double): List<UserGeo>? {

        val distance = Distance(radius, Metrics.KILOMETERS)
        return userGeoRepository.findByLocationNear(point, distance)
    }
}

