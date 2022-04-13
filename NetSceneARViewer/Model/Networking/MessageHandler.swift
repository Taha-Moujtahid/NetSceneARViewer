//
//  NetSceneServerMessageHandler.swift
//  NetSceneServer
//
//  Created by Taha Moujtahid on 15.12.21.
//

import Foundation

struct MessageHandler {
    
    //TODO: Make this Generic !
    func handleData(data : Data){
        print("Received message: ")
        if let message = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
            if(message["messageType"] != nil){
                switch(message["messageType"] as! String){
                    
                case JoinLobbyResponse.messageType:
                    handleMessage(try? JSONDecoder().decode(JoinLobbyResponse.self, from: JSONSerialization.data(withJSONObject: message, options: [])) )
                    break
                case CreateObjectMessage.messageType:
                    handleMessage(try? JSONDecoder().decode(CreateObjectMessage.self, from: JSONSerialization.data(withJSONObject: message, options: [])) )
                    break
                case ReadObjectsResponse.messageType:
                    handleMessage(try? JSONDecoder().decode(ReadObjectsResponse.self, from: JSONSerialization.data(withJSONObject: message, options: [])) )
                    break
                case UpdateObjectMessage.messageType:
                    handleMessage(try? JSONDecoder().decode(UpdateObjectMessage.self, from: JSONSerialization.data(withJSONObject: message, options: [])) )
                    break
                case DeleteObjectMessage.messageType:
                    handleMessage(try? JSONDecoder().decode(DeleteObjectMessage.self, from: JSONSerialization.data(withJSONObject: message, options: [])) )
                    break
                case LockEntityResponse.messageType:
                    handleMessage(try? JSONDecoder().decode(LockEntityResponse.self, from: JSONSerialization.data(withJSONObject: message, options: [])) )
                    break
                case UnlockEntityResponse.messageType:
                    handleMessage(try? JSONDecoder().decode(UnlockEntityResponse.self, from: JSONSerialization.data(withJSONObject: message, options: [])) )
                    break
                case ReadLobbiesResponse.messageType:
                    handleMessage(try? JSONDecoder().decode(ReadLobbiesResponse.self, from: JSONSerialization.data(withJSONObject: message, options: [])) )
                    break
                default:
                    handleMessage( message)
                    
                }
            }else{
                handleMessage( message)
            }
        }
    }
    
    func handleMessage(_ message : [String:Any]){
        print("WARNING Unhandeld Message : \(message) from Server!")
    }
    
}
