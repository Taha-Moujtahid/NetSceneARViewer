//
//  HandPosePosition.swift
//  NetSceneARViewer
//
//  Created by Taha Moujtahid on 21.01.22.
//

import Foundation
import SwiftUI

class HandPosePositions : ObservableObject{
    static var shared = HandPosePositions()
    @Published var indexFingerTip = CGPoint(x: 0.5,y: 0.5)
    @Published var thumbTip = CGPoint(x: 0.5,y: 0.5)
    @Published var isGrabbing = false
    var grabHandler : ()->Void = {}
    
    func processFingers(){
        if( abs(indexFingerTip.x - thumbTip.x) < 30 &&
            abs(indexFingerTip.y - thumbTip.y) < 30) {
            DispatchQueue.main.async {
                self.isGrabbing = true
                self.grabHandler()
            }
            
        }else{
            DispatchQueue.main.async {
                self.isGrabbing = false
            }
        }
    }

}
