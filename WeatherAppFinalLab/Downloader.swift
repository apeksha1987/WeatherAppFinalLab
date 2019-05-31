//
//  Downloader.swift
//  BitCoin App
//
//  Created by dev on 2019-05-13.
//  Copyright © 2019 dev. All rights reserved.
//

import Foundation

protocol downloaderDelegate {
    func downlaoderDidFinishWithCitiesArray(array : NSArray)
}

//This protocal calls the City Api, corrects the JSON and give the array of cities 
class downloader {
    
    var delegate : downloaderDelegate?
    
    func getData(urlObject : URL , completionHandler : @escaping (Data)->())  {
        //step 3
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        
        let task = session.dataTask(with: urlObject) { (data, respons, error) in
            if let myData = data {
                //step 4
                // converting unvalid data to string
                var stringFromJson = String(decoding: myData, as: UTF8.self)
                
                //make the string valid json
                stringFromJson = stringFromJson.replacingOccurrences(of: "?(", with: "")
                stringFromJson = stringFromJson.replacingOccurrences(of: ");", with: "")
                
                //converting the string to valid json data
                let validDataFromAPI = stringFromJson.data(using: .utf8)
                
                
                completionHandler(validDataFromAPI!)
            }
            else {
                print("error in downloadeing \(String(describing: error))" )
            }
        }
        task.resume()
        
    }
    
    func getCiyies(city : String)  {
        //step 2
     let urlString =  "http://gd.geobytes.com/AutoCompleteCity?callback=?&q="  + city
       
        
        
        
      //  var thevalue : Double = 0
        let urlObject : URL = URL(string: urlString)!
        getData(urlObject: urlObject) { (data) in
            do{
   
                // stpe 5
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! NSArray
                 //thevalue = json.value(forKey: "ask") as! Double
                DispatchQueue.main.async {
                    self.delegate?.downlaoderDidFinishWithCitiesArray(array: json)
                    
                
            }
                
            }catch{
                
            }
            
            
        }
      
        
    }
    
}
