//
//  IyoCell.swift
//  Iyo
//
//  Created by Sogah Mainib on 10/17/22.
//

import Foundation
import SwiftUI

struct IyoCell: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var iyoListVM:IyoListVM
    @ObservedObject var iyoItem:Iyo
    
    @State private var isEdit = false
    
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                if iyoItem.is_done{
                    Text(iyoItem.name ?? "").foregroundColor(.gray)
                        .fontWeight(.medium)
                        .strikethrough(self.iyoItem.is_done, color: self.iyoItem.importance.importanceColor())
                        .opacity(self.iyoItem.is_done ? 0.5 : 1)
                }else{
                    Text(iyoItem.name ?? "")
                }
                if (iyoItem.due_date != nil){
                    Text(iyoItem.due_date!.getRemTime()).foregroundColor(self.iyoItem.importance.importanceColor()).font(.caption).fontWeight(.bold)
//                    Text("\(iyoItem.task_due_datetime!.formatted(.dateTime.month().day().hour().minute().second()))").foregroundColor(.gray)
                }
                
            }
            Spacer()
//            Button(action: {
////                iyoListVM.isDone(task: iyoItem, context: viewContext)
//            }, label: {
//                Image(systemName: !iyoItem.task_isdone ? "circle": "checkmark.circle").background(.green)
//            })
        }
        .toggleStyle(CheckBoxStyle(iyoColor: self.iyoItem.importance.importanceColor()))
        .sheet(isPresented: $isEdit){
//            AddIyo(addView: $isEdit)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false){
            Button(role: .destructive, action: {
                iyoListVM.deleteIyo(iyo: iyoItem, context: viewContext)
            }, label: {
                Label("Delete",systemImage: "trash")
            })
            Button(action: {
//                iyoListVM.taskListTitle = iyoItem.title ?? ""
                iyoListVM.IyoItem = iyoItem
                isEdit.toggle()
            }, label: {
                Label("Edit",systemImage: "pencil")
            })
                .tint(.yellow)
        }
    }
}
