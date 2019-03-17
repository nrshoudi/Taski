
/*
 This is where you will be getting your data from a different source.
 */

import UIKit

class Data {
    
    static func getData(completion: @escaping ([Model]) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            var data = [Model]()
            data.append(Model(title: "Title", subTitle: "Subtitle", image: nil, data1: "Data1", data2: "Data2"))
            
            DispatchQueue.main.async {
                completion(data)
            }
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
