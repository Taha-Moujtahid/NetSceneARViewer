//
//  LockEntityMessage.swift
//  NetSceneServer
//
//  Created by Taha Moujtahid on 12.01.22.
//

import Foundation

struct LockEntityMessage : Codable , NetMessage{
    static var messageType = "LockEntityMessage"
    var entityID : String
}

struct LockEntityResponse : Codable , NetMessage{
    static var messageType = "LockEntityResponse"
    var success : Bool
}

extension MessageHandler {
    func handleMessage(_ message : LockEntityResponse?){
        if let message = message {
            print("Lock Entity success: \(message.success)")
        }else{
            print("LockEntityResponse with insufficient data")
        }
    }
}
