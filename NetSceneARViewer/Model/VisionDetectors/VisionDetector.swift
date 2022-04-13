//
//  VisionDetector.swift
//  NetSceneARViewer
//
//  Created by Taha Moujtahid on 02.01.22.
//

import Foundation
import Vision
import RealityKit


protocol VisionDetector{
    
    var requests : [VNRequest] { get set }
    static var processing : Bool { get set }
    
    func requestHandler(request : VNRequest, error : Error?)
    
    mutating func update( _ frame: CVPixelBuffer) 
    
    mutating func stop()
    
}

extension VisionDetector {
    mutating func stop(){
        requests = [VNRequest]()
    }
}
