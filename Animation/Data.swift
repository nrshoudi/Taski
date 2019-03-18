
/*
 This is where you will be getting your data from a different source.
 */

import UIKit

class Data {
    
    static func getData(completion: @escaping ([Model]) -> ()) {
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
    
    static func getDayAndWeather(completion: @escaping (DayWeatherModel?) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            let data = DayWeatherModel(dayName: "Sunday", longDate: "March 17, 2019", tempreture: "16°", city: "San Francisco", weatherIcon: UIImage(named: "sun"))
           
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
}
