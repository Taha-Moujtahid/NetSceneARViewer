//
//  NetSceneClient.swift
//  NetSceneARViewer
//
//  Created by Taha Moujtahid on 18.01.22.
//

import Foundation
import Network

let LocalNetSceneConnection = NWConnection(host: "109.90.110.70", port: NWEndpoint.Port(51211), using: .udp)

struct NetSceneClient : Identifiable{
    
    let id = UUID().uuidString
    let connection : NWConnection
    let messageHandler: MessageHandler
    let messageQueue: DispatchQueue
    
    
    private var lobbyID : String?
    
    mutating func joinLobby(_ lobbyID: String){
        self.lobbyID = lobbyID
        self.send(try! JSONEncoder().encode(JoinLobbyMessage(lobbyID: lobbyID)), onSent: nil)
    }
    
    mutating func handleLobbyResponse(_ lobbyResponse : JoinLobbyResponse){
        if(!lobbyResponse.success){
            self.lobbyID = ""
        }
    }
    
    init(connection: NWConnection){
        self.connection = connection
        self.messageHandler = MessageHandler()
        self.messageQueue = DispatchQueue(label: "ClientQueue")
        self.connection.start(queue: self.messageQueue)
        self.listen()
    }
    
    
    func send(_ data : Data , onSent: ( ()->() )? ){
        connection.send(content: data, completion: .contentProcessed({ error in
            if let error = error {
                print(error)
            }else{
                if let onSent = onSent {
                    onSent()
                }
            }
        }))
        
    }
    
    func listen(){
        print("listen")
        connection.receiveMessage { completeContent, contentContext, isComplete, error in
            if error == nil {
                print(completeContent!)
                messageHandler.handleData(data: completeContent!)
            }else{
                print(error!)
            }
            
            listen()
        }
    }
}

