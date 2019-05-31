//
//  SavedCityTableViewController.swift
//  WeatherAppFinalLab
//
//  Created by user151577 on 5/13/19.
//  Copyright © 2019 seneca college. All rights reserved.
//

import UIKit
import CoreData

class SavedCityTableViewController: UITableViewController, UISearchBarDelegate, NSFetchedResultsControllerDelegate {
    
     lazy var myAppdelegate = UIApplication.shared.delegate as! AppDelegate
    
    lazy var fetchResult : NSFetchedResultsController<City> = {
        let FetchReq  : NSFetchRequest<City> = City.fetchRequest()
        
        let sort = NSSortDescriptor(key: "cityname", ascending: true)
        FetchReq.sortDescriptors = [sort]
        
        
        let fetchResult = NSFetchedResultsController(fetchRequest: FetchReq, managedObjectContext: myAppdelegate.persistentContainer.viewContext, sectionNameKeyPath: "cityname", cacheName: nil)
        fetchResult.delegate = self;
        return fetchResult
    }()
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        var myPredicate : NSPredicate? = nil
        
        if (searchText.count > 0){
            myPredicate = NSPredicate(format: "cityname CONTAINS[c] %@", searchText)
        }
        
        
        
        fetchResult.fetchRequest.predicate = myPredicate
        
        doFetch()
        
        tableView.reloadData()
        
    }
    
    func doFetch() {
        do{
            try fetchResult.performFetch()
        }catch{
            //tell user reinstall
        }
    }

    @IBAction func Savebutton(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doFetch()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

  
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let mySections = fetchResult.sections{
            return mySections.count
        }
        
        return 0;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (fetchResult.sections![section]).numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        var ind = indexPath
        let p1 =  fetchResult.object(at: indexPath)
        cell?.textLabel?.text = p1.cityname
        cell?.detailTextLabel?.text = p1.country
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let objectToRemove =  fetchResult.object(at: indexPath)
            myAppdelegate.persistentContainer.viewContext.delete(objectToRemove)
            myAppdelegate.saveContext()
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! detailViewController
        let _ = destinationViewController.view
        
        guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
        
        // _ = indexPath.row
        let cell = self.tableView.cellForRow(at: indexPath)
        
        destinationViewController.Citylabel.text = cell?.textLabel?.text
        destinationViewController.cityF = cell?.textLabel?.text
  	  }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? detailViewController
        
        guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
        
        let cell = self.tableView.cellForRow(at: indexPath)
        vc?.cityF = cell?.textLabel?.text //sending the 
        
        //   vc?.cityLabel.text=self.tableView.cellForRow(at: IndexPath.row)
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
