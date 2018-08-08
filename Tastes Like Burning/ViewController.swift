//
//  ViewController.swift
//  Tastes Like Burning
//
//  Created by Derek Andre on 8/7/18.
//  Copyright © 2018 Derek Andre. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    
    var arSceneView = ARSceneView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = arSceneView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        arSceneView.run(sceneView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        arSceneView.pause(sceneView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()        
        
    }
}
