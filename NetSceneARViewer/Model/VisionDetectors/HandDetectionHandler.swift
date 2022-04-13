//
//  HandDetectionHandler.swift
//  NetSceneARViewer
//
//  Created by Taha Moujtahid on 02.01.22.
//

import Foundation
import Vision
import ARKit
import RealityKit

struct HandDetectionHandler : VisionDetector{
    
    var requests = [VNRequest]()
    
    static var processing = false
    
    func requestHandler(request: VNRequest, error: Error?) {
        if let results = request.results?.first as? VNRecognizedPointsObservation {
            if let fingerTipPosition = try? results.recognizedPoint(forKey: VNHumanHandPoseObservation.JointName.indexTip.rawValue) {
                if(fingerTipPosition.confidence > 0.5){
                    
                    HandPosePositions.shared.indexFingerTip =
                    CGPoint(x: fingerTipPosition.location.y * UIScreen.main.bounds.width,
                            y: fingerTipPosition.location.x * UIScreen.main.bounds.height - 50)
                }
            }
            
            if let thumbTipPosition = try? results.recognizedPoint(forKey: VNHumanHandPoseObservation.JointName.thumbTip.rawValue) {
                if(thumbTipPosition.confidence > 0.5){
                    HandPosePositions.shared.thumbTip =
                    CGPoint(x: thumbTipPosition.y * UIScreen.main.bounds.width,
                            y: thumbTipPosition.x * UIScreen.main.bounds.height - 50)
                }
            }
            
        }
        HandPosePositions.shared.processFingers()
        HandDetectionHandler.processing = false
    }
    
    mutating func update(_ frame: CVPixelBuffer) {
        do {
            if(!HandDetectionHandler.processing){
                let request = VNDetectHumanHandPoseRequest(completionHandler: self.requestHandler)
                self.requests = [request]
                // Create a request handler using the captured image from the ARFrame
                let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: frame, options: [:])
                try imageRequestHandler.perform(self.requests)
                HandDetectionHandler.processing = true
            }else{
                HandDetectionHandler.processing = false
            }
        } catch {

        }
    }
    
}
