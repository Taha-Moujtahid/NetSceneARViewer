//
//  ARVideoPanel.swift
//  NetSceneARViewer
//
//  Created by Taha Moujtahid on 09.03.22.
//

import Foundation
import SceneKit
import AVKit
import RealityKit

struct ARVideoPanel {
   
    static func createVideoPanel(width: Float, height: Float, videoUrl: URL) -> ModelEntity{
        let avPlayer = AVPlayer(url: videoUrl)
        let material = VideoMaterial(avPlayer: avPlayer)
        avPlayer.play()
        return ModelEntity(mesh: .generatePlane(width: width, height: height), materials: [material])
    }
    
}
