//
//  IyoListVM.swift
//  Iyo
//
//  Created by Sogah Mainib on 10/17/22.
//

import Foundation
import SwiftUI
import CoreData


class IyoListVM: ObservableObject {
    @Published var iyos:[Iyo] = []
    @Published var filterFlag: String = "INCOME"
    
    @Environment(\.managedObjectContext) private var viewContext
     
   
     
    func addIyo(context: NSManagedObjectContext,
                name:String,
                description:String,
                isdone:Bool,
                importance:Importance,
                income:Double,
                expense:Double,
                timestamp:Date,
                duedate:Date
    ){
        
        let iyo = Iyo(context: context)
        iyo.task_name = name
        iyo.task_description = description
        iyo.task_isdone = isdone
        iyo.task_importance = Int32(importance.rawValue)
        iyo.task_income = income
        iyo.task_expense = expense
        iyo.task_due_datetime = duedate
        iyo.timestamp = timestamp
    }
    
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
        }catch{
            print("err at #37 iyolistvm, err: \(error)")
        }
        
        loadDataFromCD()
    }
    
    func loadDataFromCD(){
        //fetch iyolist data from coredata
        print("fetching data from coredata Iyolistvm #45")
        
        @FetchRequest(entity: Iyo.entity(), sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)]) var fetchedIyo:FetchedResults<Iyo>
        iyos = fetchedIyo.map{$0}
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
           iyo.task_isdone.toggle()
           save(context: context)
       }
}

