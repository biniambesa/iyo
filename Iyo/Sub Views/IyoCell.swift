//
//  IyoCell.swift
//  Iyo
//
//  Created by Sogah Mainib on 10/17/22.
//

import Foundation
import SwiftUI
import CoreData


struct IyoCell: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var iyoListVM:IyoListVM
    @ObservedObject var iyoItem:Iyo
    @State private var isEdit = false
    @State private var fullDateShow = false
    
    
    var body:some View{
        Toggle(isOn: self.$iyoItem.is_done) {
            VStack(alignment: .leading, spacing: 4){
                HStack{
                    Text(self.iyoItem.name ?? "")
                        .fontWeight(.medium)
                        .strikethrough(self.iyoItem.is_done, color: self.iyoItem.importance.importanceColor())
                        .opacity(self.iyoItem.is_done ? 0.5 : 1)
                    Spacer()
                    HStack{
                        Text("due:").font(.caption).fontWeight(.bold)
                        
                        if(fullDateShow){
                            Text("\(iyoItem.due_date!.formatted(.dateTime.month().day().hour().minute()))")
                                .font(.caption)
                                .foregroundColor(self.iyoItem.importance.importanceColor())
                                .strikethrough(self.iyoItem.is_done, color: self.iyoItem.importance.importanceColor())
                        }else{
                            Text((iyoItem.due_date == nil ? "": iyoItem.due_date!.getRemTime()))
                                .foregroundColor(self.iyoItem.importance.importanceColor())
                                .font(.caption)
                                .fontWeight(.bold)
                                .strikethrough(self.iyoItem.is_done, color: self.iyoItem.importance.importanceColor())
                        }
                            
                    }//:HStack due date
                    .onTapGesture {
                        withAnimation {
                            fullDateShow.toggle()
                        }
                    }
                   
                } //:HStack
                HStack{
                    Text(iyoItem.desc ?? "")
                        .fontWeight(.light)
                        .strikethrough(self.iyoItem.is_done, color: self.iyoItem.importance.importanceColor())
                        .opacity(self.iyoItem.is_done ? 0.5 : 1)
                        .font(.caption).fontWeight(.bold)
                        .strikethrough(self.iyoItem.is_done, color: self.iyoItem.importance.importanceColor())
                    Spacer()
                    
                    HStack{
                        Text("\(iyoItem.income.formatted(.currency(code: "USD")))")
                            .fontWeight(.light)
                            .foregroundColor(.green)
                            .strikethrough(self.iyoItem.is_done, color: self.iyoItem.importance.importanceColor())
                            .opacity(self.iyoItem.is_done ? 0.5 : 1)
                            .font(.caption).fontWeight(.bold)
                        
                      
                        Text("\(iyoItem.expense.formatted(.currency(code: "USD")))")
                            .fontWeight(.light)
                            .foregroundColor(.red)
                            .strikethrough(self.iyoItem.is_done, color: self.iyoItem.importance.importanceColor())
                            .opacity(self.iyoItem.is_done ? 0.5 : 1)
                            .font(.caption).fontWeight(.bold)
                            
                    }
                    
                    
                }
            }  .swipeActions(edge: .trailing, allowsFullSwipe: false){
                            Button(role: .destructive, action: {
                                iyoListVM.deleteIyo(iyo: iyoItem, context: viewContext)
                            }, label: {
                                Label("Delete",systemImage: "trash")
                            })
                            Button(action: {
                //                iyoListVM.iyoItemListTitle = iyoItem.title ?? ""
                                iyoListVM.IyoItem = iyoItem
                                isEdit.toggle()
                            }, label: {
                                Label("Edit",systemImage: "pencil")
                            })
                                .tint(.yellow)
                        }
                    
           
        } //togggle
        .toggleStyle(CheckBoxStyle(iyoColor: self.iyoItem.importance.importanceColor()))
        .onReceive(self.iyoItem.objectWillChange) { _ in
            self.iyoListVM.update(context: viewContext)
        }
    }
    } //:View
//
//    var body: some View {
//        HStack{
//            VStack(alignment:.leading){
//                if iyoItem.is_done{
//                    Text(iyoItem.name ?? "").foregroundColor(.gray)
//                        .fontWeight(.medium)
//                        .strikethrough(self.iyoItem.is_done, color: self.iyoItem.importance.importanceColor())
//                        .opacity(self.iyoItem.is_done ? 0.5 : 1)
//                }else{
//                    Text(iyoItem.name ?? "")
//                }
//                if (iyoItem.due_date != nil){
//                    Text(iyoItem.due_date!.getRemTime()).foregroundColor(self.iyoItem.importance.importanceColor()).font(.caption).fontWeight(.bold)
////                    Text("\(iyoItem.iyoItem_due_datetime!.formatted(.dateTime.month().day().hour().minute().second()))").foregroundColor(.gray)
//                }
//
//            }
//            Spacer()
////            Button(action: {
//////                iyoListVM.isDone(iyoItem: iyoItem, context: viewContext)
////            }, label: {
////                Image(systemName: !iyoItem.iyoItem_isdone ? "circle": "checkmark.circle").background(.green)
////            })
//        }
//        .toggleStyle(CheckBoxStyle(iyoColor: self.iyoItem.importance.importanceColor()))
//        .sheet(isPresented: $isEdit){
////            AddIyo(addView: $isEdit)
//        }
//        .swipeActions(edge: .trailing, allowsFullSwipe: false){
//            Button(role: .destructive, action: {
//                iyoListVM.deleteIyo(iyo: iyoItem, context: viewContext)
//            }, label: {
//                Label("Delete",systemImage: "trash")
//            })
//            Button(action: {
////                iyoListVM.iyoItemListTitle = iyoItem.title ?? ""
//                iyoListVM.IyoItem = iyoItem
//                isEdit.toggle()
//            }, label: {
//                Label("Edit",systemImage: "pencil")
//            })
//                .tint(.yellow)
//        }
//    }
//}
