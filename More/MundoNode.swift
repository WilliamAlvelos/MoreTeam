//
//  Mundo.swift
//  More
//
//  Created by Felipe Costa Nascimento on 5/29/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit


//protocol MundoDelegate{
//    func animacaoDeIntroducaoTerminou()
//}


class MundoNode: SKSpriteNode {
    
    var dadosMundo:Mundo!
    //var delegate:MundoDelegate?
    var vtEmptyPlace:Array<IlhaNode> = Array()
    
    
    init(size:CGSize){
        super.init(texture: SKTexture(imageNamed: "w1"), color: nil, size: size)

        dadosMundo = Mundo()
        self.zPosition = 1
        inicializarIlhas()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    private func inicializarIlhas(){
        var ilha1 = IlhaNode(size: CGSizeMake(296, 105), tipoIlha: IlhaNode.TIPO_ILHA1)
        ilha1.position = CGPointMake(-122, 192)
        vtEmptyPlace.append(ilha1)
        self.addChild(ilha1)
        
        var ilha2 = IlhaNode(size: CGSizeMake(228, 72), tipoIlha: IlhaNode.TIPO_ILHA2)
        ilha2.position = CGPointMake(60, 182)
        vtEmptyPlace.append(ilha2)
        self.addChild(ilha2)
        
        var ilha3 = IlhaNode(size: CGSizeMake(205, 98), tipoIlha: IlhaNode.TIPO_ILHA3)
        ilha3.position = CGPointMake(-49, 52)
        vtEmptyPlace.append(ilha3)
        self.addChild(ilha3)
        
        var ilha4 = IlhaNode(size: CGSizeMake(124, 54), tipoIlha: IlhaNode.TIPO_ILHA4)
        ilha4.position = CGPointMake(136, 85)
        vtEmptyPlace.append(ilha4)
        self.addChild(ilha4)
        
        var ilha5 = IlhaNode(size: CGSizeMake(388, 162), tipoIlha: IlhaNode.TIPO_ILHA5)
        ilha5.position = CGPointMake(-120, -25)
        vtEmptyPlace.append(ilha5)
        self.addChild(ilha5)
        
        var ilha6 = IlhaNode(size: CGSizeMake(161, 203), tipoIlha: IlhaNode.TIPO_ILHA6)
        ilha6.position = CGPointMake(234, 18)
        vtEmptyPlace.append(ilha6)
        self.addChild(ilha6)
    }
    
    
    func showEmptyPlaces(){
        for ilha in vtEmptyPlace{
            ilha.showEmptyPlace()
        }
    }
    
    
    func hiddeEmptyPlaces(){
        for ilha in vtEmptyPlace{
            ilha.hiddeEmptyPlace()
        }
    }
    
    
    func atualizarSprites(porcentagemAmbiental:Float){
        
        println(porcentagemAmbiental)
        
        if(porcentagemAmbiental > 66){
            self.texture = SKTexture(imageNamed: "w1")
        
        }else if(porcentagemAmbiental > 33){
            self.texture = SKTexture(imageNamed: "w2")
        
        }else{
            self.texture = SKTexture(imageNamed: "w3")
        }
        
        for ilha in vtEmptyPlace{
            ilha.atualizarSprites()
        }
    }
}
