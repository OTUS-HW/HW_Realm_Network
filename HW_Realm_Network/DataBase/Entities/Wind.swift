//
//  Wind.swift
//  HW_Realm_Network
//
//  Created by Rustam on 07.03.2020.
//  Copyright © 2020 Rustam. All rights reserved.
//

import RealmSwift
import DynamicJSON

struct Wind: Codable {
    var speed: Double
    var deg: Double
}

extension Wind {
    
    public var realm: WindRealm {
        let obj = WindRealm()
        obj.speed = speed
        obj.deg = deg
        return obj
    }
}

class WindRealm: Object {
    @objc dynamic var speed: Double = 0
    @objc dynamic var deg: Double = 0
    
    convenience required init(data: JSON) {
        self.init()
        self.speed = data["speed"].double ?? 0
        self.deg = data["deg"].double ?? 0
    }
}
