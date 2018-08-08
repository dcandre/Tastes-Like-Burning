//
//  MouthEmitter.swift
//  Tastes Like Burning
//
//  Created by Derek Andre on 8/7/18.
//  Copyright © 2018 Derek Andre. All rights reserved.
//

import SceneKit

class Mouth: SCNNode {
    override init() {
        super.init()
        
        self.geometry = createSphere()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSphere() -> SCNSphere {
        let sphere = SCNSphere(radius: 0.03)
        
        let sphereMaterial = sphere.firstMaterial!
        sphereMaterial.lightingModel = SCNMaterial.LightingModel.constant
        sphereMaterial.diffuse.contents = UIColor.clear
        
        return sphere
    }
}
