package com.server.main.repository

import com.server.main.entity.UserGeo
import org.springframework.data.geo.Distance
import org.springframework.data.geo.Point
import org.springframework.data.repository.CrudRepository

interface UserGeoRepository : CrudRepository<UserGeo, String> {
    fun findByLocationNear(location: Point, distance: Distance): List<UserGeo>
}