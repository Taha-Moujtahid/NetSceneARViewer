//
//  QRDetectionHandler.swift
//  NetSceneARViewer
//
//  Created by Taha Moujtahid on 02.01.22.
//

import Foundation
import Vision
import RealityKit
import ARKit

struct QRDetectionHandler : VisionDetector {
    static var detectedQRCodes = [String]()
    static var processing: Bool = false
    
    var requests = [VNRequest]()
    
    mutating func update(_ frame: CVPixelBuffer) {
        do {
            if(!QRDetectionHandler.processing){
                // Create a request handler using the captured image from the ARFrame
                let request = VNDetectBarcodesRequest(completionHandler: self.requestHandler)
                request.symbologies = [.qr]
                requests = [request]
                let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: frame, options: [:])
                try imageRequestHandler.perform(self.requests)
                QRDetectionHandler.processing = true
            }else{
                QRDetectionHandler.processing = false
            }
        } catch {
            print("error during QR Detection")
        }
    }
    
    func requestHandler(request: VNRequest, error: Error?) {
        // Get the first result out of the results, if there are any
        if let results = request.results, let result = results.first as? VNBarcodeObservation {
            guard let payload = result.payloadStringValue else {return}
            
            
            
            //PROCESS PAYLOAD HERE
            print(payload)
            
            
            // Get the bounding box for the bar code and find the center
            var rect = result.boundingBox
            // Flip coordinates
            rect = rect.applying(CGAffineTransform(scaleX: 1, y: -1))
            rect = rect.applying(CGAffineTransform(translationX: 0, y: 1))
            // Get center
            let center = CGPoint(x: rect.midX, y: rect.midY)

            checkQRCode(name: payload, center: center )
        }
        QRDetectionHandler.processing = false
    }
    
    func checkQRCode(name: String, center: CGPoint) {
        if !QRDetectionHandler.detectedQRCodes.contains(name) {
            if let hitTestResults = NetSceneARView.arView.session.currentFrame?.hitTest(center, types: [.featurePoint] ),
               let hitTestResult = hitTestResults.first {
                print("New QR \(name)")
                print(hitTestResult)
                
                let arAnchor = ARAnchor(name: "PlantNode", transform: hitTestResult.worldTransform)
                let anchor = AnchorEntity(anchor: arAnchor)
                
                //anchor.addChild(PlantNode.scene!)
                
                NetSceneARView.arView.scene.addAnchor(anchor)
                NetSceneARView.arView.session.add(anchor: arAnchor)
                
                    
                
                QRDetectionHandler.detectedQRCodes.append(name)
            }
        }
    }
    
}
