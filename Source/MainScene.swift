import Foundation

class MainScene: CCNode {
    weak var hero : CCSprite!
    weak var gamePhysicsNode : CCPhysicsNode!
    weak var ground1 : CCSprite!
    weak var ground2 : CCSprite!
    
    var sinceTouch : CCTime = 0
    var scrollSpeed : CGFloat = 80
    var grounds = [CCSprite]()  // initializes an empty array
    
    func didLoadFromCCB() {
        userInteractionEnabled = true
        grounds.append(ground1)
        grounds.append(ground2)
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        hero.physicsBody.applyImpulse(ccp(0, 400))
        hero.physicsBody.applyAngularImpulse(10000)
        sinceTouch = 0
    }
    
    override func update(delta: CCTime) {
        let velocityY = clampf(Float(hero.physicsBody.velocity.y), -Float(CGFloat.max), 200)
        hero.physicsBody.velocity = ccp(0, CGFloat(velocityY))
        
        sinceTouch += delta
        hero.rotation = clampf(hero.rotation, -30, 90)
        if (hero.physicsBody.allowsRotation) {
            let angularVelocity = clampf(Float(hero.physicsBody.angularVelocity), -2, 1)
            hero.physicsBody.angularVelocity = CGFloat(angularVelocity)
        }
        if (sinceTouch > 0.3) {
            let impulse = -18000.0 * delta
            hero.physicsBody.applyAngularImpulse(CGFloat(impulse))
        }
        
        hero.position = ccp(hero.position.x + scrollSpeed * CGFloat(delta), hero.position.y)
        
        gamePhysicsNode.position = ccp(gamePhysicsNode.position.x - scrollSpeed * CGFloat(delta), gamePhysicsNode.position.y)
        
        // loop the ground whenever a ground image was moved entirely outside the screen
        for ground in grounds {
            let groundWorldPosition = gamePhysicsNode.convertToWorldSpace(ground.position)
            let groundScreenPosition = convertToNodeSpace(groundWorldPosition)
            if groundScreenPosition.x <= (-ground.contentSize.width) {
                ground.position = ccp(ground.position.x + ground.contentSize.width * 2, ground.position.y)
            }
        }
    }
}
