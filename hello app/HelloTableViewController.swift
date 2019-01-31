//
//  HelloTableViewController.swift
//  hello app
//
//  Created by Juan Guardado on 1/30/19.
//  Copyright © 2019 Juan Guardado. All rights reserved.
//

import UIKit

class HelloTableViewController: UITableViewController {
    var hellos : [HelloObj] = []
    var helloObject : HelloObj? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        getHellos()
    }
    
    func getHellos () {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let hellosFromCoreData = try? context.fetch(HelloObj.fetchRequest()) {
                if let tempHellos = hellosFromCoreData as? [HelloObj] {
                    hellos = tempHellos
                    tableView.reloadData()
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hellos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let hello = hellos[indexPath.row]
        
        if let hello = hello.name {
            cell.textLabel?.text = hello
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hello = hellos[indexPath.row]
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(hello)
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            getHellos()
        }
    }

    
    @IBAction func addButton(_ sender: Any) {
         if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let newHelloObj = HelloObj(context: context)
                newHelloObj.name = "howdy"
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            getHellos()
        }
        
    }
 
}
