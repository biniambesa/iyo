//
//  IyoListVM.swift
//  Iyo
//
//  Created by Sogah Mainib on 10/17/22.
//

import Foundation
import SwiftUI
import CoreData
import Combine

class IyoListVM: ObservableObject {
    @Published var filterFlag: String = "INCOME"
    @Published var IyoItem:Iyo!
     
  
     
    func addIyo(context: NSManagedObjectContext,
                name:String,
                description:String,
                isdone:Bool,
                importance:Importance,
                income:Double,
                expense:Double,
                timestamp:Date,
                duedate:Date
    )->Void{
        
        let iyo = Iyo(context: context)
        iyo.name = name
        iyo.desc = description
        iyo.is_done = isdone
        iyo.importance_num = Int32(importance.rawValue)
        iyo.income = income
        iyo.expense = expense
        iyo.due_date = duedate
        iyo.timestamp = timestamp
        
        save(context: context)
    }
    
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
        }catch let err as NSError{
            print("err at #37 iyolistvm, err: \(err.localizedDescription), desc \(err.userInfo)")
        }
    
    }
    func update(context: NSManagedObjectContext){
        if context.hasChanges{
            save(context: context)
        }
    }
    
//    func editIyo(iyo:Iyo, index: Int){
//           taskListItem = task
//            iyos[index] = iyo
//    save()
//       }
       
       func deleteIyo(iyo:Iyo, context:NSManagedObjectContext){
           context.delete(iyo)
           save(context: context)
       }
       
       
       func isDone(iyo:Iyo, context:NSManagedObjectContext){
           iyo.is_done.toggle()
           save(context: context)
       }
}

