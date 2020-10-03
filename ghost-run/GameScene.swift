//
//  GameScene.swift
//  ghost-run
//
//  Created by Kunz, Gabriel on 03/10/20.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // Nodes
    var gameNode: SKNode!
    var playerNode: SKNode!
    var groundNode: SKNode!
    var backgroundNode: SKNode!
    var obstacleNode: SKNode!
    
    // Background
    var backgroundImage = SKSpriteNode(imageNamed: "game.assets/background")
    
    // Sprites
    var playerSprite: SKSpriteNode!
    
    // Score
    var scoreNode: SKLabelNode!
    var score = 0 as Int
    
    // Consts
    let background = 0 as CGFloat
    let foreground = 1 as CGFloat
    
    // Ground variables
    var groundHeight: CGFloat?
    var groundSpeed = 500 as CGFloat
    
    // Player variables
    var playerYPosition: CGFloat?
    var playerYPositionMultiplier = 0.4 as CGFloat
    
    
    override func didMove(to view: SKView) {
        // Background
        backgroundImage.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        backgroundImage.zPosition = background
        addChild(backgroundImage)
        
        // Ground
        groundNode = SKNode()
        groundNode.zPosition = background
        createGround()
        
        // Player
        playerNode = SKNode()
        playerNode.zPosition = foreground
        createPlayer()
        
        gameNode = SKNode()
        gameNode.addChild(playerNode)
        gameNode.addChild(groundNode)
        self.addChild(gameNode)
    }
    
    func createPlayer(){
        let screenWidth = self.frame.size.width
        let screeHeight = self.frame.size.height
        let playerScale = 0.3 as CGFloat
        
        // Player texture
        let playerTexture = SKTexture(imageNamed: "game.assets/player")
        playerTexture.filteringMode = .nearest
        
        // Animation
        let runningAnimation = SKAction.animate(with: [playerTexture], timePerFrame: 0.12)
        
        
        // Size and scale
        playerSprite = SKSpriteNode()
        playerSprite.size = playerTexture.size()
        playerSprite.setScale(playerScale)
        playerNode.addChild(playerSprite)
        
        // Positioning
        playerSprite.position = CGPoint(x: screenWidth * 0.15, y: screeHeight * 0.4)
        playerSprite.run(SKAction.repeatForever(runningAnimation))
    }
    
    func createGround(){
        let screenWidth = self.frame.size.width
        
        // Ground texture
        let groundTexture = SKTexture(imageNamed: "game.assets/ground")
        groundTexture.filteringMode = .nearest
        
        // Ground size
        let homeButtonPadding = 50.0 as CGFloat
        groundHeight = groundTexture.size().height*1.2 + homeButtonPadding
        
        // Ground movement
        let moveGroundLeft = SKAction.moveBy(x: -groundTexture.size().width, y: 0.0, duration: TimeInterval(screenWidth /    groundSpeed))
        let resetGround = SKAction.moveBy(x: groundTexture.size().width, y: 0.0, duration: 0.0)
        let groundMoveLoop = SKAction.sequence([moveGroundLeft,resetGround])
        
        // Node
        let numberOfGroundNodes = 1 + Int(ceil(screenWidth / groundTexture.size().width))
        
        // Ground position and movement loop
        for i in 0 ..< numberOfGroundNodes{
            let node = SKSpriteNode(texture: groundTexture)
            
            node.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            node.position = CGPoint(x: CGFloat(i) * groundTexture.size().width, y: groundHeight!)
            groundNode.addChild(node)
            node.run(SKAction.repeatForever(groundMoveLoop))
        }
        
    }
    
}
