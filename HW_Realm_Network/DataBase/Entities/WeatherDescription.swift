//
//  WeatherDescription.swift
//  HW_Realm_Network
//
//  Created by Rustam on 04.03.2020.
//  Copyright © 2020 Rustam. All rights reserved.
//

import RealmSwift
import DynamicJSON

struct WeatherDescription: Codable {
    
    var idWeather: Int
    var weather: String
    var weatherDescription: String
    
    enum CodingKeys: String, CodingKey {
        case idWeather = "id"
        case weather = "main"
        case weatherDescription = "description"
    }
}

extension WeatherDescription {
    
    public var realm: WeatherDescriptionRealm {
        let obj = WeatherDescriptionRealm()
        obj.idWeather = idWeather
        obj.weather = weather
        obj.weatherDescription = weatherDescription
        return obj
    }
}

public final class WeatherDescriptionRealm: Object {
    
    @objc public dynamic var idWeather: Int = 0
    @objc public dynamic var weather: String = ""
    @objc public dynamic var weatherDescription: String = ""
    
    convenience required init(data: JSON) {
        self.init()
        self.idWeather = data["id"].int ?? 0
        self.weather = data["main"].string ?? ""
        self.weatherDescription = data["description"].string ?? ""
    }
}
