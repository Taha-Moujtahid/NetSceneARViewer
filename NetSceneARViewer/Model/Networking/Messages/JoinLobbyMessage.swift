//
//  JoinLobbyMessage.swift
//  NetSceneServer
//
//  Created by Taha Moujtahid on 15.12.21.
//

import Foundation

struct JoinLobbyMessage : Codable , NetMessage{
    static var messageType = "JoinLobbyMessage"
    var messageType = "JoinLobbyMessage"
    var lobbyID : String
}

struct JoinLobbyResponse : Codable , NetMessage{
    static var messageType = "JoinLobbyResponse"
    var messageType : String
    var success : Bool
}

extension MessageHandler {
    func handleMessage(_ message : JoinLobbyResponse?){
        if let message = message {
            print("Join Lobby success: \(message.success) Implement!")
            NetSceneHandler.shared.client.handleLobbyResponse(message)
        }else{
            print("Join Message with insufficient data")
        }
    }
}
