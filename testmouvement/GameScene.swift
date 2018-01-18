//
//  GameScene.swift
//  testmouvement
//
//  Created by Richard Urunuela on 18/01/2018.
//  Copyright © 2018 Richard Urunuela. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    func printInfo(){
        debugPrint(" fond \(fond?.position.x) \(fond?.position.y)")
        debugPrint(" player \(mplayer?.position.x) \(mplayer?.position.y) ")
    }
    private var fond : SKSpriteNode?
    private var mplayer : SKSpriteNode?
    var predlocation : CGPoint?
    var predlocation2 : CGPoint?
    
    
    //Swipe
     let swipeR = UISwipeGestureRecognizer()
    let swipeL = UISwipeGestureRecognizer()
    //rotate
    @objc let rotate = UIRotationGestureRecognizer()
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        //self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        self.fond = self.childNode(withName: "fond") as! SKSpriteNode
        self.mplayer = fond?.childNode(withName: "player") as! SKSpriteNode
        
        //contraintes position
        let rangefondx = SKRange(lowerLimit: -320, upperLimit: 320)
          let rangefondy = SKRange(lowerLimit: -420, upperLimit: 420)
        let lockTox = SKConstraint.positionX(rangefondx, y: rangefondy )
        fond?.constraints = [lockTox]
        
        printInfo()
        
        
        swipeR.addTarget(self, action: #selector(GameScene.swipedR))
        swipeR.direction = .right
        self.view?.addGestureRecognizer(swipeR)
        rotate.addTarget(self, action: #selector(GameScene.rotated))
        self.view?.addGestureRecognizer(rotate)
        
        
    }
    //MARK: ==================== swipe And rotate
    @objc func rotated(sender :UIRotationGestureRecognizer ){
        debugPrint("--> rotate \(sender.rotation)")
        predlocation =  nil
        predlocation2 =  nil
        switch sender.state {
        case .began:
            break
        case .changed:
            let rotateAmount = (Measurement(value: Double(sender.rotation), unit: UnitAngle.degrees))
            mplayer?.zRotation = -sender.rotation
            
            break
        case .ended:
            break
        default:
            break
            
        }
    }
    @objc func swipedR(sender :UISwipeGestureRecognizer ){
        let translation = sender.location(in: self.view)
        print(" vers la  droite \(sender.state) \(translation)" )
        predlocation =  nil
        predlocation2 =  nil
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.count > 1 ) {return}
        
        
        
        for touch in touches {
            
            let location = touch.location(in: self)
            let location2 = touch.location(in: fond!)
            if predlocation == nil {
                predlocation =  location
            }
            if predlocation2 == nil {
                predlocation2 =  location2
            }
            if (mplayer?.contains (location2))! {
                mplayer?.position.x = (mplayer?.position.x)! + location2.x - (predlocation2?.x)!
                mplayer?.position.y = (mplayer?.position.y)! + location2.y - (predlocation2?.y)!
                //mplayer?.position.x = location2.x
               // mplayer?.position.y = location2.y
            }
            else if (fond?.contains(location))! {
               //Place le node sous le doigt
                //fond?.position.x = location.x
               // fond?.position.y = location.y
                fond?.position.x = (fond?.position.x)! + location.x - (predlocation?.x)!
                fond?.position.y = (fond?.position.y)! + location.y - (predlocation?.y)!
                
            }
            //printInfo()
            predlocation = location
            predlocation2 = location2
        }
       
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      
       predlocation =  nil
       predlocation2 =  nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
