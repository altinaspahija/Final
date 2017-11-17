//
//  FavoritetController.swift
//  Coin Tracker
//
//  Created by Rinor Bytyci on 11/13/17.
//  Copyright © 2017 Appbites. All rights reserved.
//

import UIKit
import CoreData

class FavoritetController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    let rezultati:[String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Marrim appdelegate fajllin duke perdorur UIApplication.shared.delegate
        //dhe e konvertojme si Appdelegate
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        //Marrim prej Appdelegate nga variabla persistenContainer propertyn
        //viewContext qe na mundeson lidhjen me databaze
        let context = appdelegate.persistentContainer.viewContext
        
        /* Metodat per te ruajtur te dhena ne CoreData */
        
        //Krijojme nje EntityDescription me metoden insertNewObject, per te pergaditur
        //elementin e ri qe do te futet ne databaze
        let perdoruesiIRi = NSEntityDescription.insertNewObject(forEntityName: "Coins", into: context)
        
        //Perdoruesit te ri i japim vlerat qe duam ti fusim ne databaze
        perdoruesiIRi.setValue("Altina", forKey: "username")
        perdoruesiIRi.setValue("0000", forKey: "password")
        perdoruesiIRi.setValue(21, forKey: "mosha")
        
        
        //Duke perdorur do - catch, tentojme ne context ti ruajm ndryshimet e bera
        //Nese ka ndonje gabim, printohet mesazhi Gabim gjate ruajtjes
        do {
            try context.save()
        } catch {
            print("Gabim gjate ruajtjes")
        }
        
        
        /* Metodat per te lexuar te dhena ne CoreData */
        
        //Krijojme nje variabel request qe eshte objekt i tipit
        //NSFetchRequest me elemente NSFetchRequestResult
        //si parameter inicializues ja japim emrin e Entitetit (Tabeles)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Coins")
        
        //variables request i tregojme qe te ktheje objektet tona me te dhena
        //te sakta (jo Faults)
        request.returnsObjectsAsFaults = false
        
        //Duke perdorur do - catch tentojme te lexojme te dhenat nga tabela
        //Nese ka gabim printohet mesazhi "Gabim gjate Leximit"
        do {
            //krijojme nje variabel rezultati duke ja derguar context-it requestin
            //e krijuar me siper
            let rezultati = try context.fetch(request)
            
            //Per secilin element qe kthen rezultati, kontrollojme nese
            //mund te krijohet variabla username atehere e printojme ate
            for elementi in rezultati as! [NSManagedObject]{
                if let username = elementi.value(forKey: "username") as? String{
                    print(username)
                }
            }
            
            
        } catch {
            print("Gabim gjate Leximit")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
