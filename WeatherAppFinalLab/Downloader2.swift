//
//  Downloader2.swift
//  WeatherAppFinalLab
//
//  Created by user151577 on 5/15/19.
//  Copyright © 2019 seneca college. All rights reserved.
//

import Foundation

protocol downloader2Delegate {
    func downlaoder2DidFinishWithVlaue(value : Double)
}

class downloader2 {
    
    var delegate : downloader2Delegate?
    
    func getData(urlObject : URL , completionHandler : @escaping (Data)->())  {
        //step 3
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        
        let task = session.dataTask(with: urlObject) { (data, respons, error) in
            if let myData = data {
                //step 4
                completionHandler(myData)
            }
            else {
                print("error in downloadeing2 \(String(describing: error))" )
            }
        }
        task.resume()
        
    }
    
    func getCurValue(cityname : String)  {
        //step 2
        
        let replaced = (cityname as NSString).replacingOccurrences(of: " ", with: "+")
        let urlString =  "http://api.openweathermap.org/data/2.5/weather?q=" + replaced + "&appid=e5fd5539058b5567d68464e5fa7c1d99"
        
        var thevalue : Double = 0
        let urlObject : URL = URL(string: urlString)!
        getData(urlObject: urlObject) { (data) in
            do{
                
                // stpe 5
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                
                thevalue = json.value(forKeyPath: "main.temp") as! Double
               // let cels = (thevalue - 32) * 5 / 9
                DispatchQueue.main.async {
                    self.delegate?.downlaoder2DidFinishWithVlaue(value: thevalue)
                    
                    print(thevalue)
                }
                
            }catch{
                
            }
            
            
        }
        
        
    }
        
        
        
    
}
