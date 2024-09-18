//
//  ContentView.swift
//  Wheather App
//
//  Created by Longxuan Lin on 9/9/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    
    var body: some View {
        VStack {
            if let location = locationManager.location{
                if let weather = weather {
                    WeatherView(weather: weather)
                    
                }else{
                    LoadingView()
                        .task{
                            do{
                                try await
                                weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                
                            }catch{
                                print("ERROR: Failed Getting Weather: \(error)")
                            }
                        }
                }
                Text("Your coordinate are: \(location.longitude), \(location.latitude)")
            }else{
                if locationManager.isLoading{
                    LoadingView()
                }else{
                    WelcomeView().environmentObject(locationManager)
                }
            }
            
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
        
    }
}

#Preview {
    ContentView()
}
