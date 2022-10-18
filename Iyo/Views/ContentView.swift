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
    
    @FetchRequest(entity: Iyo.entity(), sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)]) var fetchedIyos:FetchedResults<Iyo>
    
    @State private var addIyoView = false
    
    
    var body: some View {
        NavigationView {
            ZStack{
                List {
                    ForEach(fetchedIyos) { item in
                        IyoCell(iyoItem: item)
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
        .onAppear{
//            iyoListVM.loadDataFromCD()
        }
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
