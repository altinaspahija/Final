//
//  FavoritetController.swift
//  Coin Tracker
//
//  Created by Rinor Bytyci on 11/13/17.
//  Copyright © 2017 Appbites. All rights reserved.
//

import UIKit
import CoreData
import AlamofireImage

class FavoritetController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    let rezultati:[String] = []
    var coinstable: [CoinCellModel] = []
    var coins: CoinCellModel! = nil
    
   
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinstable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell") as! CoinCell
        cell.lblEmri.text = coinstable[indexPath.row].coinName
        cell.lblSymboli.text = coinstable[indexPath.row].coinSymbol
        cell.imgFotoja.af_setImage(withURL: URL(string: coinstable[indexPath.row].coinImage())!)
        cell.lblTotali.text = coinstable[indexPath.row].totalSuppy
        cell.lblAlgoritmi.text = coinstable[indexPath.row].coinAlgo
        print(coinstable[indexPath.row].coinImage())
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "CoinCell", bundle: nil), forCellReuseIdentifier: "coinCell")
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        let context = appdelegate.persistentContainer.viewContext
        
      
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Coins")
        

        request.returnsObjectsAsFaults = false
        
        
        do {
            
            let rezultati = try context.fetch(request)
            
            
            for elementi in rezultati as! [NSManagedObject]{
                self.coinstable.append(CoinCellModel(coinName: (elementi.value(forKey: "coinName")as? String)!, coinSymbol: (elementi.value(forKey: "coinSymbol")as? String)!, coinAlgo: (elementi.value(forKey: "coinAlgo")as? String)!,totalSuppy: (elementi.value(forKey: "totalSuppy")as? String)!, imagePath: (elementi.value(forKey: "imagePath")as? String)!))
                }
            }
    catch {
            print("Gabim gjate Leximit")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func kthehu(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
