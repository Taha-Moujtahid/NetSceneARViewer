//
//  NetSceneARView.swift
//  NetSceneARViewer
//
//  Created by Taha Moujtahid on 01.01.22.
//
import Foundation
import SwiftUI
import RealityKit
import ARKit
import Combine

struct NetSceneARView: UIViewRepresentable {
    
    static let arViewDelegate = ARViewDelegate()
    static let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true )
    
    func makeUIView(context: Context) -> ARView {
        
        NetSceneARView.arViewDelegate.arView = NetSceneARView.arView
        NetSceneARView.arView.session.delegate = NetSceneARView.arViewDelegate
        NetSceneARView.arView.debugOptions = [.showWorldOrigin, .showAnchorOrigins, .showSceneUnderstanding, .showAnchorGeometry]
        let config = ARWorldTrackingConfiguration()
        config.initialWorldMap = loadARWorldMap()
        NetSceneARView.arView.session.run(config)
        NetSceneARView.arViewDelegate.configure()
        NetSceneARView.arViewDelegate.registerDetectors()
        ARScene.loadMainAsync(completion: { result in
            if let scene = try? result.get() {
                PlantNode.scene = scene
                PlantNode.sceneLoaded = true
            }else{
                print("could not load PlantScene")
            }
        })
        return NetSceneARView.arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    
    func loadARWorldMap() -> ARWorldMap?{
        let worldMap: ARWorldMap = {
            guard let data = try? Data(contentsOf: ARViewProps.shared.mapSaveURL)
                else { fatalError("Map data should already be verified to exist before Load button is enabled.") }
            do {
                guard let worldMap = try NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: data)
                    else { fatalError("No ARWorldMap in archive.") }
                return worldMap
            } catch {
                fatalError("Can't unarchive ARWorldMap from file data: \(error)")
            }
        }()
        
        return worldMap
    }
    
}



class ARViewDelegate : NSObject, ARSessionDelegate {
    var arView : ARView?
    var detectors = [VisionDetector]()
    var processing = false
    var UIPlane = ModelEntity(mesh: .generatePlane(width: 2, height: 1))
    var basicUIView = BasicPartInformationView()
    
    func configure(){
        var uiPlaneAnchor = AnchorEntity()
        uiPlaneAnchor.addChild(UIPlane)
        arView!.scene.addAnchor(uiPlaneAnchor)
    }
    
    func renderUI(){
        if arView != nil {
            var material = PhysicallyBasedMaterial()
            basicUIView.saveAsImage(width:1000, height:500){ image in
                material.baseColor.texture = try!
                PhysicallyBasedMaterial.Texture(
                    TextureResource
                        .generate(from: image.cgImage! ,
                                  withName: "UIPlaneTexture",
                                  options: .init(semantic: .color)
                                 )
                )
                self.UIPlane.model!.materials = [material]
            }
        }
    }
    
    func registerDetectors(){
        detectors.append(QRDetectionHandler())
        //TODO: ADD HAND DETECTION detectors.append(HandDetectionHandler())
        
        Task(){
            while(true){
                for var detector in detectors {
                    if let currentFrame = await arView?.session.currentFrame?.capturedImage{
                        detector.update(currentFrame)
                    }
                }
                await Task.sleep(UInt64(0.15 * Double(NSEC_PER_SEC)))
            }
        }
        
        Task(){
            await Task.sleep(UInt64(3 * Double(NSEC_PER_SEC)))
            DispatchQueue.main.async {
                self.renderUI()
            }
        }
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        print("anchor \(anchors.first) added")
        
        /*if(anchors.first!.name == "PlantNode"){
            let anchor = AnchorEntity(anchor: anchors.first!)
            anchor.addChild(PlantNode.modelEntity)
            NetSceneARView.arView.scene.addAnchor(anchor)
        }*/
        
        /*for anchor in anchors {
            Task {
                await SCNScene.loadFromUrl(URL(string: "http://netscene.bytesentertainment.de/uploads/cup_saucer_set_d28cb8cd36.usdz?updated_at=2022-01-20T13:56:11.162Z")!) { scene in
                    if let scene = scene {
                        DispatchQueue.main.async {
                            scene.rootNode.transform = SCNMatrix4(anchors.first!.transform)
                            
                            scene.rootNode.childNodes.forEach { node in
                                
                                node.transform = SCNMatrix4(anchors.first!.transform)
                                node.scale.x = 0.01
                                node.scale.y = 0.01
                                node.scale.z = 0.01
                                self.sceneView?.scene.rootNode.addChildNode(node)
                            }
                        }
                    }
                }
             print("anchor \(anchor)")
            }
            
        }*/
        
        
        /*
        let anchor = AnchorEntity(anchor: anchors.first!)
        anchor.addChild(ARVideoPanel.createVideoPanel(width: 16, height: 9, videoUrl: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!))
        arView?.scene.addAnchor(anchor)
         */
    }
    
    //https://stackoverflow.com/questions/45185555/scenekit-get-direction-of-camera
    func getUserVector(frame: ARFrame?) -> (SCNVector3, SCNVector3, SCNVector4) { // (direction, position)
        if let frame = frame {
            let mat = SCNMatrix4(frame.camera.transform) // 4x4 transform matrix describing camera in world space
            let dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33) // orientation of camera in world space
            let pos = SCNVector3(mat.m41, mat.m42, mat.m43) // location of camera in world space
            let node = SCNNode()
            node.transform = SCNMatrix4(frame.camera.transform)
            
            return (dir, pos, node.rotation)
        }
        return (SCNVector3(0, 0, -1), SCNVector3(0, 0, -0.2), SCNVector4(0,0,0,0))
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        if(!ARViewProps.shared.isUILocked){
            let (cameraDirection, _, _) = getUserVector(frame: frame)
            let cameraTransform = frame.camera.transform
            UIPlane.transform = Transform(matrix: cameraTransform)
            UIPlane.transform.translation.x +=  cameraDirection.x * 4
            UIPlane.transform.translation.y += cameraDirection.y * 4
            UIPlane.transform.translation.z +=  cameraDirection.z * 4
            
        }
    }
    
}


