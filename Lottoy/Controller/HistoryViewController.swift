//
//  HistoryViewController.swift
//  Lottoy
//
//  Created by kibeom lee on 2018. 5. 31..
//  Copyright © 2018년 kibeom lee. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import RealmSwift

class HistoryViewController: UITableViewController {

    var QRSourcePassedOver : String?
    let realm = try! Realm()
    var lottoContainer : Results<Lottoes>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80

        if QRSourcePassedOver != nil {
            addLottoToDB()
        }
    
        loadData()
    }
    
    func addLottoToDB() {
        let str = QRSourcePassedOver?.components(separatedBy: "/?v=")
        
        
        do {
            try self.realm.write {
                if (str![0] == "http://qr.645lotto.net"){
                    
                    let numbers = str![1].components(separatedBy: "q")
                    for i in 1..<numbers.count{
                        let newItem = Lottoes()
                        newItem.name = "Lotto 6/45"
                        newItem.round = numbers[0]
                        newItem.num1 = String(numbers[i].prefix(2))
                        newItem.num2 = String((numbers[i].prefix(4)).suffix(2))
                        newItem.num3 = String((numbers[i].prefix(6)).suffix(2))
                        newItem.num4 = String((numbers[i].prefix(8)).suffix(2))
                        newItem.num5 = String((numbers[i].prefix(10)).suffix(2))
                        newItem.num6 = String((numbers[i].prefix(12)).suffix(2))
                        self.realm.add(newItem)
                    }
                    
                    
                    
                }else if (str![0] == "http://qr.nlotto.co.kr"){
                    let newItem = Lottoes()
                    newItem.name = "연금복권"
                    newItem.round = String(str![1].prefix(str![1].count - 8).suffix(4))
                    newItem.bonus = String(str![1].suffix(8).prefix(1))
                    newItem.num1 = String(str![1].suffix(8).prefix(3).suffix(1))
                    newItem.num2 = String(str![1].suffix(8).prefix(4).suffix(1))
                    newItem.num3 = String(str![1].suffix(8).prefix(5).suffix(1))
                    newItem.num4 = String(str![1].suffix(8).prefix(6).suffix(1))
                    newItem.num5 = String(str![1].suffix(8).prefix(7).suffix(1))
                    newItem.num6 = String(str![1].suffix(8).prefix(8).suffix(1))
                    self.realm.add(newItem)
                }
            }
        }catch {
            print("error saving data \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lottoContainer!.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! LottoCell
        cell.name.text = lottoContainer![indexPath.row].name
        cell.round.text = "제 \(lottoContainer![indexPath.row].round) 회"
        cell.bonus.text = "\(lottoContainer![indexPath.row].bonus) 조"
        cell.num1.text = lottoContainer![indexPath.row].num1
        cell.num2.text = lottoContainer![indexPath.row].num2
        cell.num3.text = lottoContainer![indexPath.row].num3
        cell.num4.text = lottoContainer![indexPath.row].num4
        cell.num5.text = lottoContainer![indexPath.row].num5
        cell.num6.text = lottoContainer![indexPath.row].num6
        
        if (cell.name.text == "Lotto 6/45") {
            cell.bonus.isHidden = true
        }else {
            cell.bonus.isHidden = false
        }
        
        
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            if let cellForDelete = lottoContainer?[indexPath.row] {
                do {
                    try realm.write {
                        realm.delete(cellForDelete)
                    }
                }catch {
                    print("error deleting cell")
                }
            }
        }
        tableView.reloadData()
    }
    
    
    func loadData() {
        lottoContainer = realm.objects(Lottoes.self).sorted(byKeyPath: "date", ascending: false)
        
        tableView.reloadData()
    }

}
