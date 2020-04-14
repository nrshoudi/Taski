
/*
 This is where you will be getting your data from a different source.
 */

import UIKit
import Alamofire

class Data {
    
    
    
    static func getData(completion: @escaping ([Model]) -> (), onFailure: @escaping (String?) -> Void) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            var data = [Model]()
            data.append(Model(title: "Finish Home Screen", subTitle: "Web app", images: [], data1: "8", data2: "AM"))
            data.append(Model(title: "Launch Break", subTitle: "", images: [], data1: "11", data2: "AM"))
            data.append(Model(title: "Design Start Up", subTitle: "Hangouts", images: getImage(), data1: "2", data2: "PM"))
            
            
            
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
    
    static func getImage() -> [UIImage] {
        var images = [UIImage]()
        
        images.append(UIImage(named: "profile1")!)
        images.append(UIImage(named: "profile2")!)
        images.append(UIImage(named: "profile3")!)
        
        return images
    }
    static func getWeatherData(latitude: String, longitude: String, completion: @escaping (WeatherModel) -> (), onFailure: @escaping (String?) -> Void) {
        var weatherData:WeatherModel?
        let weatherAPIKey = "d1088363657d88b031ca1c54ab3f8d5d"
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?") else {
            onFailure("Please check your internet connection")
                            return
                }
                        
            let parameters: Parameters = [
                "appid": weatherAPIKey,
                    "lat": latitude,
                    "lon": longitude ]
            AF.request(url,
                       method: .get,
                       parameters: parameters).response { response in
    //                    if response.result.isSuccess {
    //
    //                    }
                guard let data = response.data else {
                    // handel error here
                    return
                }
                do {
                    weatherData = try JSONDecoder().decode(WeatherModel.self, from: data)
                  
                }catch{
                    print(error)
                }
                  completion(weatherData!)
//                debugPrint(response)
            }
    }
    
    static func getDayAndWeather(completion: @escaping (DayWeatherModel?) -> ()) {
        
        
        
        
        DispatchQueue.global(qos: .userInteractive).async {
            let data = DayWeatherModel(dayName: "Sunday", longDate: "March 17, 2019", tempreture: "16°", city: "San Francisco", weatherIcon: UIImage(named: "sun"))
           
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
}
