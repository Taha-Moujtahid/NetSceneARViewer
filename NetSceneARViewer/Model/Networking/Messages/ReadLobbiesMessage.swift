//
//  ReadLobbiesMessage.swift
//  NetSceneServer
//
//  Created by Taha Moujtahid on 13.01.22.
//

import Foundation

struct ReadLobbiesMessage : Codable, NetMessage {
    static var messageType = "ReadLobbiesMessage"
    var messageType = "ReadLobbiesMessage"
}

struct ReadLobbiesResponse : Codable, NetMessage {
    static var messageType = "ReadLobbiesResponse"
    var messageType = "ReadLobbiesResponse"
    var lobbies : [String]
}

extension MessageHandler {
    func handleMessage(_ message : ReadLobbiesResponse?){
        if let message = message {
            print("\(message.lobbies.count) Lobbies available!")
            DispatchQueue.main.async {
                NetSceneHandler.shared.lobbies = message.lobbies
            }
        }else{
            print("ReadLobbiesResponse with insufficient Data!")
        }
    }
}
