//
//  dayViewController.swift
//  Caren
//
//  Created by 須田　知弘 on 2020/06/26.
//  Copyright © 2020 tomohiro.suda. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class dayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var dayTableView: UITableView!
    @IBOutlet weak var changeB: UIButton!
    @IBOutlet weak var toCalenButton: UIButton!
    
    // Realmインスタンスを取得する
    let realm = try! Realm()
    var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending: true)
    //let task : String = ""
    
    var task : Task!
    // データの数（＝セルの数）を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    // カスタムセルを登録する
    // let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
    // func tableView;.register(nib, forCellReuseIdentifier: "Cell")
    
    
    // 各セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for:indexPath)
        let cellImage = cell.viewWithTag(1) as! UIImageView
        let task = taskArray[indexPath.row]
        cellImage.image = UIImage(named: task.image)
        
        let cellLabel = cell.viewWithTag(2) as! UILabel
        
        print(task.title)
        cellLabel.textColor = .black
        cellLabel.text! = "T:\(task.title)\n"
        print(cellLabel.text!)
        
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        //        let dateString:String = formatter.string(from: task.date)
        //        cellLabel.text! = cellLabel.text! + "date:\(dateString)\n"
        //         print(cellLabel.text!)
        let dateString2:String = formatter.string(from: task.startDate)
        cellLabel.text! = cellLabel.text! + "S:\(dateString2)\n"
        print(cellLabel.text!)
        let dateString3:String = formatter.string(from: task.endDate)
        cellLabel.text! = cellLabel.text! + "E:\(dateString3)\n"
        print(cellLabel.text!)
        cellLabel.text! = cellLabel.text! + "Contents:\n\(task.contents)\n"
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayTableView.delegate = self
        dayTableView.dataSource = self
        //   MSSectionLayoutTypeHorizontalTile
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dayTableView.reloadData()
    }
    //MARK:segue で画面遷移する時に呼ばれる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier != "toCalen"{
            let oneViewController:OneViewController = segue.destination as! OneViewController
            
            if segue.identifier == "cellSegue" {
                let indexPath = self.dayTableView.indexPathForSelectedRow
                oneViewController.task = taskArray[indexPath!.row]
            } else {
                let task = Task()
                
                let allTasks = realm.objects(Task.self)
                if allTasks.count != 0 {
                    task.id = allTasks.max(ofProperty: "id")! + 1
                }
                
                oneViewController.task = task
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // --- ここから ---
        if editingStyle == .delete {
            // 削除するタスクを取得する
            let task = self.taskArray[indexPath.row]
            
            // ローカル通知をキャンセルする
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [String(task.id)])
            
            // データベースから削除する
            try! realm.write {
                self.realm.delete(task)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            // 未通知のローカル通知一覧をログ出力
            center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
                for request in requests {
                    print("/---------------")
                    print(request)
                    print("---------------/")
                }
            }
        }
    }
    
    func hmLine(){
        let time = view.viewWithTag(1) as? UILabel
        time?.text = "ラベルです。"
    }
    
    @IBAction func changeB(_ sender: Any) {
        for i in 1..<13{
            let j = i*100+1
            let time = view.viewWithTag(j) as? UILabel
            time?.text = "\(String(i)):00"
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        task = taskArray[indexPath.row]
        let dateString:String = formatter.string(from: task.startDate)
        print(dateString)
        let time = view.viewWithTag(1000) as? UILabel
        time?.text = dateString
        formatter.dateFormat = "HH"
        let dateString4:String = formatter.string(from: task.startDate)
        print(dateString4)
        timeCodeReset()
        timeCode(hour: Int(dateString4)!)
    }
    
    func timeCode(hour:Int){
        
        let j = (hour+1)*100+2
        let time = view.viewWithTag(j) as? UILabel
        time?.text = "○"
        
    }
    func timeCodeReset(){
        for i in 1..<26{
            let  j = i*100+2
            let time = view.viewWithTag(j) as? UILabel
            time?.text = "ー"
        }
    }
    @IBAction func toCalenBotton(_ sender: Any) {
        
    }
}
