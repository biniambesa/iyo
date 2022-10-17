//
//  ContentView.swift
//  Iyo
//
//  Created by Sogah Mainib on 10/17/22.
//
import SwiftUI
struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var iyoListVM:IyoListVM
    @State private var addIyoView = false
    var body: some View {
        NavigationView {
            ZStack{
                List {
                    ForEach(iyoListVM.iyos) { item in
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
                } // :List
                if self.addIyoView {
                    BlackView()
                        .onTapGesture { self.addIyoView = false}
                    //show add task view
                    AddIyo(addIyoView: self.$addIyoView)
                        .transition(.move(edge: .bottom))
                        .animation(.default, value: self.addIyoView)
                }
            }//:ZStack
        }
        .fab(
            position: addIyoView ? "TOP" : "BOTTOM",
            fgcolor:.white,color: addIyoView == true ? .red : .blue, image: Image(systemName: addIyoView == true ? "xmark" : "plus"), action: {
                withAnimation {
                    addIyoView.toggle()
                }
            }
        )
    }//:VIEW Body
    
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
