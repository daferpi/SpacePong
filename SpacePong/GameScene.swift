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
    var ball: SKShapeNode!
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    
    lazy var leftBarPosX = -(self.size.width/2) + 20
    lazy var rightBarPosX = (self.size.width/2) - 40
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        // create elements
        self.leftBar = self.createBar(size: CGSize.init(width: 20, height: 160), position: CGPoint(x: leftBarPosX, y: 0))
        self.rightBar = self.createBar(size: CGSize.init(width: 20, height: 160), position: CGPoint(x: rightBarPosX, y: 0))
        self.ball = self.createBall(radius: 18)
    
        
        
        self.addChild(self.leftBar)
        self.addChild(self.rightBar)
        self.addChild(self.ball)

        self.moveBall()
    }
    
    func createBar(size: CGSize, position: CGPoint) -> SKShapeNode {
        let myNode = SKShapeNode.init(rectOf: size)
        myNode.position = position
        myNode.fillColor = SKColor.red
        return myNode
    }
    
    func createBall(radius: CGFloat) -> SKShapeNode {
        let ball = SKShapeNode(circleOfRadius: 18)
        ball.position = CGPoint(x: 0, y: 0)
        ball.fillColor = .green
        return ball
    }

    private func moveBall() {
        let actualDuration = 8

        var height = CGFloat(1048)

        if let heightValue = self.view?.frame.height {
            height = heightValue
        }

        let yPosition = random(min: 0, max: 340)
        let xPosition = random(min: 0, max: height)
        let toPoint = CGPoint(x: xPosition, y: yPosition)
        let actionMove = SKAction.move(to: toPoint, duration: TimeInterval(actualDuration))

        self.ball.run(actionMove)
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        moveBall()
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

    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }

    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }

}
