//
//  GameScene.swift
//  Brickbreaker
//
//  Created by Jigar on 05/06/24.
//

// GameScene.swift

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    // Constants
    let paddleCategory: UInt32 = 0x1 << 0
    let ballCategory: UInt32 = 0x1 << 1
    let brickCategory: UInt32 = 0x1 << 2
    let boundaryCategory: UInt32 = 0x1 << 3
    
    // Properties
    var paddle: SKSpriteNode!
    var ball: SKShapeNode!
    var bricks = [[SKSpriteNode]]()
    var scoreLabel: SKLabelNode!
    var score = 0
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        createPaddle()
        createBall()
        createBricks()
        createScoreLabel()
    }
    
    func createPaddle() {
        paddle = SKSpriteNode(color: .white, size: CGSize(width: 100, height: 20))
        paddle.position = CGPoint(x: size.width / 2, y: 100)
        paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.size)
        paddle.physicsBody?.isDynamic = false
        paddle.physicsBody?.categoryBitMask = paddleCategory
        addChild(paddle)
    }
    
    func createBall() {
        ball = SKShapeNode(circleOfRadius: 10)
        ball.position = CGPoint(x: size.width / 2, y: 200)
        ball.fillColor = .white
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.friction = 0
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.velocity = CGVector(dx: 300, dy: 300)
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = brickCategory | boundaryCategory
        addChild(ball)
    }
    
    func createBricks() {
        // Implement brick creation logic here
    }
    
    func createScoreLabel() {
        // Implement score label creation logic here
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        paddle.position.x = touchLocation.x
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Implement update logic here
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // Implement collision handling logic here
    }
}
