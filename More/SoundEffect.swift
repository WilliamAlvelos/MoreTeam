//
//  Sound.swift
//  More
//
//  Created by Felipe Costa Nascimento on 6/12/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import Foundation
import AVFoundation

class SoundEffect : NSObject {
    var somCash:AVAudioPlayer!
    var somDoor:AVAudioPlayer!
    var somPutItem:AVAudioPlayer!
    
    override init(){
        super.init()
        
        somCash = inicializarSong("cash", type: "mp3", infinito: false)
        somDoor = inicializarSong("door", type: "mp3", infinito: false)
        somPutItem = inicializarSong("put_item", type: "mp3", infinito: false)
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
    
    
    func playCash(tocar:Bool){
        if(tocar){
            somCash.play()
        }
    }
    
    func playDoor(tocar:Bool){
        if(tocar){
            somDoor.play()
        }
    }
    
    func playPutItem(tocar:Bool){
        if(tocar){
            somPutItem.play()
        }
    }
    
}