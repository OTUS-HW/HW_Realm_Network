//
//  DataBase.swift
//  HW_Realm_Network
//
//  Created by Rustam on 07.03.2020.
//  Copyright © 2020 Rustam. All rights reserved.
//

import Foundation
import RealmSwift

final class DataBase<T: Object> {
    private let realm = try? Realm()
    
    public init() {}
    
    
    public func list() -> [T]? {
        guard let result = realm?.objects(T.self) else {
            return []
        }
        return Array(result)
    }
    
    public func store(_ objects: [T]) {
        write { self.realm?.add(objects, update: .all) }
    }
    
    public func write(_ closure: () -> Void) {
        try! realm?.write { closure() }
    }
}
