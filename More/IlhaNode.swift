//
//  IlhaNode.swift
//  More
//
//  Created by Felipe Costa Nascimento on 6/3/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

class IlhaNode: SKSpriteNode, EmptyPlaceDelegate{
    
    static let TIPO_ILHA1 = 1
    static let TIPO_ILHA2 = 2
    static let TIPO_ILHA3 = 3
    static let TIPO_ILHA4 = 4
    static let TIPO_ILHA5 = 5
    static let TIPO_ILHA6 = 6
    
    var tipoEscolhido:Int!
    
    var vtEmptyPlace:Array<EmptyPlace> = Array()
    
    init(size:CGSize, tipoIlha:Int){
        super.init(texture: SKTexture(imageNamed: "v\(tipoIlha)"), color: nil, size: size)
        
        tipoEscolhido = tipoIlha
        inicializarEmptyPlace()
        self.zPosition = 1
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func inicializarEmptyPlace(){
        
        //COM BASE NO TIPO DE ILHA ESCOLHIDO, É ADICIONADO AS POSIÇÕES LIVRES NESTA ILHA
        switch(tipoEscolhido){
            //CHAMA UM MÉTODO QUE ADICIONA UMA POSIÇÃO LIVRE PASSANDO A POSIÇÃO E O INDEX DESSE EMPTY PLACE
            case IlhaNode.TIPO_ILHA1:
                adicionarEmptyPlace(CGPointMake(50, 30), index: 1)
                adicionarEmptyPlace(CGPointMake(-20, 13), index: 2)
                adicionarEmptyPlace(CGPointMake(-80, -15), index: 3)
                break
            
            case IlhaNode.TIPO_ILHA2:
                adicionarEmptyPlace(CGPointMake(8, 15), index: 4)
                adicionarEmptyPlace(CGPointMake(-50, -5), index: 5)
                adicionarEmptyPlace(CGPointMake(70, 0), index: 6)
                break
            
            case IlhaNode.TIPO_ILHA3:
                //adicionarEmptyPlace(CGPointMake(10, 30))
                adicionarEmptyPlace(CGPointMake(-55, 20), index: 7)
                adicionarEmptyPlace(CGPointMake(0, -25), index: 8)
                adicionarEmptyPlace(CGPointMake(60, 10), index: 9)
                //adicionarEmptyPlace(CGPointMake(60, 8))
                break
            
            case IlhaNode.TIPO_ILHA4:
                adicionarEmptyPlace(CGPointMake(3, 2), index: 10)
                break
            
            case IlhaNode.TIPO_ILHA5:
                adicionarEmptyPlace(CGPointMake(-90, -10), index: 11)
                adicionarEmptyPlace(CGPointMake(-37, -35), index: 12)
                adicionarEmptyPlace(CGPointMake(33, -51), index: 13)
                adicionarEmptyPlace(CGPointMake(110, -55), index: 14)
                break
            
            case IlhaNode.TIPO_ILHA6:
                adicionarEmptyPlace(CGPointMake(42, 45), index: 15)
                adicionarEmptyPlace(CGPointMake(-2, -35), index: 16)
            
            default:
            break
        }
    }
    
    
    private func adicionarEmptyPlace(posicao:CGPoint, index:Int){
        var emptyPlace = EmptyPlace(indexPosicao: index)
        emptyPlace.delegate = self
        emptyPlace.position = posicao
        vtEmptyPlace.append(emptyPlace)
        self.addChild(emptyPlace)
    }
    
    
    func showEmptyPlace(){
        for place in vtEmptyPlace{
            place.showEmptyPlace()
        }
    }
    
    
    func hiddeEmptyPlace(){
        for place in vtEmptyPlace{
            place.hiddeEmptyPlace()
        }
    }
    
    
    func atualizarSprites(){
        for place in vtEmptyPlace{
            place.atualizarSprite()
        }
    }
    
    
    func constructionAddedOnEmptyPlace() {
        self.texture = SKTexture(imageNamed: "c\(tipoEscolhido)")
    }
    
}
