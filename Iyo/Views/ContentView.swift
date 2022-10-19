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
    @State var importance: Importance = .all
    @State var timeSinceLastGinput = 0
    @State var lastGrtdtime: Date = Date()
    @State var now: Date = Date()
    @State var filterBy: Importance = .all
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.now = Date()
        }
        
    }
    func fabTopOrBottom()->String{
        if(addIyoView == true || addGInputView == true){
            return "TOP"
        }else{
            return "BOTTOM"
        }
    }
    func resetGView(){
        guard let lastGInput = fetchedDailyG.last else{
            print("no gs saved, make some now")
            withAnimation{addGInputView.toggle()}
            return
        }
        lastGrtdtime = lastGInput.timestamp ?? Date();
        self.timeSinceLastGinput = iyoListVM.calcDailyGratitudeReset(lastInput:lastGInput.timestamp ?? Date())
        if(timeSinceLastGinput > 24){
            print("time since last g \(timeSinceLastGinput) hrs ago \(addGInputView)")
            withAnimation{addGInputView.toggle()}
        }
    }
    var body: some View {
        NavigationView {
            VStack{
                if(addGInputView==false){Text("🙏🏽 \(iyoListVM.timerString(from: now, until:lastGrtdtime)) 🙏🏽")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(.white.opacity(0.75))
                    .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))}
                ZStack{
                    List {
                        ForEach(fetchedIyos.filter{
                            filterBy == .all ? true :
                            $0.importance == filterBy
                            
                        }) { item in
                            
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
                } //:ZStack
                if(addIyoView == false && addGInputView == false){
                    HStack(alignment: .center){
                        ImportanceView(importanceTitle: "All", selectedImprtance: self.$importance
                        ).onTapGesture {
                            self.filterBy = .all
                            self.importance = .all
                        }//:ImportanceView low
                        ImportanceView(importanceTitle: "Low", selectedImprtance: self.$importance
                        ).onTapGesture {
                            self.filterBy = .low
                            self.importance = .low
                        }//:ImportanceView low
                        
                        ImportanceView(importanceTitle: "Normal", selectedImprtance: self.$importance
                        ).onTapGesture {
                            self.filterBy = .normal
                            self.importance = .normal
                        }//:ImportanceView normal
                        
                        ImportanceView(importanceTitle: "High", selectedImprtance: self.$importance
                        ).onTapGesture {
                            self.filterBy = .high
                            self.importance = .high
                        } //:ImportanceView high
                    } //:HStack
                    .padding()
                }
            } //:VStack
            
            
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
            print("AM I USING TOO MUCH ENERGY")
            let _ = self.timer
            resetGView()
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
