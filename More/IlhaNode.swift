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
    
    var vtEmptyPlace:NSMutableArray!
    
    init(size:CGSize, tipoIlha:Int){
        super.init(texture: SKTexture(imageNamed: "v\(tipoIlha)"), color: nil, size: size)
        
        tipoEscolhido = tipoIlha
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func inicializarEmptyPlace(){
        
    }
    
}
