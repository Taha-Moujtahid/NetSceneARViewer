//
//  ReadObjectsMessage.swift
//  NetSceneServer
//
//  Created by Taha Moujtahid on 12.01.22.
//

import Foundation

struct ReadObjectsMessage : Codable , NetMessage{
    static var messageType = "ReadObjectsMessage"
}

struct ReadObjectsResponse : Codable, NetMessage{
    static var messageType = "ReadObjectsResponse"
    var objects : [SceneObjectData]
}

extension MessageHandler {
    func handleMessage(_ message : ReadObjectsResponse?){
        if let message = message {
            print("Got \(message.objects.count) Objects. Implement attaching to scene!")
        }else{
            print("ReadObjectsResponse with insufficient data")
        }
    }
}
