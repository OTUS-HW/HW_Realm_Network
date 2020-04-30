//
//  TemperatureData.swift
//  HW_Realm_Network
//
//  Created by Rustam on 07.03.2020.
//  Copyright © 2020 Rustam. All rights reserved.
//

import RealmSwift
import DynamicJSON

struct TemperatureData: Codable {
    
    var temperature: Double
    var feelsLike: Double
    var tempMin: Double
    var tempMax: Double
    var pressure: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
    }
}

extension TemperatureData {
    
    public var realm: TemperatureDataRealm {
        let obj = TemperatureDataRealm()
        obj.temperature = temperature
        obj.feelsLike = feelsLike
        obj.tempMin = tempMin
        obj.tempMax = tempMax
        obj.pressure = pressure
        return obj
    }
}


class TemperatureDataRealm: Object {
    @objc dynamic var temperature: Double = 0
    @objc dynamic var feelsLike: Double = 0
    @objc dynamic var tempMin: Double = 0
    @objc dynamic var tempMax: Double = 0
    @objc dynamic var pressure: Double = 0
    
    convenience required init(data: JSON) {
        self.init()
        self.temperature = data["temp"].double ?? 0
        self.feelsLike = data["feels_like"].double ?? 0
        self.tempMin = data["temp_min"].double ?? 0
        self.tempMax = data["temp_max"].double ?? 0
        self.pressure = data["pressure"].double ?? 0
    }
}
