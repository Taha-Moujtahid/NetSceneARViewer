//
//  SettingsView.swift
//  NetSceneARViewer
//
//  Created by Taha Moujtahid on 19.01.22.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var netSceneHandler = NetSceneHandler.shared
    
    var body: some View {
        VStack{
            Text("Available Lobbies:").font(.headline).padding()
            List(netSceneHandler.lobbies, id: \.self){ lobby in
                Text("\(lobby)").onTapGesture {
                    netSceneHandler.client.joinLobby(lobby)
                }
            }
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
