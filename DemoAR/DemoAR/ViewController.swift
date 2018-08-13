//
//  ViewController.swift
//  DemoAR
//
//  Created by Amee Thakkar on 8/11/18.
//  Copyright © 2018 Amee Thakkar. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var node = SCNNode()
    var index = 0
    let fabricList = ["fabric1","fabric2","fabric3","fabric4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/female_dressed_nested.scn")!
        
        if let femaleNode = scene.rootNode.childNode(withName: "body", recursively: true){

            femaleNode.position = SCNVector3(0,-5.1,-10.0)
//            print("Inside the loop")
            sceneView.scene.rootNode.addChildNode(femaleNode)

            self.node = femaleNode
            
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(screenSwipped))
            swipeGesture.direction = .left
            sceneView.addGestureRecognizer(swipeGesture)
            
        }
        
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    @IBAction func rotate(_ sender: UIBarButtonItem) {
        
        let rotate = SCNAction.rotateBy(x: 0, y: (CGFloat(Float.pi * 2)), z: 0, duration: 20)
        let runOnce = SCNAction.repeat(rotate, count: 1)
        node.runAction(runOnce)
        
    }
    
    @objc func screenSwipped(_ sender : UISwipeGestureRecognizer) {
        
        node.childNodes[0].geometry?.materials.first?.diffuse.contents = UIImage(named: "art.scnassets/fabric4.jpg")
        
        
        //        // on swipe left (arrays are Zero based)
        //        if index < fabricList.count - 1 {
        //            index = index + 1
        //            self.node.childNodes[0].geometry?.materials.first?.diffuse.contents = UIImage(named: "art.scnassets/\(fabricList[index]).jpg")
        //            print(fabricList[index])
        //        }
        //
        //        // on swipe right
        //        if index > 0 {
        //            index = index - 1
        //            self.node.childNodes[0].geometry?.materials.first?.diffuse.contents = UIImage(named: "art.scnassets/\(fabricList[index]).jpg")
        //        }
        
    }
    
}
