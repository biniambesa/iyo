//
//  ContentView.swift
//  Iyo
//
//  Created by Sogah Mainib on 10/17/22.
//

import SwiftUI
import CoreData


class IyoListVM: ObservableObject {
    @Published var iyos:[Iyo] = []
    func addIyo(context: NSManagedObjectContext,
                name:String,
                description:String,
                isdone:Bool,
                importance:Int32,
                income:Double,
                expense:Double,
                timestamp:Date){
        
        let iyo = Iyo(context: context)
        iyo.task_name = name
        iyo.task_description = description
        iyo.task_isdone = isdone
        iyo.task_importance = importance
        iyo.task_income = income
        iyo.task_expense = expense
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
    }
}
struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Iyo.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Iyo>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        VStack{
                            Text("iyo name at \(item.task_name ?? "")")
                            Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                        }
                       
                    } label: {
                        VStack{
                            Text("iyo name at \(item.task_name ?? "")")
                            Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                        }
        
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Iyo(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
