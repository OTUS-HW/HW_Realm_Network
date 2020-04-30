//
//  ContentView.swift
//  HW_Realm_Network
//
//  Created by Rustam on 04.03.2020.
//  Copyright © 2020 Rustam. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: WeatherViewModel
    
    var body: some View {
        List(viewModel.weathers) { item in
            VStack(alignment: .leading) {
                Text("\(item.date ?? "")")
                Text("Wind speed = \(item.wind?.speed ?? 0)")
                Text("Temperature = \(item.temperature?.temperature ?? 0)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
