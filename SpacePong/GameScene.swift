//
//  GameScene.swift
//  SpacePong
//
//  Created by abelFernandez on 16/03/2019.
//  Copyright © 2019 daferpi. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var leftBar: SKShapeNode!
    var rightBar: SKShapeNode!
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    
    lazy var leftBarPosX = -(self.size.width/2) + 20
    lazy var rightBarPosX = (self.size.width/2) - 40
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
//
//        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//        }
        
        self.leftBar = self.createBar(size: CGSize.init(width: 20, height: 160), position: CGPoint(x: leftBarPosX, y: 0))
        self.rightBar = self.createBar(size: CGSize.init(width: 20, height: 160), position: CGPoint(x: rightBarPosX, y: 0))
        
        self.addChild(self.leftBar)
        self.addChild(self.rightBar)
    }
    
    func createBar(size: CGSize, position: CGPoint) -> SKShapeNode {
        let myNode = SKShapeNode.init(rectOf: size)
        myNode.position = position
        myNode.fillColor = SKColor.red
        return myNode
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            
            if t.location(in: self).x > 0 {
                let newPoint = CGPoint(x: rightBarPosX, y: t.location(in: self).y)
                self.rightBar.position = newPoint
            } else {
                let newPoint = CGPoint(x: leftBarPosX, y: t.location(in: self).y)
                self.leftBar.position = newPoint
            }
        }
    }

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
