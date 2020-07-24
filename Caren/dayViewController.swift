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
    
    // Realmインスタンスを取得する
    let realm = try! Realm()
    var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending: true)
    //let task : String = ""
    
    var task : Task!
    // データの数（＝セルの数）を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   //     return taskArray.count
     return 1
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
        cellImage.image = UIImage(named: "IMG_2006")

        let cellLabel = cell.viewWithTag(2) as! UILabel
        print(task.title)
        cellLabel.textColor = .black
        cellLabel.text! = "tatle:\(task.title)\n"
         print(cellLabel.text!)
        cellLabel.text! = cellLabel.text! + "contents:\(task.contents)\n"
        print(cellLabel.text!)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString:String = formatter.string(from: task.date)
        cellLabel.text! = cellLabel.text! + "date:\(dateString)\n"
         print(cellLabel.text!)
        let dateString2:String = formatter.string(from: task.startDate)
        cellLabel.text! = cellLabel.text! + "Start:\(dateString2)\n"
         print(cellLabel.text!)
        let dateString3:String = formatter.string(from: task.endDate)
        cellLabel.text! = cellLabel.text! + "End:\(dateString3)\n"
         print(cellLabel.text!)
        
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

//    func hmLine(hm:date){
//
//    }
    
}
