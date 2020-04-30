//
//  Weather.swift
//  HW_Realm_Network
//
//  Created by Rustam on 07.03.2020.
//  Copyright © 2020 Rustam. All rights reserved.
//

import Foundation
import RealmSwift
import DynamicJSON

struct Weather: Decodable {
    var date: String
    var weatherDescription: [WeatherDescription]
    var wind: Wind
    var temperature: TemperatureData
    
    enum CodingKeys: String, CodingKey {
        case date = "dt_txt"
        case weatherDescription = "weather"
        case wind
        case temperature = "main"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(String.self, forKey: .date)
        weatherDescription = try container.decode(Array.self, forKey: .weatherDescription)
        wind = try container.decode(Wind.self, forKey: .wind) as Wind
        temperature = try container.decode(TemperatureData.self, forKey: .temperature)
    }
}

extension Weather {
    
    public var realm: WeatherRealm {
        let obj = WeatherRealm()
        obj.date = date
//        obj.weatherDescription = weatherDescription
//        obj.wind = wind
        return obj
    }
}

class WeatherRealm: Object {
    @objc dynamic var date: String?
    var weatherDescription = List<WeatherDescriptionRealm>()
    @objc dynamic var wind: WindRealm?
    @objc dynamic var temperature: TemperatureDataRealm?
    
    override class func primaryKey() -> String? {
        return "date"
    }
    
    enum CodingKeys: String, CodingKey {
        case date = "temp"
        case weatherDescription = "weather"
        case wind
        case temperature = "main"
    }
    
    convenience required init(data: JSON) {
        self.init()
        self.date = data["temp"].string
//        self.weatherDescription = data["weather"].array //as? [WeatherDescriptionRealm]
        self.wind = data["wind"].object as? WindRealm
        self.temperature = data["main"].object as? TemperatureDataRealm
    }
}

extension WeatherRealm: Identifiable {
    public var id: Int {
        return UUID().hashValue
    }
}

struct Hourly: Decodable {

    var message: Float?
    var cnt: Int?
    var list: [Weather]?

    init(message: Float?, cnt: Int?, list: [Weather]?) {
        self.message = message
        self.cnt = cnt
        self.list = list
    }
    
    enum CodingKeys: String, CodingKey {
        case message
        case cnt
        case list
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decode(Float.self, forKey: .message)
        cnt = try container.decode(Int.self, forKey: .cnt)
        list = try container.decode(Array.self, forKey: .list)
    }
}
