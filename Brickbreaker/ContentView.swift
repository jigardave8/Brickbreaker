//
//  ContentView.swift
//  Brickbreaker
//
//  Created by Jigar on 05/06/24.
//

import SwiftUI
import SpriteKit

// Constants
let brickRows = 5
let brickColumns = 10
let brickWidth: CGFloat = 40
let brickHeight: CGFloat = 20
let brickSpacing: CGFloat = 2
let paddleWidth: CGFloat = 100
let paddleHeight: CGFloat = 20
let ballRadius: CGFloat = 10

// Brick colors
let brickColors: [UIColor] = [.red, .orange, .yellow, .green, .blue]

// GameScene class
class GameScene: SKScene, SKPhysicsContactDelegate {
    var paddle: SKSpriteNode!
    var ball: SKShapeNode!
    var bricks = [[SKSpriteNode]]()
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        createPaddle()
        createBall()
        createBricks()
    }
    
    func createPaddle() {
        paddle = SKSpriteNode(color: .white, size: CGSize(width: paddleWidth, height: paddleHeight))
        paddle.position = CGPoint(x: size.width / 2, y: paddleHeight)
        paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.size)
        paddle.physicsBody?.isDynamic = false
        addChild(paddle)
    }
    
    func createBall() {
        ball = SKShapeNode(circleOfRadius: ballRadius)
        ball.position = CGPoint(x: size.width / 2, y: paddleHeight + ballRadius * 2)
        ball.fillColor = .white
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.friction = 0
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.velocity = CGVector(dx: 300, dy: 300)
        addChild(ball)
    }
    
    func createBricks() {
        for row in 0..<brickRows {
            var rowBricks = [SKSpriteNode]()
            for column in 0..<brickColumns {
                let brick = SKSpriteNode(color: brickColors[row % brickColors.count], size: CGSize(width: brickWidth, height: brickHeight))
                brick.position = CGPoint(x: brickWidth / 2 + brickSpacing + CGFloat(column) * (brickWidth + brickSpacing), y: size.height - CGFloat(row) * (brickHeight + brickSpacing))
                brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
                brick.physicsBody?.isDynamic = false
                addChild(brick)
                rowBricks.append(brick)
            }
            bricks.append(rowBricks)
        }
    }
}

// ContentView struct
struct ContentView: View {
    var scene: SKScene {
        let scene = GameScene(size: CGSize(width: 400, height: 600))
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .frame(width: 400, height: 600)
            .edgesIgnoringSafeArea(.all)
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
