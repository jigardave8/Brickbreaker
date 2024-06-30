//
//  MainMenu.swift
//  Brickbreaker
//
//  Created by Jigar on 05/06/24.
//

// MainMenu.swift

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
        
        // Additional Menu Options
        let optionsLabel = SKLabelNode(text: "Options")
        optionsLabel.fontName = "PressStart2P"
        optionsLabel.fontSize = 20
        optionsLabel.fontColor = .white
        optionsLabel.position = CGPoint(x: size.width / 2, y: size.height / 2 - 100)
        optionsLabel.name = "options"
        addChild(optionsLabel)
        
        let highScoresLabel = SKLabelNode(text: "High Scores")
        highScoresLabel.fontName = "PressStart2P"
        highScoresLabel.fontSize = 20
        highScoresLabel.fontColor = .white
        highScoresLabel.position = CGPoint(x: size.width / 2, y: size.height / 2 - 150)
        highScoresLabel.name = "highScores"
        addChild(highScoresLabel)
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesArray = nodes(at: location)
        
        if nodesArray.first?.name == "options" {
            // Handle Options
        } else if nodesArray.first?.name == "highScores" {
            // Handle High Scores
        } else {
            let transition = SKTransition.flipHorizontal(withDuration: 1.0)
            let gameScene = GameScene(size: size)
            view?.presentScene(gameScene, transition: transition)
        }
    }
}
