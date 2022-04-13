//
//  DeleteObjectMessage.swift
//  NetSceneServer
//
//  Created by Taha Moujtahid on 12.01.22.
//

import Foundation

struct DeleteObjectMessage : Codable , NetMessage{
    static var messageType = "DeleteObjectMessage"
    var entityID : String
}

extension MessageHandler {
    func handleMessage(_ message : DeleteObjectMessage?){
        if let message = message {
            print("delete object: \(message.entityID) IMPLEMENT THIS METHOD!")
        }else{
            print("DeleteObjectMessage with insufficient data")
        }
    }
}
