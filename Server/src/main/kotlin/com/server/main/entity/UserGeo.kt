package com.server.main.entity


import org.springframework.data.annotation.Id
import org.springframework.data.geo.Point
import org.springframework.data.redis.core.RedisHash
import org.springframework.data.redis.core.index.GeoIndexed

@RedisHash(value = "use", timeToLive = 3600)
class UserGeo(@Id var id: String,   @GeoIndexed var location : Point) {

    var latitude: Double = location.x
    var longitude: Double = location.y

    override fun toString(): String {
        return "id: $id / latitude: $latitude / longitude: $longitude"
    }


}

