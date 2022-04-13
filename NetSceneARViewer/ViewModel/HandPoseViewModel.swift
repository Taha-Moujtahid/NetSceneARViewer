//
//  HandPoseViewModel.swift
//  NetSceneARViewer
//
//  Created by Taha Moujtahid on 20.01.22.
//

import Foundation
import SwiftUI

struct HandPoseViewModel: View {
    @ObservedObject var handPose = HandPosePositions.shared
    
    var body: some View {
        GeometryReader{ screen in
            ZStack{
                Circle()
                    .fill(Color.green)
                    .frame(width: 10, height: 10)
                    .position(x: handPose.indexFingerTip.x , y: handPose.indexFingerTip.y )
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 10, height: 10)
                    .position(x: handPose.thumbTip.x, y: handPose.thumbTip.y )
            }
        }
    }
}
