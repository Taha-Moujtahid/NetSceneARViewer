//
//  CreateObjectMessage.swift
//  NetSceneServer
//
//  Created by Taha Moujtahid on 12.01.22.
//

import Foundation

struct CreateObjectMessage : Codable , NetMessage{
    static var messageType = "CreateObjectMessage"
    var entityID : String
    var objectType : String
    var objectData : SceneObjectData
}

extension MessageHandler {
    func handleMessage(_ message : CreateObjectMessage?){
        if let message = message {
            print("create object: \(message.entityID) IMPLEMENT THIS METHOD!")
        }else{
            print("CreateObjectMessage with insufficient data")
        }
    }
}
