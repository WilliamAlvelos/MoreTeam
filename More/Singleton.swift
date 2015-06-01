//
//  Singleton.swift
//  test
//
//  Created by Felipe Costa Nascimento on 5/24/15.
//  Copyright (c) 2015 Felipe Costa Nascimento. All rights reserved.
//

import UIKit

@objc protocol SingletonDelegate{
    
    optional func setDinheiro(novoDinheiro:NSInteger)
    optional func setMatPrima(novaMatPrima:NSInteger)
    optional func setVolProducao(novoVolProducao:Int)
    optional func setProdutos(novoProduto:NSInteger)
    optional func setPorcEconomia(novaEconomia:Float)
    optional func setPorcSocial(novoSocial:Float)
    optional func setPorcAmbiental(novoAmbiental:Float)
    optional func setSegundo(novoSegundo:Int)
    optional func setMinuto(novoMinutos:Int)
    optional func setHora(novaHora:Int)
}

class Singleton:NSObject{
    
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    var gameTime:Double = 0
    var matPrima:NSInteger = 0
    var tipoMPrima:Int = 0
    var reciclagem:Bool = false
    var volProd:Int = 0;
    var tipoMObra:Int = 0;
    var treinamento:Bool = false;
    var volVendas:Int = 0;
    var nVendedores:Int = 0;
    var tipoMarketing:Int = 0;
    var dinheiro:NSInteger = 1000;
    var nFuncionarios:Int = 0;
    var nLenhadores:Int = 0;
    var placeHolder:Bool = false;
    var produtos:NSInteger = 0
    var volExtracao:Int = 0
    var precoFuncionario:Double = 100
    var precoLenhador:Double = 100
    var precoVendedor:Double = 100
    var reciclaveis:Int = 0
    var economia:Int = 0
    var social:Int = 0
    var ambiental:Int = 0
    var reciclagemVal:Int = 0
    var treinamentoVal:Int = 0
    var placeHolderVal:Int = 0
    var totalMatPrima:Int = 3000000
    var doacao:Int = 0
    var porcEconomia:Float = 0
    var porcSocial:Float = 0
    var porcAmbiental:Float = 0
    var segundos:Int = 0
    var minutos:Int = 0
    var horas:Int = 0
    
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
        
