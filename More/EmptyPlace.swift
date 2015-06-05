//
//  EmptyPlace.swift
//  test
//
//  Created by Felipe Costa Nascimento on 5/24/15.
//  Copyright (c) 2015 Felipe Costa Nascimento. All rights reserved.
//

import SpriteKit

class EmptyPlace: SKSpriteNode {
    
    var nodeTree:SKSpriteNode!
    var nodeBackgroundImage:SKSpriteNode!
    var indexPosicao:Int!
    
    init(indexPosicao:Int){
        super.init(texture: nil, color: nil, size: CGSizeMake(59, 28))
        
        self.indexPosicao = indexPosicao
        
        self.zPosition = 4
        
        nodeBackgroundImage = SKSpriteNode(imageNamed: "m1")
        nodeBackgroundImage.zPosition = -2
        nodeBackgroundImage.alpha = 0
        self.addChild(nodeBackgroundImage)
        
        nodeTree = SKSpriteNode(imageNamed: "swing_tree-03")
        nodeTree.userInteractionEnabled = true
        nodeTree.zPosition = -1
        nodeTree.anchorPoint = CGPointMake(0.5, 0.1)
        super.addChild(nodeTree)
        
        
        
        var array:Array = Array<SKTexture>()
        
        for i in 1 ... 5{
            array.append(SKTexture(imageNamed: "swing_tree-0\(i)"))
        }
        
        var timeFrame:NSTimeInterval = NSTimeInterval(Float(arc4random()) % Float(0.1) + 0.09)
        
        var actionSwing = SKAction.animateWithTextures(array, timePerFrame: timeFrame)
        nodeTree.runAction(SKAction.repeatActionForever(actionSwing))
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    
    func showEmptyPlace(){
        if(children.count == 0 || nodeTree != nil){
            //self.color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
            nodeBackgroundImage.alpha = 1
            self.name = "empty place"
            
        }
    }
    
    func hiddeEmptyPlace(){
        self.name = nil
        self.texture = nil
        nodeBackgroundImage.alpha = 0
        //self.color = UIColor.clearColor()
    }
    
    
    override func addChild(node: SKNode) {
        super.addChild(node)
        
        if(node.isEqual(nil)){
            return
        }
        
        if (nodeTree != nil){
            nodeTree.removeFromParent()
            nodeTree = nil
        }
        
        if(node .isKindOfClass(FabricaNode)){
            var fabrica = node as! FabricaNode
            fabrica.dadosFabrica.setValue(indexPosicao, forKey: "indexPosicao")
        }else if(node .isKindOfClass(LojaNode)){
            var loja = node as! LojaNode
            loja.dadosLoja.setValue(indexPosicao, forKey: "indexPosicao")
        }
    }

}
