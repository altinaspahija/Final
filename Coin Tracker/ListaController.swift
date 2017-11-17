//
//  ListaController.swift
//  Coin Tracker
//
//  Created by Rinor Bytyci on 11/12/17.
//  Copyright © 2017 Appbites. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class ListaController: UIViewController, UITableViewDataSource, UITableViewDelegate{
  

    @IBOutlet weak var TableView: UITableView!
    var allcoins:[CoinCellModel] = []
    var selectedCoin:CoinCellModel!


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "shfaqDetajet" {
            let allcoins = segue.destination as! DetailsController
            allcoins.selectedCoin = selectedCoin
        }
    }
    
    
    //URL per API qe ka listen me te gjithe coins
    //per me shume detaje : https://www.cryptocompare.com/api/
    let APIURL = "https://min-api.cryptocompare.com/data/all/coinlist"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        
        
        //regjistro custom cell qe eshte krijuar me NIB name dhe
        //reuse identifier???
        
        TableView.register(UINib.init(nibName: "CoinCell", bundle: nil), forCellReuseIdentifier: "coinCell")
        TableView.rowHeight = UITableViewAutomaticDimension
        
        getDataFromAPI()
    }
    
    
    
   
    func getDataFromAPI(){
        Alamofire.request(APIURL, method: .get).responseData { (data) in
            
            if data.result.isSuccess{
                let CoinJSON = try! JSON(data: data.result.value!)
                
                for (_,value) : (String,JSON) in CoinJSON["Data"]
                {
                
                    let coincellmodel = CoinCellModel (coinName: value["CoinName"].stringValue, coinSymbol: value["Name"].stringValue, coinAlgo: value["Algorithm"].stringValue, totalSuppy: value["TotalCoinSupply"].stringValue, imagePath: value["ImageUrl"].stringValue)
                    
                    self.allcoins.append(coincellmodel)
        }
            self.TableView.reloadData()
        }
        
    }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allcoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell") as! CoinCell
        cell.lblEmri.text = allcoins[indexPath.row].coinName
        cell.lblTotali.text = allcoins[indexPath.row].totalSuppy
        cell.lblSymboli.text = allcoins[indexPath.row].coinSymbol
        cell.lblAlgoritmi.text = allcoins[indexPath.row].coinAlgo
        cell.imgFotoja.af_setImage(withURL: URL(string: allcoins[indexPath.row].imagePath)!)
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = allcoins[indexPath.row]
        selectedCoin = coin
        performSegue(withIdentifier: "shfaqDetajet", sender: self)
    }

   

}
