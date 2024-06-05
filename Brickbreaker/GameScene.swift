//
//  GameScene.swift
//  Brickbreaker
//
//  Created by Jigar on 05/06/24.
//

// GameScene.swift

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let paddleCategory: UInt32 = 0x1 << 0
    let ballCategory: UInt32 = 0x1 << 1
    let brickCategory: UInt32 = 0x1 << 2
    let boundaryCategory: UInt32 = 0x1 << 3
    
    var paddle: SKSpriteNode!
    var ball: SKShapeNode!
    var bricks = [[SKSpriteNode]]()
    var scoreLabel: SKLabelNode!
    var score = 0
    
    var brickBreakSound: SKAction!
    var paddleBounceSound: SKAction!
    var gameOverSound: SKAction!
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        createBoundaries()
        createPaddle()
        createBall()
        createBricks()
        createScoreLabel()
        loadSounds()
    }
    
    func createBoundaries() {
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        borderBody.categoryBitMask = boundaryCategory
        borderBody.contactTestBitMask = ballCategory
        self.physicsBody = borderBody
    }
    
    func createPaddle() {
        paddle = SKSpriteNode(color: .white, size: CGSize(width: 100, height: 20))
        paddle.position = CGPoint(x: size.width / 2, y: 100)
        paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.size)
        paddle.physicsBody?.isDynamic = false
        paddle.physicsBody?.categoryBitMask = paddleCategory
        paddle.physicsBody?.contactTestBitMask = ballCategory
        paddle.physicsBody?.collisionBitMask = ballCategory
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
        ball.physicsBody?.contactTestBitMask = brickCategory | paddleCategory | boundaryCategory
        ball.physicsBody?.collisionBitMask = brickCategory | paddleCategory | boundaryCategory
        addChild(ball)
    }
    
    func createBricks() {
        let brickWidth: CGFloat = 60
        let brickHeight: CGFloat = 20
        let brickRows = 5
        let brickColumns = 8
        
        let xOffset = (size.width - (brickWidth * CGFloat(brickColumns))) / 2
        let yOffset = size.height * 0.75
        
        for row in 0..<brickRows {
            var rowBricks = [SKSpriteNode]()
            for column in 0..<brickColumns {
                let brick = SKSpriteNode(color: .random(), size: CGSize(width: brickWidth, height: brickHeight))
                brick.position = CGPoint(x: xOffset + CGFloat(column) * brickWidth, y: yOffset - CGFloat(row) * brickHeight)
                brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
                brick.physicsBody?.isDynamic = false
                brick.physicsBody?.categoryBitMask = brickCategory
                brick.physicsBody?.contactTestBitMask = ballCategory
                brick.physicsBody?.collisionBitMask = ballCategory
                addChild(brick)
                rowBricks.append(brick)
            }
            bricks.append(rowBricks)
        }
    }
    
    func createScoreLabel() {
        scoreLabel = SKLabelNode(text: "Score: \(score)")
        scoreLabel.fontName = "Arial"
        scoreLabel.fontSize = 20
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height - 50)
        addChild(scoreLabel)
    }

    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == ballCategory | brickCategory {
            if contact.bodyA.categoryBitMask == brickCategory {
                contact.bodyA.node?.removeFromParent()
            } else {
                contact.bodyB.node?.removeFromParent()
            }
            score += 10
            scoreLabel.text = "Score: \(score)"
            run(brickBreakSound)
            createBrickExplosion(at: contact.contactPoint)
        } else if contactMask == ballCategory | paddleCategory {
            run(paddleBounceSound)
        }
    }
    
    func loadSounds() {
        brickBreakSound = SKAction.playSoundFileNamed("brick_break.mp3", waitForCompletion: false)
        paddleBounceSound = SKAction.playSoundFileNamed("paddle_bounce.mp3", waitForCompletion: false)
        gameOverSound = SKAction.playSoundFileNamed("game_over.mp3", waitForCompletion: false)
    }
    
    func createBrickExplosion(at position: CGPoint) {
        if let explosion = SKEmitterNode(fileNamed: "BrickExplosion") {
            explosion.position = position
            addChild(explosion)

            let wait = SKAction.wait(forDuration: 1.0)
            let remove = SKAction.removeFromParent()
            explosion.run(SKAction.sequence([wait, remove]))
        } else {
            print("Error: Could not load BrickExplosion.sks")
        }
    }

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        paddle.position.x = touchLocation.x
    }
    
    override func update(_ currentTime: TimeInterval) {
        if ball.position.y < 0 {
            ball.removeFromParent()
            run(gameOverSound)
            let gameOverLabel = SKLabelNode(text: "Game Over")
            gameOverLabel.fontName = "Arial"
            gameOverLabel.fontSize = 40
            gameOverLabel.fontColor = .white
            gameOverLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
            addChild(gameOverLabel)
            isPaused = true
        }
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(hue: CGFloat(arc4random() % 256) / 256.0,
                       saturation: CGFloat(arc4random() % 128) / 256.0 + 0.5,
                       brightness: CGFloat(arc4random() % 128) / 256.0 + 0.5,
                       alpha: 1.0)
    }
}
