//
//  ContentView.swift
//  NetSceneARViewer
//
//  Created by Taha Moujtahid on 01.01.22.
//

import SwiftUI
import RealityKit
import FirebaseFirestore
import FirebaseStorage

struct ContentView : View {
    let netSceneArView = NetSceneARView()
    @State var showSettings = false
    @ObservedObject var arViewProps = ARViewProps.shared
    
    
    
    var body: some View {
        ZStack(alignment: .topLeading){
            netSceneArView.edgesIgnoringSafeArea(.all)
            
            HandPoseViewModel()
            
            HStack{
                Button {
                    showSettings.toggle()
                    NetSceneHandler.shared.client.send(try! JSONEncoder().encode(ReadLobbiesMessage()), onSent: nil)
                } label: {
                    Image(systemName: "gearshape.fill").foregroundColor(.white).font(Font.system(size: 32))
                }.sheet(isPresented: $showSettings, onDismiss: nil, content: {
                    SettingsView()
                }).padding()
                
                Spacer()
                
                Button {
                    NetSceneARView.arView.session.getCurrentWorldMap(completionHandler: { worldMap, error in
                        do {
                            let data = try NSKeyedArchiver.archivedData(withRootObject: worldMap!, requiringSecureCoding: true)
                            try data.write(to: arViewProps.mapSaveURL, options: [.atomic])
                        } catch {
                            fatalError("Can't save map: \(error.localizedDescription)")
                        }
                    })
                } label: {
                    Image(systemName: "map.circle.fill")
                        .foregroundColor(.white)
                        .font(Font.system(size: 32))
                }.padding()
                
                Spacer()
                
                Button {
                    arViewProps.isUILocked.toggle()
                } label: {
                    if(arViewProps.isUILocked){
                        Image(systemName: "lock.fill")
                            .foregroundColor(.white)
                            .font(Font.system(size: 32))
                    }else{
                        Image(systemName: "lock.open.fill")
                            .foregroundColor(.white)
                            .font(Font.system(size: 32))
                    }
                }.padding()
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
