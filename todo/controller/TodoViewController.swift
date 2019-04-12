//
//  TodoViewController.swift
//  todo
//
//  Created by Adam Wlodarczyk on 27/03/2019.
//  Copyright © 2019 Adam Wlodarczyk. All rights reserved.
//

import UIKit
import Material
import SCLAlertView

class TodoViewController: BasicViewController {
    
    let color = UIColor.init(red: 103/255, green: 58/255, blue: 183/255, alpha: 1.0)
    var manager: DataManagerService = DataManagerServiceImpl.shared
    @IBOutlet weak var headerContainer: ToDoHeaderView!
    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        addBannerViewToViewAtBottomIfNeeded()
        configureView()
    } 
    
}
extension TodoViewController{
    func configureView(){
        self.view.backgroundColor = color
        self.tableView.backgroundColor = color
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.allowsSelection = false
         
        self.headerContainer.delegate = self
        
    }
    func setEmptyView(){
        self.tableView.backgroundView = EmptyView(frame: self.tableView.frame)
        self.tableView.separatorStyle = .none;
    }
    func clearEmptyView(){
        self.tableView.backgroundView = nil
        self.tableView.separatorStyle = .none;
    }
    func reload(){
        
        self.tableView.reloadData()
    }
}
extension TodoViewController: HeaderViewDelegate{
    func itemCreated(name: String) {
       
        let item = TodoItem(id: self.manager.getNextId(), name: name, done: false, priority: .normal, createdAt: Date())
        self.manager.addItem(item: item)
        reload()
    }
    func showRemovePrompt(index:Int){
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Yes, remove it!"){
            self.manager.removeItem(at: index)
            self.reload()
        }
        alertView.addButton("No, that was a mistake") {
            alertView.dismiss(animated: true, completion: nil)
        }
        alertView.showError("Remove item", subTitle: "You want to remove item:\n\n\(self.manager.toDoItems[index].name)\n\nAre You sure, You want to do this?")
    }
    func showPriorityAlertView(index:Int){
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false,
            circleBackgroundColor: Color.lightGreen.base
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Urgent",backgroundColor: Color.red.base){
            self.manager.changePriority(priority: .urgent, at: index)
            self.reload()
        }
        alertView.addButton("Important",backgroundColor: Color.orange.base) {
            self.manager.changePriority(priority: .important, at: index)
            self.reload()
        }
        alertView.addButton("Normal",backgroundColor: Color.lightGreen.base) {
            self.manager.changePriority(priority: .normal, at: index)
            self.reload()
        }
        
        alertView.showInfo("Change priority", subTitle: "You want to change priority for:\n\n\(self.manager.toDoItems[index].name)\n")
    }
    
}
extension TodoViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.manager.toDoItems.count > 0 {
            clearEmptyView()
            return 1
        } else {
            setEmptyView()
            return 0
        }
    }
}
extension TodoViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return TodoItemTableViewCell.defaultCellHeight()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.manager.toDoItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TodoItemTableViewCell.cellFromXib()
        cell.configureCell(item: self.manager.toDoItems[indexPath.row], atIndex: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Remove") { [weak self] (UITableViewRowAction, IndexPath) in
            
            self?.showRemovePrompt(index: indexPath.row)
        }
        let stateName = self.manager.toDoItems[indexPath.row].done ? "Undone":"Done"
        let changeStateAction = UITableViewRowAction(style: .normal, title: stateName) { [weak self] (UITableViewRowAction, IndexPath) in
            self?.manager.changeDoneStatus(at: indexPath.row)
            self?.reload()
        }
        changeStateAction.backgroundColor = self.manager.toDoItems[indexPath.row].done ? Color.orange.darken1 : Color.lightBlue.base
        
        if self.manager.toDoItems[indexPath.row].done {
            return [deleteAction,changeStateAction]
        }
        let changePriority = UITableViewRowAction(style: .normal, title: "Priority") { [weak self] (UITableViewRowAction, IndexPath) in
            
            self?.showPriorityAlertView(index: indexPath.row)
        }
        changePriority.backgroundColor = Color.lightGreen.base
        
        return [deleteAction,changeStateAction,changePriority]
    }
    
}
