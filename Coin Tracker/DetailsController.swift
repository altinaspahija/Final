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


class DetailsController: UIViewController {

    
    var selectedCoin:CoinCellModel!
    
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
        imgFotoja.af_setImage(withURL: URL(string: selectedCoin.imagePath)!)
        lblCoinName.text = selectedCoin.coinName
        
        
        let params : [String : String] = ["fsyms" : selectedCoin.coinSymbol , "tsyms" : "BTC,USD,EUR"]
        
        getDetails(params : params)
    }

    func getDetails(params:[String:String]){
        Alamofire.request(APIURL, method: .get).responseData { (data) in
            
            if data.result.isSuccess{
                let CoinJSON = try! JSON(data: data.result.value!)
                
                for (_,value) : (String,JSON) in CoinJSON["Data"]
                {
                    
                    let coincellmodel = CoinCellModel (coinName: value["CoinName"].stringValue, coinSymbol: value["Name"].stringValue, coinAlgo: value["Algorithm"].stringValue, totalSuppy: value["TotalCoinSupply"].stringValue, imagePath: value["ImageUrl"].stringValue)
                    
                    
                }
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //IBAction mbylle - per butonin te gjitha qe mbyll ekranin
   
    
}

