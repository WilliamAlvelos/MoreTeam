//
//  GameController.swift
//  More
//
//  Created by Felipe Costa Nascimento on 5/27/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit
import AVFoundation
import CoreData

class GameController:AbstractSceneDelegate{
    
    var gameView:SKView!
    var mundo:MundoScene!
    var soundGame:AVAudioPlayer!
    
    init(view:SKView){
        gameView = view
        mundo = MundoScene(size: gameView.frame.size)
        mundo.myDelegate = self
        soundGame = inicializarSong("ambiente", type: "mp3", infinito: true)
    }
    
    
    func backToWorld(){
        
        gameView.presentScene(mundo)
        mundo.atualizarCena()
    }
    
    
    func goToFabrica(fabrica:NSManagedObject){
        let fabricaScene = FabricaScene(fabrica: fabrica, size: gameView.frame.size)
        fabricaScene.myDelegate = self
        gameView.presentScene(fabricaScene)
    }
    
    
    func goToLoja(loja:NSManagedObject){
        let lojaScene = LojaScene(loja: loja,size: gameView.frame.size)
        lojaScene.myDelegate = self
        gameView.presentScene(lojaScene)
    }
    
    
    func changeSomAmbiente(play:Bool){
        if(play){
            if(!soundGame.playing){
                soundGame.play()
            }
        
        }else{
            soundGame.stop()
        }
    }
    
    
    func startGame(){
        var transition = SKTransition.doorsOpenHorizontalWithDuration(1)
        
        gameView.presentScene(mundo, transition: transition)
        soundGame.play()
    }
    
    
    private func inicializarSong(path:String, type:String, infinito:Bool) -> AVAudioPlayer{
        var soundFilePath = NSBundle.mainBundle().pathForResource(path, ofType: type)
        
        var soundFileURL = NSURL.fileURLWithPath(soundFilePath!)
        
        var song = AVAudioPlayer(contentsOfURL: soundFileURL, error: nil)
        
        if(infinito){
            song.numberOfLoops = -1
        }
        song.prepareToPlay()
        
        return song;
    }
    
}
