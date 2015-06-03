//
//  IlhaNode.swift
//  More
//
//  Created by Felipe Costa Nascimento on 6/3/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

class IlhaNode: SKSpriteNode {
    
    static let TIPO_ILHA1 = 1
    static let TIPO_ILHA2 = 2
    static let TIPO_ILHA3 = 3
    static let TIPO_ILHA4 = 4
    static let TIPO_ILHA5 = 5
    static let TIPO_ILHA6 = 6
    
    var tipoEscolhido:Int!
    
    var vtEmptyPlace:NSMutableArray = NSMutableArray()
    
    init(size:CGSize, tipoIlha:Int){
        super.init(texture: SKTexture(imageNamed: "v\(tipoIlha)"), color: nil, size: size)
        
        tipoEscolhido = tipoIlha
        inicializarEmptyPlace()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func inicializarEmptyPlace(){
        switch(tipoEscolhido){
            case IlhaNode.TIPO_ILHA1:
                adicionarEmptyPlace(CGPointMake(50, 30))
                adicionarEmptyPlace(CGPointMake(-20, 13))
                adicionarEmptyPlace(CGPointMake(-80, -15))
                break
            
            case IlhaNode.TIPO_ILHA2:
                adicionarEmptyPlace(CGPointMake(8, 15))
                adicionarEmptyPlace(CGPointMake(-50, -5))
                adicionarEmptyPlace(CGPointMake(70, 0))
                break
            
            case IlhaNode.TIPO_ILHA3:
                adicionarEmptyPlace(CGPointMake(10, 30))
                adicionarEmptyPlace(CGPointMake(-55, 20))
                adicionarEmptyPlace(CGPointMake(-30, -10))
                adicionarEmptyPlace(CGPointMake(30, -23))
                adicionarEmptyPlace(CGPointMake(60, 8))
                break
            
            case IlhaNode.TIPO_ILHA4:
                adicionarEmptyPlace(CGPointMake(3, 2))
                break
            
            case IlhaNode.TIPO_ILHA5:
                adicionarEmptyPlace(CGPointMake(-90, -10))
                adicionarEmptyPlace(CGPointMake(-37, -35))
                adicionarEmptyPlace(CGPointMake(33, -51))
                adicionarEmptyPlace(CGPointMake(110, -55))
                break
            
            case IlhaNode.TIPO_ILHA6:
                adicionarEmptyPlace(CGPointMake(27, 25))
                adicionarEmptyPlace(CGPointMake(5, -15))
            
            default:
            break
        }
    }
    
    
    private func adicionarEmptyPlace(posicao:CGPoint){
        var emptyPlace = EmptyPlace()
        emptyPlace.position = posicao
        vtEmptyPlace.addObject(emptyPlace)
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
    
}
