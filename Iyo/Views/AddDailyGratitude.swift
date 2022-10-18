//
//  AddDailyGratitude.swift
//  Iyo
//
//  Created by Sogah Mainib on 10/18/22.
//

import SwiftUI

import Foundation
import SwiftUI
import CoreData
import Combine

class AddGratitudeVM: ObservableObject {
    
   func addGratefulFor(context: NSManagedObjectContext,
               id:UUID,
               g1:String,
               g2:String,
               g3:String,
               timestamp:Date
   )->Void{
       let dg = DailyGratitude(context: context)
       dg.id = id
       dg.gratitude_one = g1
       dg.gratitude_two = g2
       dg.gratitude_three = g3
       dg.timestamp = timestamp
       save(context: context)
   }
   
   func save(context: NSManagedObjectContext){
       do{
           try context.save()
       }catch let err as NSError{
           print("err at #37 iyolistvm, err: \(err.localizedDescription), desc \(err.userInfo)")
       }
   
   }
}
struct AddDailyGratitude: View {
    @Environment(\.managedObjectContext) var viewContext
    @StateObject var addGVM:AddGratitudeVM = AddGratitudeVM()
    @Binding var addGView:Bool
    @State var g1: String = ""
    @State var g2: String = ""
    @State var g3: String = ""
    @State var isHidden: Bool = false
    var rightNow = Date().formatted(.dateTime.month().day().hour().minute())
    
    func fieldsNilValidate()-> Bool{
        guard self.g1.trimmingCharacters(in: .whitespaces) != "" else{return false}
        guard self.g2.trimmingCharacters(in: .whitespaces) != "" else{return false}
        guard self.g3.trimmingCharacters(in: .whitespaces) != "" else{return false}
        return true
    }
    var body: some View {
            NavigationView {
                VStack{
                    Section(header: Text("What 3 things Are you GrateFul For")) {
                        HStack {
                            Text("1")
                            TextField("", text: $g1, prompt: Text("I am grateful for ...")).padding()
                        }
                        
                        HStack {
                            Text("2")
                            TextField("", text: $g2, prompt: Text("I am grateful for ...")).padding()
                        }
                        
                        HStack {
                            Text("3")
                            TextField("", text: $g3, prompt: Text("I am grateful for ...")).padding()
                        }
            
                    }.padding(.top)
                    Spacer()
                    Button(action: {
                        
                        //check if task empty or not first
                        if (self.fieldsNilValidate() == false) {return}
                        self.addGView = false
                        addGVM.addGratefulFor(context: viewContext,id:UUID(), g1: g1, g2:g2, g3:g3, timestamp: Date())
                    }, label: {
                        Text("Add Daily Gratitudes")
                            .frame(minWidth: 40,maxWidth: .infinity)
                            .fontWeight(.bold)
                    }) // :Button
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth:.infinity)
                    .background(.blue)
                    .cornerRadius(10)
                }
                    .padding(.horizontal, 16)
                } //: Navigation VIew
            .navigationBarTitle("\(self.rightNow)")
            } // ..VIEW
        
} //:View



struct AddDailyGratitude_Previews: PreviewProvider {
    static var previews: some View {
        AddDailyGratitude(addGVM: AddGratitudeVM(), addGView: .constant(false))
    }
}
