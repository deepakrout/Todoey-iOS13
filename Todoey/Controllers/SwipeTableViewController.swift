//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Deepak Rout on 7/3/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import SwipeCellKit
import ChameleonFramework

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        
    }
    
    //Tableview datasource method
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TheCell",for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            print("Delete cell")
            self.updateModel(at: indexPath)
   
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        //options.transitionStyle = .border
        return options
    }
    
    func updateModel(at indexPath: IndexPath) {
        //update data
    }
    
    func updateNavBarColor(_ backgroundColor: UIColor) {
       guard let navBar = navigationController?.navigationBar else { fatalError("NavigationController does not exist") }
//
//        navBar.standardAppearance.backgroundColor = backgroundColor
//        navBar.scrollEdgeAppearance?.backgroundColor = backgroundColor
//        navBar.backgroundColor = backgroundColor
//        navBar.scrollEdgeAppearance?.largeTitleTextAttributes = [.foregroundColor: ContrastColorOf(backgroundColor, returnFlat: true)]
//        navBar.standardAppearance.largeTitleTextAttributes = [.foregroundColor: ContrastColorOf(backgroundColor, returnFlat: true)]
//
//        let contrastOfBackgroundColor = ContrastColorOf(backgroundColor, returnFlat: true)
//
//        // Small title colors: (also shown when large title collapses by scrolling down)
//        navBar.barTintColor = backgroundColor
//        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: contrastOfBackgroundColor]
//
//        // Large title colors:
//        navBar.backgroundColor = backgroundColor
//        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: contrastOfBackgroundColor]
//
//        // Color the back button and icons: (both small and large title)
//        navBar.tintColor = contrastOfBackgroundColor
        
        
        let navBarAppearance = UINavigationBarAppearance()
           navBarAppearance.configureWithOpaqueBackground()
           navBarAppearance.titleTextAttributes = [.foregroundColor: ContrastColorOf(backgroundColor, returnFlat: true)]
           navBarAppearance.largeTitleTextAttributes = [.foregroundColor: ContrastColorOf(backgroundColor, returnFlat: true)]
           navBarAppearance.backgroundColor = backgroundColor
           navBar.standardAppearance = navBarAppearance
           navBar.scrollEdgeAppearance = navBarAppearance
    }
    
}


