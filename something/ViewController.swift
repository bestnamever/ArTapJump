//
//  ViewController.swift
//  something
//
//  Created by Yu Hong on 2021/1/9.
//

import UIKit
import ARKit
import SceneKit

class ViewController: UIViewController{

    @IBOutlet weak var sceneView: ARSCNView!
    
    
    private var boxNodes: [SCNNode] = []
    private var nextDirection: NextDirection = .left
    private lazy var bottleNode:BottleNode = {
        return BottleNode()
    }()
    
    private var maskTouch: Bool = false
    
    private var touchTimePair: (begin:TimeInterval,end: TimeInterval) = (0,0)
    private let distanceCalculateClousre: (TimeInterval) -> CGFloat = {
        return CGFloat($0) / 4.0
    }
    
    let config = ARWorldTrackingConfiguration()
    
    private var score: UInt = 0 {
        didSet{
            DispatchQueue.main.async {
                [unowned self] in
                self.scoreLabel.text = "\(self.score)"
                
            }
        }
    }
    
    
    private var highestScore = ScoreHelper.shared.getHighestScore()
    
    
    private let scoreLabel = UILabel(frame: CGRect(x: 50, y: 50, width: UIScreen.main.bounds.width - 100, height: 30))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.session.run(config)
        
        scoreLabel.font = UIFont(name: "HelveticaNeue", size: 30.0)
        scoreLabel.textColor = .white
        
        
        sceneView.addSubview(scoreLabel)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        config.planeDetection = .horizontal
//        config.isLightEstimationEnabled = true
//
//        scoreLabel.font = UIFont(name: "HelveticaNeue", size: 30.0)
//        scoreLabel.textColor = .white
//        sceneView.addSubview(scoreLabel)
//
//        restartGame()
//    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        sceneView.session.pause()
//    }

    private func generateBox(at realPostion:SCNVector3){
        let box = SCNBox(width: 0.2, height: 0.05, length: 0.2, chamferRadius: 0.0)
        let node = SCNNode(geometry: box)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.randomColor()
        box.materials = [material]
        
        if boxNodes.isEmpty
        {
            node.position = realPostion
        } else{
            nextDirection = NextDirection(rawValue: Int.random(in: 0...1))!
            
            let deltaDistance = Double(arc4random() % 25 + 25 ) / 100.0
            
            if nextDirection == .left{
                node.position = SCNVector3(realPostion.x + Float(deltaDistance),realPostion.y ,realPostion.z)
            } else{
                node.position = SCNVector3(realPostion.x ,realPostion.y ,realPostion.z + Float(deltaDistance) )
                
            }
            
        }
        
        self.sceneView.scene.rootNode.addChildNode(node)
        boxNodes.append(node)
        
    }
    
    func restartGame(){
        highestScore = ScoreHelper.shared.getHighestScore()
        touchTimePair=(0,0)
        score = 0
        boxNodes.forEach{
            $0.removeFromParentNode()
        }
        bottleNode.removeFromParentNode()
        boxNodes.removeAll()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if boxNodes.isEmpty{
        func addConeNode(){
            bottleNode.position = SCNVector3(boxNodes.last!.position.x,
                                             boxNodes.last!.position.y + 0.15 * 0.75,
                                             boxNodes.last!.position.z)
            sceneView.scene.rootNode.addChildNode(bottleNode)
        }
        func anyPositionFrom(location: CGPoint) -> (SCNVector3)? {
            let results =  sceneView.hitTest(location, types: .featurePoint)
            guard !results.isEmpty else{
                return nil
            }
            return SCNVector3.positionFromTransform(results[0].worldTransform)
        }
        
        let location = touches.first?.location(in: sceneView)
        if let position = anyPositionFrom(location: location!){
            generateBox(at: position)
            addConeNode()
            generateBox(at: boxNodes.last!.position)
        }
        } else{
            if !maskTouch{
                maskTouch.toggle()
            }
            touchTimePair.begin = (event?.timestamp)!
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if maskTouch{
            maskTouch.toggle()
            
            touchTimePair.end = (event?.timestamp)!
            
            let distance = distanceCalculateClousre(touchTimePair.end - touchTimePair.begin)
            var actions = [SCNAction()]
            if nextDirection == .left{
                let move1 = SCNAction.moveBy(x: distance, y: 0.2, z: 0.0, duration: 0.25)
                let move2 = SCNAction.moveBy(x: distance, y: -0.2, z: 0.0, duration: 0.25)
                actions = [SCNAction.rotateBy(x: 0, y: 0, z: -.pi * 2, duration: 0.5),SCNAction.sequence([move1,move2])]
            }
            else{
                let move1 = SCNAction.moveBy(x: 0, y: 0.2, z: 0.2, duration: 0.25)
                let move2 = SCNAction.moveBy(x: 0, y: -0.2, z: 0.2, duration: 0.25)
                actions = [SCNAction.rotateBy(x: .pi * 2, y: 0, z: 0, duration: 0.5),SCNAction.sequence([move1,move2])]
            }
            
            bottleNode.recover()
            bottleNode.runAction(SCNAction.group(actions),completionHandler: { [weak self] in
                let boxNode = (self?.boxNodes.last!)!
                if(self?.bottleNode.isNotContainedXZ(in: boxNode))!{
                    if(self?.score != 0)
                    {
                    ScoreHelper.shared.setHighestScore(Int((self?.score)!))
                    ScoreHelper.shared.setLastestScore(Int((self?.score)!))
                    ScoreHelper.shared.setAllScore(Int((self?.score)!))
                    }
                    
                    
                    var restartPosition : SCNVector3 = SCNVector3()
                    restartPosition = SCNVector3(x: 0, y: 0.2, z: 0)
                    let restartNode = BubbleTextNode(text: "new game", at: restartPosition)
                    restartNode.position = restartPosition
                    self?.bottleNode.addChildNode(restartNode)
                    
                    let action = SCNAction.move(by: SCNVector3(x: 0, y: 0.2, z: 0), duration: 1.0)
                    restartNode.runAction(action,completionHandler: {restartNode.removeFromParentNode()})
                    
                    self?.restartGame()
                }
                else{
                    self?.score += 1
                    
                    var scorePosition : SCNVector3 = SCNVector3()
                    scorePosition = SCNVector3(x: 0, y: 0.2, z: 0)
                    let scoreNode = BubbleTextNode(text: "+ 1", at: scorePosition)
                    scoreNode.position = scorePosition
                    self?.bottleNode.addChildNode(scoreNode)
                    
                    let action = SCNAction.move(by: SCNVector3(x: 0, y: 0.2, z: 0), duration: 0.75)
                    scoreNode.runAction(action,completionHandler: {scoreNode.removeFromParentNode()})
                    
                    self?.generateBox(at: (self?.boxNodes.last!.position)!)
                }
            })
        }
    }
    
}

