//
//  detailViewController.swift
//  WeatherAppFinalLab
//
//  Created by user151577 on 5/13/19.
//  Copyright © 2019 seneca college. All rights reserved.
//

import UIKit


class detailViewController: UIViewController, downloader2Delegate {
    func downlaoder2DidFinishWithVlaue(value: Double) {
        tempLabel.text = "\(value)"
    }
    
    
    var myDownloader = downloader2()
    

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var Citylabel: UILabel!
    var cityF : String?
    @IBAction func Addcity(_ sender: Any) {
    }
    @IBOutlet weak var Citytext: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myDownloader.delegate = self
        
   myDownloader.getCurValue(cityname: cityF!)
        Citylabel.text=cityF
        //var temp = tempLabel.text
       // var cels = (temp - 32) * 5 / 9 + " °C"
        //myDownloader.getWeather(city: cityFromFVC!)
        //cityLabel.text = cityFromFVC

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
