//
//  WeatherViewModel.swift
//  HW_Realm_Network
//
//  Created by Rustam on 04.03.2020.
//  Copyright © 2020 Rustam. All rights reserved.
//

import Foundation
import Combine

let apiKey = "21f75c7f1cacc779d736b069e625547d"
let request = "http://api.openweathermap.org/data/2.5/forecast?q=Moscow,ru,uk&appid=21f75c7f1cacc779d736b069e625547d&cnt=5&lang=ru&units=metric"


final class WeatherViewModel: ObservableObject {
    @Published private(set) var weathers = [WeatherRealm]()
    var seq = Set<AnyCancellable>()
    var service: WeatherService
    
    init() {
        service = WeatherService()
        loadWeatherForMoscow()
    }
    
    private func loadWeatherForMoscow() {
        service.getWeatherHourly()
            .filter { $0 == true }
            .flatMap { _ -> Future<[WeatherRealm], Error> in
                self.service.getCached()
            }
            .sink(receiveCompletion: { (_) in
                
            }, receiveValue: { (result) in
                self.weathers = result
            }).store(in: &seq)
        
    }
}
