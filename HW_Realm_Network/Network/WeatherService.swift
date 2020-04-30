//
//  WeatherService.swift
//  HW_Realm_Network
//
//  Created by Rustam on 07.03.2020.
//  Copyright © 2020 Rustam. All rights reserved.
//

import Foundation
import Combine
import Alamofire
import DynamicJSON

final class WeatherService {
    private let weatherPath = "http://api.openweathermap.org/data/2.5/forecast?q=Moscow,ru,uk&appid=21f75c7f1cacc779d736b069e625547d&cnt=5&lang=ru&units=metric"
    
    let dataBase = DataBase<WeatherRealm>()
    
    public func getWeatherHourly() -> Future<Bool, Error> {
        return Future<Bool, Error> { promose in
            AF.request(self.weatherPath).responseDecodable { [unowned self] (result: DataResponse<Hourly, AFError>) in
                switch result.result {
                case let .success(weathers):
                    let list  = weathers.list!
                    self.dataBase.store(list.map{ ($0 as Weather) .realm })
                    promose(.success(true))
                case let .failure(error):
                    promose(.failure(error))
                }
            }
            
        }
    }
    
    public func getCached() -> Future<[WeatherRealm], Error> {
        return Future<[WeatherRealm], Error> { promose in
            guard let objs = self.dataBase.list() else {
                promose(.failure(WError.emptyCache))
                return
            }
            promose(.success(objs))
        }
    }
}

enum WError: Error {
   case emptyCache
}
