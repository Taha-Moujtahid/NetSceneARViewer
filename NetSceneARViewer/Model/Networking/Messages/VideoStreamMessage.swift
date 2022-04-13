//
//  VideoStreamMessage.swift
//  NetSceneServer
//
//  Created by Taha Moujtahid on 16.12.21.
//

import Foundation

struct VideoStreamMessage : Codable, NetMessage {
    static var messageType = "VideoStreamMessage"
    var messageType = "VideoStreamMessage"
    var frame : String // NEEDS TO BE BASE64 ENCODED!
    var partID: Int
    var partCount: Int
}

extension MessageHandler {
    func handleMessage( _ message : VideoStreamMessage?){
        if let message = message {
            print("VideoStream received \(message.partID)/\(message.partCount)")
        }else{
            print("VideoStreamMessage with insufficient data")
        }
    }
}
