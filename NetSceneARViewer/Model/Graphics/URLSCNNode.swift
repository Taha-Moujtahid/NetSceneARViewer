//
//  URLSCNNode.swift
//  NetSceneARViewer
//
//  Created by Taha Moujtahid on 20.01.22.
//

import Foundation
import SceneKit

extension SCNScene {
    
    static func loadFromUrl(_ url : URL, onLoaded: @escaping (SCNScene?)->()) async {
        let downloadTask = URLSession.shared.downloadTask(with: url) {
            urlOrNil, responseOrNil, errorOrNil in
            // check for and handle errors:
            // * errorOrNil should be nil
            // * responseOrNil should be an HTTPURLResponse with statusCode in 200..<299
            
            guard let fileURL = urlOrNil else { return }
            do {
                let documentsURL = try
                    FileManager.default.url(for: .documentDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: nil,
                                            create: false)
                var savedURL = documentsURL.appendingPathComponent(fileURL.lastPathComponent)
                savedURL.appendPathExtension("usdz")
                try FileManager.default.moveItem(at: fileURL, to: savedURL)
                
                print("file \(fileURL) - saved as \(savedURL)")
                onLoaded(try? SCNScene(url: savedURL, options: nil))
                
            } catch {
                print ("file error: \(error)")
            }
        }
        downloadTask.resume()
    }
}
