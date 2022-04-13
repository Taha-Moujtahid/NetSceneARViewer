//
//  NetSceneHandler.swift
//  NetSceneARViewer
//
//  Created by Taha Moujtahid on 18.01.22.
//

import Foundation

class NetSceneHandler : ObservableObject {
    static let shared = NetSceneHandler()
    var client = NetSceneClient(connection: LocalNetSceneConnection)
    @Published var lobbies = [String]()
}
