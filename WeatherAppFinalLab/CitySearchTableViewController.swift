//
//  CitySearchTableViewController.swift
//  WeatherAppFinalLab
//
//  Created by user151577 on 5/13/19.
//  Copyright © 2019 seneca college. All rights reserved.
//

import UIKit
import CoreData

class CitySearchTableViewController: UITableViewController,UISearchBarDelegate,downloaderDelegate,NSFetchedResultsControllerDelegate  {
    
    
    
    
    
    lazy var myAppdelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let p1 = NSEntityDescription.insertNewObject(forEntityName: "City", into: myAppdelegate.persistentContainer.viewContext)as! City
        let cityn = allCities[indexPath.row]
        var pointsArr1 = cityn.components(separatedBy: ",")
        p1.cityname = pointsArr1[0]
        p1.country = pointsArr1[1]
        
        myAppdelegate.saveContext();
        
    }
    
    
    func downlaoderDidFinishWithCitiesArray(array: NSArray) {
        allCities = array as! [String]
        tableView.reloadData()
    }
    
    
    var allCities = [String]()
    var myDownloader = downloader()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myDownloader.delegate = self
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "Mycell", for: indexPath)
        //cell1.textLabel?.text = allCities[indexPath.row]
        print(cell1)
        let citystring = allCities[indexPath.row]
        var pointsArr = citystring.components(separatedBy: ",")
        print(pointsArr[0])
        cell1.textLabel?.text = pointsArr[0]
        cell1.detailTextLabel?.text = pointsArr[1]
        return cell1
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2 {
            myDownloader.getCiyies(city: searchText)
        }
        
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