        matPrima = totalMatPrima
        startGame()

    }
    
    func demitirLenhador() {
        if(nLenhadores > 0){
            nLenhadores--
            dinheiro += Int(precoLenhador / 2)
            precoLenhador -= precoLenhador * 0.13
        }
    }
    
    func addLenhador() {
        if(dinheiro >= Int(precoLenhador)){
            nLenhadores++
            dinheiro -= Int(precoLenhador)
            precoLenhador += precoLenhador * 0.15
        }
    }
    
    func demitirFuncionario() {
        if(nFuncionarios > 0){
            nFuncionarios--
            dinheiro += Int(precoFuncionario / 2)
            precoFuncionario -= precoFuncionario * 0.13
            delegate?.setDinheiro!(dinheiro)
        }
    }
    
    func addFuncionarios() {
        if(dinheiro >= Int(precoFuncionario)){
            nFuncionarios++
            dinheiro -= Int(precoFuncionario)
            precoFuncionario += precoFuncionario * 0.15
            delegate?.setDinheiro?(dinheiro)
        }
    }
    
    func demitirVendedor() {
        if(nVendedores > 0){
            nVendedores--;
            dinheiro += Int(precoVendedor / 2)
            precoVendedor -= precoVendedor * 0.13
            delegate?.setDinheiro!(dinheiro)
        }
    }
    
    func tipoMateriaPrima() {
        tipoMPrima++
        if(tipoMPrima == 3){
            tipoMPrima = 0
        }
        calcPorcentagem()
    }
    
    func reciclar() {
        if(reciclagem == false){
            reciclagem = true
            reciclagemVal = 1
        } else {
            reciclagem = false
            reciclagemVal = 0
        }
        calcPorcentagem()
    }
    
    func addMaoDeObra() {
        tipoMObra++
        if(tipoMObra == 3){
            tipoMObra = 0
        }
        calcPorcentagem()
    }
    
    func centroTreinamento() {
        if(treinamento == false){
            treinamento = true
            treinamentoVal = 1
        } else {
            treinamento = false
            treinamentoVal = 0
        }
        calcPorcentagem()
    }
    
    func addNumeroLojas(){
        if(dinheiro >= Int(precoVendedor)){
            nVendedores++
            dinheiro -= Int(precoVendedor)
            precoVendedor += precoVendedor * 0.15
        }
    }
    
    func marketing() {
        tipoMarketing++
        if(tipoMarketing == 3){
            tipoMarketing = 0
        }
        calcPorcentagem()
    }
    
    func funcPlaceHolder() {
        if(placeHolder == false){
            placeHolder = true
            placeHolderVal = 1;
        } else {
            placeHolder = false
            placeHolderVal = 0
        }
        calcPorcentagem()
    }
    
    
    func startGame() {
        
        let aSelector : Selector = "updateTime"
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
        
        calcPorcentagem()
        
    }
    
    func updateTime() {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime = currentTime - startTime
        var seconds = gameTime
        
        if seconds >= 0 {
            elapsedTime += NSTimeInterval(seconds)
        } else {
            timer.invalidate()
        }
        
        if(nVendedores >= 1){
            calcDinheiro()
        }
        
        if(nFuncionarios >= 1){
            calcProdutos()
        }
        if(Int(elapsedTime % 10) == 0){
            doacao = 1
        } else {
            doacao = 0
        }
        segundos = Int(elapsedTime)
        
        calcMateriaPrima()
        calcPorcentagem()
        calcTempo()
    }
    
    func calcMateriaPrima(){
        var tipo:Int = 1;
        var reciclados: Double = 0;
        var recicladosInt: Int = 0;
        
        if(tipoMPrima == 0){
            tipo = 1
        } else if(tipoMPrima == 1){
            tipo = 2
        } else if(tipoMPrima == 2){
            tipo = 5
        }
        
        if(reciclagem == true){
            reciclados = Double(reciclaveis) * 0.25 * 500
            recicladosInt = Int(reciclados)
            matPrima += recicladosInt
            reciclaveis = 0;
        }
        
        matPrima += nLenhadores * 200 * tipo;
        volExtracao = nLenhadores * 200 * tipo + recicladosInt
        
        totalMatPrima -= volExtracao
        println(matPrima)
    }
    
    func calcProdutos(){
        var tipo:Int = 1;
        var custoMPrima:Int = 500;
        delegate?.setMatPrima?(matPrima)
        
        if(tipoMObra == 0){
            tipo = 1
        } else if(tipoMObra == 1){
            tipo = 2
        } else if(tipoMObra == 2){
            tipo = 5
        }
        
        if(treinamento == true){
            custoMPrima /= 2
        }
        
        if(matPrima >= custoMPrima){
            if(matPrima / custoMPrima >= nFuncionarios){
                volProd = nFuncionarios * 5 * tipo;
                produtos += volProd
            } else {
                volProd = matPrima / custoMPrima * 5 * tipo
                produtos += volProd
            }
            matPrima -= volProd / tipo * 100
            delegate?.setVolProducao!(volProd)
        }
    }
    
    func calcDinheiro(){
        var tipo:Int = 1;
        var vendas:Int = 4;
        var temp:Double = 0;
        
        if(tipoMarketing == 0){
            tipo = 1
        } else if(tipoMarketing == 1){
            tipo = 2
        } else if(tipoMarketing == 2){
            tipo = 3
        }
        
        if(placeHolder == true){
            if(doacao == 1){
                temp = Double(dinheiro) * 0.10
                dinheiro -= Int(temp)
            }
        }
        
        if(produtos >= vendas){
            if(produtos / vendas >= nVendedores){
                volVendas = nVendedores * tipo
                dinheiro += volVendas * 100
            } else {
                volVendas = produtos / vendas * tipo
                dinheiro += volVendas * 100
            }
            produtos -= volVendas / tipo * 4
        }
        reciclaveis += 4 * nVendedores - volVendas
        
        delegate?.setDinheiro?(dinheiro)
    }
    
    func calcPorcentagem(){
        var marketingVal:Int = 0
        var temp:Int = 0
        var temp2:Int = 0
        var total:Float = 0
        
        if(tipoMarketing == 0){
            marketingVal = 10
        } else {
            marketingVal = tipoMarketing * 10
        }
        if(tipoMarketing == 0){
            temp = 10;
        } else if(tipoMarketing == 1) {
            temp2 = 10;
        }
        
        economia = tipoMPrima * 15 + tipoMObra * 15 + treinamentoVal * 10 + reciclagemVal * 10 + marketingVal
        social = (2 - tipoMObra) * 15 + treinamentoVal * 10 + placeHolderVal * 10 + temp
        ambiental = (2 - tipoMPrima) * 15 + placeHolderVal * 10 + reciclagemVal * 10 + temp2
        
        total = Float(economia + social + ambiental)
        
        porcEconomia = Float(economia) / total * 100;
        porcAmbiental = Float(ambiental) / total * 100;
        porcSocial = Float(social) / total * 100;
    }
    
    func calcTempo(){
        if(segundos >= 60){
            minutos++
            segundos -= 60
        }
        if(minutos >= 60){
            horas++
            minutos -= 60
        }
    }
}
