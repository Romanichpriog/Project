//
//  ViewController.swift
//  Conventor
//
//  Created by Roman on 14.06.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    var valuts:[String] = []
    var socValuts:[String] = []
    var getfo:[String:Double] = [:]
    
    
    func er(){
    (fromValue.selectedRow(inComponent: 0))
    guard let url = URL(string: "https://api.exchangeratesapi.io/latest") else { return }
    let session = URLSession.shared
    session.dataTask(with: url) { (data, response, error) in
       
        guard let data = data else { return }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            guard let rates:[String:Double] = json["rates"] as? [String : Double]  else { return }
            self.getfo = rates
            
        } catch {
            //print(error)
        }
    }.resume()
    }
    
    
    @IBOutlet weak var toValue: UIPickerView!
    
    @IBOutlet weak var summa: UITextField!
    
    @IBOutlet weak var result: UILabel!
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return valuts[0].count
    }
    //func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      //  return valuts[row]
    //}
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x:0,y:0,width:pickerView.frame.width,height:400));
        label.lineBreakMode = .byWordWrapping;
        label.numberOfLines=0
        label.text = valuts[row]
        label.sizeToFit()
        return label
    }
    
    
    
    
    @IBOutlet weak var fromValue: UIPickerView!
    
    
    
    
    

    @IBAction func get(_ sender: UIButton) {
        
        
        guard var summaVEuro = Double(summa.text!) else { return }
        if socValuts[fromValue.selectedRow(inComponent: 0)] != "EUR"{
            summaVEuro=summaVEuro/getfo[socValuts[fromValue.selectedRow(inComponent: 0)]]!
        }
        if socValuts[toValue.selectedRow(inComponent: 0)] != "EUR"{
            summaVEuro = summaVEuro*getfo[socValuts[toValue.selectedRow(inComponent: 0)]]!
        }
        result.text="Result:"
        result.text = result.text!+" \(round(summaVEuro))"

        
    }
    override func viewDidLoad() {
        er()
        super.viewDidLoad()
        fromValue.delegate = self
        fromValue.dataSource = self
        toValue.delegate=self
        toValue.dataSource=self
        valuts = ["канадский доллар","американский доллар","рубль","евро","Гонконгский доллар","Исландская кронa"," Филиппинское песо","Датская крона","Венгерский форинт","Чешская крона","Австралийский доллар","Румынский лей","Шведская крона","Индонезийская рупия","Индийская рупия","Бразильский реал","Хорватская куна","Японская иена","Тайский бат","Швейцарский франк","Сингапурский доллар","Польский злотый","Болгарский лев","Турецкая лира","Китайский юань","Норвежская крона","Новозеландский доллар","Южноафриканский рэнд"," Мексиканское песо","Новый израильский шекель","Фунт стерлингов","Южнокорейская вона","Малайзийский ринггит"]
        socValuts = ["CAD","USD","RUB","EUR","HKD","ISK","PHP","DKK","HUF","CZK","AUD","RON","SEK","IDR","INR","BRL","HRK","JPY","THB","CHF","SGD","PLN","BGN","TRY","CNY","NOK","NZD","ZAR","MXN","ILS","GBP","KRW","MYR"]
        // Do any additional setup after loading the view.
    }


}

