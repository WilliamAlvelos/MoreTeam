//
//  ViewController.swift
//  variaveis
//
//  Created by Bruno de Paula Munhoz on 22/05/15.
//  Copyright (c) 2015 Bruno de Paula Munhoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        labDinheiro.text = String(stringInterpolationSegment: Int(dinheiro))
        
        startGame()
    }
    
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
    
    
    @IBOutlet weak var labNLenhadores: UILabel!
    @IBOutlet weak var labNFuncionarios: UILabel!
    @IBOutlet weak var labReciclagem: UILabel!
    @IBOutlet weak var labTMateria: UILabel!
    @IBOutlet weak var labMaoDeObra: UILabel!
    @IBOutlet weak var labTreinamento: UILabel!
    @IBOutlet weak var labProdutos: UILabel!
    @IBOutlet weak var labVolumeProd: UILabel!
    @IBOutlet weak var labNLojas: UILabel!
    @IBOutlet weak var labMarketing: UILabel!
    @IBOutlet weak var labVolVendas: UILabel!
    @IBOutlet weak var labDinheiro: UILabel!
    @IBOutlet weak var labTempo: UILabel!
    @IBOutlet weak var labPlaceHolder: UILabel!
    @IBOutlet weak var labMPrima: UILabel!
    @IBOutlet weak var labVolExtracao: UILabel!
    @IBOutlet weak var labPrecoLenhador: UILabel!
    @IBOutlet weak var labPrecoFuncionario: UILabel!
    @IBOutlet weak var labPrecoLoja: UILabel!
    
    @IBAction func demitirLenhador(sender: UIButton) {
        nLenhadores--
        labNLenhadores.text = String(stringInterpolationSegment: Int(nLenhadores));
        dinheiro += Int(precoLenhador / 2)
        labDinheiro.text = String(stringInterpolationSegment: Int(dinheiro))
        precoLenhador -= precoLenhador * 0.13
        labPrecoLenhador.text = String(stringInterpolationSegment: Int(precoLenhador))
    }
    
    @IBAction func numeroLenhadores(sender: UIButton) {
        if(dinheiro >= Int(precoLenhador)){
            nLenhadores++
            labNLenhadores.text = String(stringInterpolationSegment: Int(nLenhadores))
            dinheiro -= Int(precoLenhador)
            labDinheiro.text = String(stringInterpolationSegment: Int(dinheiro))
            precoLenhador += precoLenhador * 0.15
            labPrecoLenhador.text = String(stringInterpolationSegment: Int(precoLenhador))
        }
    }
    
    @IBAction func demitirFuncionario(sender: UIButton) {
        nFuncionarios--
        labNFuncionarios.text = String(stringInterpolationSegment: Int(nFuncionarios));
        dinheiro += Int(precoFuncionario / 2)
        labDinheiro.text = String(stringInterpolationSegment: Int(dinheiro))
        precoFuncionario -= precoFuncionario * 0.13
        labPrecoFuncionario.text = String(stringInterpolationSegment: Int(precoFuncionario))
    }
    
    @IBAction func numeroFuncionarios(sender: UIButton) {
        if(dinheiro >= Int(precoFuncionario)){
            nFuncionarios++
            labNFuncionarios.text = String(stringInterpolationSegment: Int(nFuncionarios))
            dinheiro -= Int(precoFuncionario)
            labDinheiro.text = String(stringInterpolationSegment: Int(dinheiro))
            precoFuncionario += precoFuncionario * 0.15
            labPrecoFuncionario.text = String(stringInterpolationSegment: Int(precoFuncionario))
        }
    }
    
    @IBAction func venderLoja(sender: UIButton) {
        nLojas--;
        labNLojas.text = String(stringInterpolationSegment: Int(nLojas));
        dinheiro += Int(precoLoja / 2)
        labDinheiro.text = String(stringInterpolationSegment: Int(dinheiro))
        precoLoja -= precoLoja * 0.13
        labPrecoLoja.text = String(stringInterpolationSegment: Int(precoLoja))
    }
    
    @IBAction func materiaPrima(sender: UIButton) {
        tipoMPrima++
        if(tipoMPrima == 3){
            tipoMPrima = 0
        }
        labTMateria.text = String(stringInterpolationSegment: Int(tipoMPrima));
    }
    
    @IBAction func reciclagem(sender: UIButton) {
        if(reciclagem == false){
            reciclagem = true
            labReciclagem.text = "1";
        } else {
            reciclagem = false
            labReciclagem.text = "0";
        }
    }
    
    @IBAction func maoDeObra(sender: UIButton) {
        tipoMObra++
        if(tipoMObra == 3){
            tipoMObra = 0
        }
        labMaoDeObra.text = String(stringInterpolationSegment: Int(tipoMObra));
    }
    
    @IBAction func CentroTreinamento(sender: UIButton) {
        if(treinamento == false){
            treinamento = true
            labTreinamento.text = "1";
        } else {
            treinamento = false
            labTreinamento.text = "0";
        }
    }
    
    @IBAction func numeroDeLojas(sender: UIButton) {
        if(dinheiro >= Int(precoLoja)){
            nLojas++
            labNLojas.text = String(stringInterpolationSegment: Int(nLojas))
            dinheiro -= Int(precoLoja)
            labDinheiro.text = String(stringInterpolationSegment: Int(dinheiro))
            precoLoja += precoLoja * 0.15
            labPrecoLoja.text = String(stringInterpolationSegment: Int(precoLoja))
        }
    }
    
    @IBAction func Marketing(sender: UIButton) {
        tipoMarketing++
        if(tipoMarketing == 3){
            tipoMarketing = 0
        }
        labMarketing.text = String(stringInterpolationSegment: Int(tipoMarketing));
    }
    
    @IBAction func funcPlaceHolder(sender: UIButton) {
        if(placeHolder == false){
            placeHolder = true
            labPlaceHolder.text = "1";
        } else {
            placeHolder = false
            labPlaceHolder.text = "0";
        }
    }
    
    
    func startGame() {
        
        let aSelector : Selector = "updateTime"
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
        
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
        calcMateriaPrima()
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
        
        matPrima += nLenhadores * 100 * tipo;
        volExtracao = nLenhadores * 100 * tipo + recicladosInt
        
        labVolExtracao.text = String(stringInterpolationSegment: Int(volExtracao))
        labMPrima.text = String(stringInterpolationSegment: Int(matPrima))
    }
    
    func calcProdutos(){
        var tipo:Int = 1;
        var custoMPrima:Int = 1000;
        
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
        
        if(tipoMarketing == 0){
            tipo = 1
        } else if(tipoMarketing == 1){
            tipo = 2
        } else if(tipoMarketing == 2){
            tipo = 3
        }
        
        if(placeHolder == true){
            
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
        reciclaveis += 4 - volVendas
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

