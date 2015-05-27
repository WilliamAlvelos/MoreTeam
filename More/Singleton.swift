//
//  Singleton.swift
//  test
//
//  Created by Felipe Costa Nascimento on 5/24/15.
//  Copyright (c) 2015 Felipe Costa Nascimento. All rights reserved.
//

import UIKit

protocol SingletonDelegate{
    func setValor(novoValor:Float)
    func setProducao(novaproducao:Float)
}

class Singleton:NSObject{
    
    var producao:Float = 0
    var valor:Float = 0
    var timer:NSTimer!
    var delegate:SingletonDelegate?
    
    class var sharedInstance: Singleton {
        struct Static {
            static var instance: Singleton?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = Singleton()
        }
        
        return Static.instance!
    }
    
    
    override init(){
        super.init()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("incrementaNumber"), userInfo: nil, repeats: true)

        
    }
    
    
    func incrementaNumber(){
        valor += 0.2
        producao += 0.5
        
        delegate?.setValor(valor)
        delegate?.setProducao(producao)
    }
    
    
    func stopTimer(){
        timer.invalidate()
        timer = nil
    }
}
