//
//  SceneObject.swift
//  NetSceneServer
//
//  Created by Taha Moujtahid on 01.12.21.
//

import Foundation

class SceneObject : Entity, Decodable{
    
    private var data : SceneObjectData?
    
    init(objectType : String){
        self.data = SceneObjectData(objectType: objectType, position: Vec3(0,0,0), rotation: Vec3(0,0,0))
    }
    
    func getData()->SceneObjectData{
        return data!
    }
    
    func setData(_ data: SceneObjectData){
        self.data = data
    }
    
    init(objectType : String, position: Vec3, rotation: Vec3){
        self.data = SceneObjectData(objectType: objectType, position: position, rotation: rotation)
    }
    
    func addTag(_ tag: String) -> Bool{
        if(data!.tags.contains(tag)){
            return false
        }else{
            data!.tags.append(tag)
            return true
        }
    }
    
}

struct Vec3 : Codable , Equatable {
    var x : Float
    var y : Float
    var z : Float
    
    init(_ x:Float, _ y: Float, _ z: Float){
        self.x = x
        self.y = y
        self.z = z
    }
}

struct SceneObjectData : Codable{
    let objectType: String
    var name: String?
    var tags = [String]()
    var position: Vec3
    var rotation: Vec3
}

class Entity : Identifiable{
    var id = UUID().uuidString
}
