//
//  MainMenu.swift
//  Brickbreaker
//
//  Created by Jigar on 05/06/24.
//

import SpriteKit

class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        let titleLabel = SKLabelNode(text: "Brick Breaker")
        titleLabel.fontName = "PressStart2P"
        titleLabel.fontSize = 40
        titleLabel.fontColor = .white
        titleLabel.position = CGPoint(x: size.width / 2, y: size.height / 2 + 100)
        addChild(titleLabel)
        
        let startLabel = SKLabelNode(text: "Tap to Start")
        startLabel.fontName = "PressStart2P"
        startLabel.fontSize = 20
        startLabel.fontColor = .white
        startLabel.position = CGPoint(x: size.width / 2, y: size.height / 2 - 50)
        addChild(startLabel)
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.75)
        let fadeOut = SKAction.fadeOut(withDuration: 0.75)
        let sequence = SKAction.sequence([fadeIn, fadeOut])
        startLabel.run(SKAction.repeatForever(sequence))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = SKTransition.flipHorizontal(withDuration: 1.0)
        let gameScene = GameScene(size: size)
        view?.presentScene(gameScene, transition: transition)
    }
}
