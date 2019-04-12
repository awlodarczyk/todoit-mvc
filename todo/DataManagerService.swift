//
//  DataService.swift
//  todo
//
//  Created by Adam Wlodarczyk on 28/03/2019.
//  Copyright © 2019 Adam Wlodarczyk. All rights reserved.
//

import Foundation
protocol DataManagerService {
    static var shared: DataManagerService! {get}

    var toDoItems: [TodoItem]! {get}
    func getNextId() -> Int
    func addItem(item: TodoItem) -> Void
    func changePriority(priority: Priority, at index: Int) -> Void
    func changeDoneStatus(at index: Int) -> Void
    func removeItem(at index: Int) -> Void
}
class DataManagerServiceImpl: DataManagerService {
    func getNextId() -> Int {
        let tmp = items.sorted{
            $0.id > $1.id
        }
        return tmp.first?.id ?? 0 + 1
    }
    
    private let TODO_KEY = "pl.hindbrain.todo.user-todos"
    static var shared: DataManagerService! = DataManagerServiceImpl()
    var items: [TodoItem] = []
    var toDoItems: [TodoItem]! {
        get{
            items.sort {
                if !$0.done && $1.done {
                    return true
                }
                if $0.priority.rawValue > $1.priority.rawValue && ($0.done == $1.done){
                    return true
                }
                if $0.priority == $1.priority && $0.done == $1.done {
                    return $0.createdAt.compare($1.createdAt) == .orderedDescending
                }
                return false
            }
            return items
        }
    }
    private func storeIntoUserDefault(){
        do{
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(self.items)
            let userDefaults = UserDefaults.standard
            userDefaults.set(encodedData, forKey: TODO_KEY)
            userDefaults.synchronize()
        
        } catch {
            print("err")
        }
        
        
    }
    private init(){
        
        if let data = UserDefaults.standard.data(forKey: TODO_KEY){
            do{
                let container = JSONDecoder()
                let array: [TodoItem] = try container.decode([TodoItem].self, from: data)
                self.items = array
            }catch{
                print("err")
            }
        }
    }
}
extension DataManagerServiceImpl{
    func changeDoneStatus(at index: Int) {
        self.items[index].done = !(self.items[index].done)
        storeIntoUserDefault()
    }
    
    func changePriority(priority: Priority, at index: Int) {
        self.items[index].priority = priority
        storeIntoUserDefault()
    }
    
    func addItem(item: TodoItem) {
        self.items.append(item)
        storeIntoUserDefault()
    }
    func removeItem(at index: Int){
        self.items.remove(at: index)
        storeIntoUserDefault()
    }
}
