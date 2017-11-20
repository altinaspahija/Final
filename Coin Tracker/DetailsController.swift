//
//  ViewController.swift
//  Coin Tracker
//
//  Created by Rinor Bytyci on 11/12/17.
//  Copyright © 2017 Appbites. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
import CoreData

class DetailsController: UIViewController {

    
    var selectedCoin:CoinCellModel!
    var coindetailsmodel: CoinDetailsModel?
    
    //IBOutlsets jane deklaruar me poshte
    @IBOutlet weak var imgFotoja: UIImageView!
    @IBOutlet weak var lblDitaOpen: UILabel!
    @IBOutlet weak var lblDitaHigh: UILabel!
    @IBOutlet weak var lblDitaLow: UILabel!
    @IBOutlet weak var lbl24OreOpen: UILabel!
    @IBOutlet weak var lbl24OreHigh: UILabel!
    @IBOutlet weak var lbl24OreLow: UILabel!
    @IBOutlet weak var lblMarketCap: UILabel!
    @IBOutlet weak var lblCmimiBTC: UILabel!
    @IBOutlet weak var lblCmimiEUR: UILabel!
    @IBOutlet weak var lblCmimiUSD: UILabel!
    @IBOutlet weak var lblCoinName: UILabel!
    
    //APIURL per te marre te dhenat te detajume per coin
    //shiko: https://www.cryptocompare.com/api/ per detaje
    let APIURL = "https://min-api.cryptocompare.com/data/pricemultifull"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgFotoja.af_setImage(withURL: URL(string: selectedCoin.coinImage())!)
        lblCoinName.text = selectedCoin.coinName
        
        
        let params : [String : String] = ["fsyms" : selectedCoin.coinSymbol , "tsyms" : "BTC,USD,EUR"]
        
        getDetails(params : params)
    }

    func getDetails(params:[String:String]){
        Alamofire.request(APIURL, method: .get, parameters: params).responseData { (data) in
            
            if data.result.isSuccess{
                let CoinJSON = try! JSON(data: data.result.value!)
                
                let coindetailsmodel = CoinDetailsModel (marketCap: CoinJSON["DISPLAY"][self.selectedCoin.coinSymbol]["EUR"]["MKTCAP"].stringValue, hourHigh: CoinJSON["DISPLAY"][self.selectedCoin.coinSymbol]["EUR"]["HOUR24HIGH"].stringValue, hourLow: CoinJSON["DISPLAY"][self.selectedCoin.coinSymbol]["EUR"]["HOUR24LOW"].stringValue, hourOpen: CoinJSON["DISPLAY"][self.selectedCoin.coinSymbol]["EUR"]["MKTCAP"].stringValue, dayHigh: CoinJSON["DISPLAY"][self.selectedCoin.coinSymbol]["EUR"]["HIGHDAY"].stringValue, dayLow: CoinJSON["DISPLAY"][self.selectedCoin.coinSymbol]["EUR"]["LOWDAY"].stringValue, dayOpen: CoinJSON["DISPLAY"][self.selectedCoin.coinSymbol]["EUR"]["OPENDAY"].stringValue, priceEUR: CoinJSON["DISPLAY"][self.selectedCoin.coinSymbol]["EUR"]["PRICE"].stringValue, priceUSD: CoinJSON["DISPLAY"][self.selectedCoin.coinSymbol]["EUR"]["PRICE"].stringValue, priceBTC: CoinJSON["DISPLAY"][self.selectedCoin.coinSymbol]["EUR"]["PRICE"].stringValue)
                self.updateUI(CoinDetailsModelObject: coindetailsmodel)
                
            }
                else
                 {
                    self.lblDitaOpen.text = ""
                    self.lblDitaLow.text = ""
                    self.lblDitaHigh.text = ""
                    self.lbl24OreLow.text = ""
                    self.lbl24OreHigh.text = ""
                    self.lbl24OreOpen.text = ""
                    self.lblCmimiBTC.text = ""
                    self.lblCmimiEUR.text = ""
                    self.lblCmimiUSD.text = ""
                    self.lblMarketCap.text = ""
                }
                
            }
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI (CoinDetailsModelObject:CoinDetailsModel)
    {
        coindetailsmodel = CoinDetailsModelObject
        lblDitaOpen.text = CoinDetailsModelObject.dayOpen
        lblDitaLow.text = CoinDetailsModelObject.dayLow
        lblDitaHigh.text = CoinDetailsModelObject.dayHigh
        lbl24OreLow.text = CoinDetailsModelObject.hourLow
        lbl24OreHigh.text = CoinDetailsModelObject.hourHigh
        lbl24OreOpen.text = CoinDetailsModelObject.hourOpen
        lblCmimiBTC.text = CoinDetailsModelObject.priceBTC
        lblCmimiEUR.text = CoinDetailsModelObject.priceEUR
        lblCmimiUSD.text = CoinDetailsModelObject.priceUSD
        lblMarketCap.text = CoinDetailsModelObject.marketCap
        
    }
   
    @IBOutlet weak var ruaj: UIButton!
    
    @IBAction func ruaj(_ sender: Any) {
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appdelegate.persistentContainer.viewContext
        
        let request = NSEntityDescription.insertNewObject(forEntityName: "Coins" , into: context)
        
        request.setValue(selectedCoin.coinName, forKey: "coinName")
        request.setValue(selectedCoin.coinSymbol, forKey: "coinSymbol")
        request.setValue(selectedCoin.coinAlgo, forKey: "coinAlgo")
        request.setValue(selectedCoin.totalSuppy, forKey: "totalSuppy")
        request.setValue(selectedCoin.coinImage(), forKey: "imagePath")
        
        do
        {
            try context.save()
        
        }
        catch
        {
        print ("Gabim gjate ruajtjes")
        }
        
        
    }
    
    
    @IBAction func mbylle(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

