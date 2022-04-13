//
//  ARViewProps.swift
//  NetSceneARViewer
//
//  Created by Taha Moujtahid on 09.03.22.
//

import Foundation
import FirebaseFirestore
import Firebase
import ARKit
import RealityKit

class ARViewProps : ObservableObject {
    public static let shared = ARViewProps()
    @Published var isUILocked = false
    
    init(){
        FirebaseApp.configure()
        let db = Firestore.firestore()
        db.collection("Plant").addSnapshotListener { snapshot, error in
            print("change in Plant")
            if((snapshot) != nil){
                snapshot!.documents.map({ document in
                    
                    if PlantNode.scene != nil {
                        if let currentPart = PlantNode.scene!.findEntity(named: document.documentID)?.children.first as? ModelEntity {
                            if let isHighlighted = document.data()["highlighted"] as? Bool {
                                currentPart.isEnabled = isHighlighted
                            }
                            if let status = document.data()["status"] as? Int {
                                let material =
                                SimpleMaterial(
                                    color:
                                        UIColor(
                                            red: status == -1 || status == 1 ? 1 : 0,
                                            green: status == 0 || status == 1 ? 1 : 0,
                                            blue: 0,
                                            alpha: 0.5
                                        ),
                                    isMetallic: false
                                )
                                
                                currentPart.model!.materials = [material]
                            }
                        }
                    }
                })
            }
            
            if((error) != nil){
                print(error!)
            }
        }
    }
    
    lazy var mapSaveURL: URL = {
        do {
            return try FileManager.default
                .url(for: .documentDirectory,
                     in: .userDomainMask,
                     appropriateFor: nil,
                     create: true)
                .appendingPathComponent("map.arexperience")
        } catch {
            fatalError("Can't get file save URL: \(error.localizedDescription)")
        }
    }()
    
}
