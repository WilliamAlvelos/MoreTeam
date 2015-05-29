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
    var nLojas:Int = 0;
    var tipoMarketing:Int = 0;
    var dinheiro:NSInteger = 1000;
    var nFuncionarios:Int = 0;
    var nLenhadores:Int = 0;
    var placeHolder:Bool = false;
    var produtos:NSInteger = 0
    var volExtracao:Int = 0
    var precoFuncionario:Double = 100
    var precoLenhador:Double = 100
    var precoLoja:Double = 100
    var reciclaveis:Int = 0
    var economia:Int = 0
    var social:Int = 0
    var ambiental:Int = 0
    var reciclagemVal:Int = 0
    var treinamentoVal:Int = 0
    var placeHolderVal:Int = 0
    var totalMatPrima:Int = 691200000
    var doacao:Int = 0
    
    
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
        
        startGame()
    }
    
    
    func demitirLenhador(sender: UIButton) {
        nLenhadores--
        labNLenhadores.text = String(stringInterpolationSegment: Int(nLenhadores));
        dinheiro += Int(precoLenhador / 2)
        labDinheiro.text = String(stringInterpolationSegment: Int(dinheiro))
        precoLenhador -= precoLenhador * 0.13
        labPrecoLenhador.text = String(stringInterpolationSegment: Int(precoLenhador))
    }
    
    func numeroLenhadores(sender: UIButton) {
        if(dinheiro >= Int(precoLenhador)){
            nLenhadores++
            labNLenhadores.text = String(stringInterpolationSegment: Int(nLenhadores))
            dinheiro -= Int(precoLenhador)
            labDinheiro.text = String(stringInterpolationSegment: Int(dinheiro))
            precoLenhador += precoLenhador * 0.15
            labPrecoLenhador.text = String(stringInterpolationSegment: Int(precoLenhador))
        }
    }
    
    func demitirFuncionario(sender: UIButton) {
        nFuncionarios--
        labNFuncionarios.text = String(stringInterpolationSegment: Int(nFuncionarios));
        dinheiro += Int(precoFuncionario / 2)
        labDinheiro.text = String(stringInterpolationSegment: Int(dinheiro))
        precoFuncionario -= precoFuncionario * 0.13
        labPrecoFuncionario.text = String(stringInterpolationSegment: Int(precoFuncionario))
    }
    
    func numeroFuncionarios(sender: UIButton) {
        if(dinheiro >= Int(precoFuncionario)){
            nFuncionarios++
            labNFuncionarios.text = String(stringInterpolationSegment: Int(nFuncionarios))
            dinheiro -= Int(precoFuncionario)
            labDinheiro.text = String(stringInterpolationSegment: Int(dinheiro))
            precoFuncionario += precoFuncionario * 0.15
            labPrecoFuncionario.text = String(stringInterpolationSegment: Int(precoFuncionario))
        }
    }
    
    func venderLoja(sender: UIButton) {
        nLojas--;
        labNLojas.text = String(stringInterpolationSegment: Int(nLojas));
        dinheiro += Int(precoLoja / 2)
        labDinheiro.text = String(stringInterpolationSegment: Int(dinheiro))
        precoLoja -= precoLoja * 0.13
        labPrecoLoja.text = String(stringInterpolationSegment: Int(precoLoja))
    }
    
    func materiaPrima(sender: UIButton) {
        tipoMPrima++
        if(tipoMPrima == 3){
            tipoMPrima = 0
        }
        labTMateria.text = String(stringInterpolationSegment: Int(tipoMPrima));
        calcPorcentagem()
    }
    
    func reciclagem(sender: UIButton) {
        if(reciclagem == false){
            reciclagem = true
            reciclagemVal = 1
            labReciclagem.text = "1";
        } else {
            reciclagem = false
            reciclagemVal = 0
            labReciclagem.text = "0";
        }
        calcPorcentagem()
    }
    
    func maoDeObra(sender: UIButton) {
        tipoMObra++
        if(tipoMObra == 3){
            tipoMObra = 0
        }
        labMaoDeObra.text = String(stringInterpolationSegment: Int(tipoMObra));
        calcPorcentagem()
    }
    
    func CentroTreinamento(sender: UIButton) {
        if(treinamento == false){
            treinamento = true
            treinamentoVal = 1
            labTreinamento.text = "1";
        } else {
            treinamento = false
            treinamentoVal = 0
            labTreinamento.text = "0";
        }
        calcPorcentagem()
    }
    
    func numeroDeLojas(sender: UIButton) {
        if(dinheiro >= Int(precoLoja)){
            nLojas++
            labNLojas.text = String(stringInterpolationSegment: Int(nLojas))
            dinheiro -= Int(precoLoja)
            labDinheiro.text = String(stringInterpolationSegment: Int(dinheiro))
            precoLoja += precoLoja * 0.15
            labPrecoLoja.text = String(stringInterpolationSegment: Int(precoLoja))
        }
    }
    
    func Marketing(sender: UIButton) {
        tipoMarketing++
        if(tipoMarketing == 3){
            tipoMarketing = 0
        }
        labMarketing.text = String(stringInterpolationSegment: Int(tipoMarketing));
        calcPorcentagem()
    }
    
    func funcPlaceHolder(sender: UIButton) {
        if(placeHolder == false){
            placeHolder = true
            placeHolderVal = 1;
            labPlaceHolder.text = "1";
        } else {
            placeHolder = false
            placeHolderVal = 0
            labPlaceHolder.text = "0";
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
        
        labTempo.text = String(stringInterpolationSegment: Int(elapsedTime));
        
        if(nLojas >= 1){
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
        
        calcMateriaPrima()
        calcPorcentagem()
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
        
        labVolExtracao.text = String(stringInterpolationSegment: Int(volExtracao))
        labMPrima.text = String(stringInterpolationSegment: Int(matPrima))
        
        totalMatPrima -= volExtracao
        println(totalMatPrima)
    }
    
    func calcProdutos(){
        var tipo:Int = 1;
        var custoMPrima:Int = 500;
        
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
        }
        labVolumeProd.text = String(stringInterpolationSegment: Int(volProd))
        labProdutos.text = String(stringInterpolationSegment: Int(produtos))
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
            if(produtos / vendas >= nLojas){
                volVendas = nLojas * tipo
                dinheiro += volVendas * 100
            } else {
                volVendas = produtos / vendas * tipo
                dinheiro += volVendas * 100
            }
            produtos -= volVendas / tipo * 4
        }
        labVolVendas.text = String(stringInterpolationSegment: Int(volVendas))
        labDinheiro.text = String(stringInterpolationSegment: Int(dinheiro))
        reciclaveis += 4 * nLojas - volVendas
    }
    
    func calcPorcentagem(){
        var marketingVal:Int = 0
        var temp:Int = 0
        var temp2:Int = 0
        var porcEconomia:Float = 0
        var porcSocial:Float = 0
        var porcAmbiental:Float = 0
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
        
        labPorcEconomia.text = String(format: "%.1f", porcEconomia)
        labPorcSocial.text = String(format: "%.1f", porcSocial)
        labPorcAmbiental.text = String(format: "%.1f", porcAmbiental)
    }
    
}
