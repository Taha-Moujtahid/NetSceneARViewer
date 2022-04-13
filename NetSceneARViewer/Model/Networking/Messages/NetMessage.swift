//
//  NetMessage.swift
//  NetSceneServer
//
//  Created by Taha Moujtahid on 16.12.21.
//

import Foundation

protocol NetMessage : Codable{
    static var messageType : String { get } 
}
