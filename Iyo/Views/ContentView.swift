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
    
    @FetchRequest(entity: DailyGratitude.entity(), sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)]) var fetchedDailyG:FetchedResults<DailyGratitude>
    
    @State private var addIyoView = false
    @State private var addGInputView = false
    
    
    func fabTopOrBottom()->String{
        if(addIyoView == true || addGInputView == true){
            return "TOP"
        }else{
            return "BOTTOM"
        }
    }
    var body: some View {
        NavigationView {
            ZStack{
                List {
                    ForEach(fetchedIyos) { item in
                        IyoCell(iyoItem: item)
                    }
                }.refreshable {
                    print("Do your refresh work here")
                } // :List
                if self.addIyoView {
                    //show add task view
                    AddIyo(addIyoView: self.$addIyoView)
                        .transition(.move(edge: .bottom))
//                        .animation(.default, value: self.addIyoView)
                }
                
                if self.addGInputView {
                    //show add task view
                    AddDailyGratitude(addGView: self.$addGInputView)
                        .transition(.move(edge: .bottom))
//                        .animation(.default, value: self.addIyoView)
                }
            }//:ZStack
    
        }
        .fab(
            position: fabTopOrBottom(),
            fgcolor:.white,color: addIyoView == true ? .red : .blue, image: Image(systemName: addIyoView == true ? "xmark" : "plus"), action: {
                withAnimation (.easeIn(duration: 0.25)){
                    addIyoView.toggle()
                }
            }
        )
        .navigationTitle("Iyos")
        .onAppear{
//            iyoListVM.loadDataFromCD()
            guard let lastGInput = fetchedDailyG.first else{
                print("no gs saved, make some now")
                withAnimation{addGInputView.toggle()}
                return
            }
          let timeSinceLastGinput = iyoListVM.calcDailyGratitudeReset(lastInput:lastGInput.timestamp ?? Date())
            if(timeSinceLastGinput > 24){
                withAnimation{addGInputView.toggle()}
            }
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
