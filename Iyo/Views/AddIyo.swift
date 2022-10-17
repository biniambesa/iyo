//
//  AddIyo.swift
//  Iyo
//
//  Created by Sogah Mainib on 10/17/22.
//

import Foundation
import SwiftUI

struct AddIyo: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var iyoListVM:IyoListVM
    @Binding var addIyoView:Bool
    @State var iyoName:String = ""
    @State var iyoDescription:String = ""
    @State var isdone:Bool = false
    @State var importance: Importance = .normal
    @State var income:Double?
    @State var expense:Double?
    @State var timestamp:Date = Date()
    @State var duedate:Date = Date()
    
    var body: some View {
        NavigationView {
            VStack{
                Form{
                    VStack(alignment: .leading){
                        Section(header: Text("iyo details")
                            .font(.headline)
                            .foregroundColor(Color(.gray))
                            .padding(.leading)){
                                TextField("Enter iyo name", text: $iyoName).padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(4)
                                TextField("Enter iyo description", text: $iyoDescription).padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(4)
                            }//:Section
                        
                        Section(header: Text("associated income or cost")
                            .font(.headline)
                            .foregroundColor(Color(.gray))
                            .padding(.leading)
                        ){
                            HStack{
                                TextField("income",value:  $income, formatter: NumberFormatter()).padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(4)
                                TextField("expense", value: $expense, formatter: NumberFormatter()).padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(4)
                            } //:HStack
                        } // :HStack
                        Section(header: Text("Importance")
                            .font(.headline)
                            .foregroundColor(Color(.gray))
                            .padding(.leading)
                        ){
                            HStack(alignment: .center){
                                
                                ImportanceView(importanceTitle: "Low", selectedImprtance: self.$importance
                                ).onTapGesture {
                                    self.importance = .low
                                }//:ImportanceView low
                                
                                ImportanceView(importanceTitle: "Normal", selectedImprtance: self.$importance
                                ).onTapGesture {
                                    self.importance = .normal
                                }//:ImportanceView normal
                                
                                ImportanceView(importanceTitle: "High", selectedImprtance: self.$importance
                                ).onTapGesture {
                                    self.importance = .high
                                } //:ImportanceView high
                                
                            }//:HStack
                        } //:Section
                        
                        Section(header: Text("urgency")
                            .font(.headline)
                            .foregroundColor(Color(.gray))
                            .padding(.leading)){
                                DatePicker("", selection: $duedate, displayedComponents: [.date,.hourAndMinute]).datePickerStyle(.compact).labelsHidden()
                                
                            }//:Section urgency
                        
                    } //:VStack
                    //                .border(.green)
                    Button(action: {
                        iyoListVM.addIyo(context: viewContext, name: iyoName, description: iyoDescription, isdone: false, importance: importance, income: income ?? 0, expense: expense ?? 0, timestamp: Date(), duedate: Date())
                        addIyoView.toggle()
                    }, label: {
                        Text("Add Iyo")
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
                //            .border(.red)
                
                
            }//VStack main #26
            //        .border(.purple)
            .toolbar{
                Button(action: {
                    addIyoView.toggle()
                }, label: {
                    Image(systemName: "xmark").foregroundColor(.red)
                })
            }
            .navigationTitle("add iyo|task")
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(.white)
    }
    }


