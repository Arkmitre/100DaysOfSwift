//
//  GameScene.swift
//  Project 11
//
//  Created by Alexander on 25/08/2024.
//  Copyright © 2024 Alexander Khorkov. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var scoreLabel : SKLabelNode!
    
    var ballCount = 0
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score \(score)"
        }
    }
    
    var editLabel : SKLabelNode!
    
    var editingMode : Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }

    func randomColor() -> String {
        let colors = ["ballRed", "ballGrey", "ballCyan", "ballBlue", "ballGreen", "ballPurple", "ballYellow"]
        let index = Int(arc4random_uniform(UInt32(colors.count)))
        let color = colors[index]
        return color
    }

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
        
        makeSlot(at: CGPoint(x: 128, y: 0) , isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0) , isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0) , isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0) , isGood: false)
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let  touch = touches.first  else { return }
        let location = touch.location(in: self)
        let objects = nodes(at: location)
        
        if objects.contains(editLabel) {
            editingMode = !editingMode
        } else {
            if editingMode {
                
                let size = CGSize(width: Int(arc4random_uniform(128) + 16), height: 16)
                let box = SKSpriteNode(color: UIColor(
                    red: CGFloat(Float(arc4random_uniform(10))*0.1),
                    green: CGFloat(Float(arc4random_uniform(10))*0.1),
                    blue: CGFloat(Float(arc4random_uniform(10))*0.1),
                    alpha: 1) , size: size)
                box.zRotation = CGFloat(arc4random_uniform(3))
                box.position = location
                
                box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                box.physicsBody?.isDynamic = false
                box.physicsBody?.contactTestBitMask = box.physicsBody?.collisionBitMask ?? 0
                box.name = "box"
                
                addChild(box)
            } else {
                let ball = SKSpriteNode(imageNamed: randomColor())
                ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                ball.physicsBody?.restitution = 0.4
                ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                ball.position = CGPoint(x: location.x, y: 700)
                ball.name = "ball"

                if !(ballCount >= 5) {
                    addChild(ball)
                    ballCount += 1
                }
                

                
                }
                
            }
        }
    
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    func collision(between ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
            score += 1
        } else if object.name == "bad" {
            destroy(ball: ball)
            score -= 1
            }
        }
    func collision(between ball: SKNode, box: SKNode) {
        destroy(box: box)
        score += 1
    }
    
    func destroy(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        
        ball.removeFromParent()
        
    }
    func destroy(box: SKNode) {
        box.removeFromParent()
    }
    

    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyB.node?.name == "box" {
            collision(between: contact.bodyA.node!, box: contact.bodyB.node!)
        } else if contact.bodyA.node?.name == "box" {
            collision(between: contact.bodyB.node!, box: contact.bodyA.node!)
        }
        if contact.bodyA.node?.name == "ball" {
            collision(between: contact.bodyA.node!, object: contact.bodyB.node!)
        } else if contact.bodyB.node?.name == "ball" {
            collision(between: contact.bodyB.node!, object: contact.bodyA.node!)
        }
    }
    
}
