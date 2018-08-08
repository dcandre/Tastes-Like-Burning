//
//  ARViewDelegate.swift
//  Tastes Like Burning
//
//  Created by Derek Andre on 8/7/18.
//  Copyright © 2018 Derek Andre. All rights reserved.
//

import SceneKit
import ARKit

class ARSceneView: NSObject, ARSCNViewDelegate {
    private let faceQueue = DispatchQueue(label: "com.derekandre.Tastes-Like-Burning.faceQueue")
    
    private var mouth: Mouth?
    
    private let fire = SCNParticleSystem(named: "Fire.scnp", inDirectory: nil)!
    
    private var isMouthBurning = false
    
    
    func run(_ sceneView: ARSCNView) {
        guard ARFaceTrackingConfiguration.isSupported else { return }
        
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func pause(_ sceneView: ARSCNView) {
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        faceQueue.async {
            self.mouth = Mouth()
            
            node.addChildNode(self.mouth!)
            
            self.mouth!.position.y = -0.06
            self.mouth!.position.z = 0.07
            
            self.fire.emitterShape = self.mouth?.geometry!
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor else { return }
        
        if let mouth = self.mouth {
            if let jawOpenAmount = faceAnchor.blendShapes[.jawOpen] {
                if jawOpenAmount.floatValue > 0.4 {
                    if !isMouthBurning {
                        isMouthBurning = true
                        mouth.addParticleSystem(fire)
                    }
                    
                    return
                }
            }
            
            mouth.removeAllParticleSystems()
            isMouthBurning = false
        }
    }
}
