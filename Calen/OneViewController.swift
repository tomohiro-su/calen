//
//  OneViewController.swift
//  Caren
//
//  Created by 須田　知弘 on 2020/06/26.
//  Copyright © 2020 tomohiro.suda. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications
import TaggerKit

class OneViewController: UIViewController {
    
    @IBOutlet weak var memBotton: UIButton!
    @IBOutlet weak var contentsTextField: UITextField!
    //@IBOutlet var containerView: UIView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var allImageView: UIImageView!
    
    @IBOutlet weak var tagTextField: UITextField!
    
    let realm = try! Realm()
    var task: Task!
    
    var idCount = 0
    var contents = ""
    var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending: true)
    
    
    //MARK:最初に読まれる所
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        allImageView.image = UIImage(named:"inhand.png")
        //背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        //            let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:selector(dismissKeyboard))
        //            self.view.addGestureRecognizer(tapGesture)
        
        //    add(tagCollection, toView: containerView)
        //    tagCollection.tags = ["Some", "Tag", "For", "You"]
    }
    
    //
    //override func viewWillDisappear(_ animated: Bool) {
    
    @IBAction func tapButton(_ sender: Any) {
        //     print(self.titleTextField.text!)
        //
        
        
        self.task = Task()//重要インスタンス
        let allTasks = realm.objects(Task.self)
        if allTasks.count != 0 {
            self.task.id = allTasks.max(ofProperty: "id")! + 1
        }
        let realm = try! Realm()
        
        // task = Task()
        //let indexPath = dayViewController.tableView.indexPathForSelectedRow
        //self.task = taskArray[0]
        
        //  setNotification(task: task)
        let dt = Date()
        print(self.contentsTextField.text!)
        print(dt)
        print(self.startDatePicker.date)
        print(self.endDatePicker.date)

        
        //MARK:realmに書き込む
        try! realm.write {
            //     self.task.id = task.id
            print("self.task : \(self.task)")
            print("self.titleTextField : \(self.titleTextField)")
            
            
            self.task.title = self.titleTextField.text!
            self.task.contents = self.contentsTextField.text!
            self.task.date = dt
            self.task.startDate = self.startDatePicker.date
            self.task.endDate = self.endDatePicker.date
            self.task.tag = String(task.id)
            self.task.image = "inhand.png"
            self.realm.add(self.task, update: .modified)
            
            print(self.task.id)
            print(self.task.title)
            print(self.task.contents)
            print(self.task.date)
            print(self.task.startDate)
            print(self.self.task.endDate)
            print(self.task.tag )
            
            
        }
        
        setNotification(task: task)
        //super.viewWillDisappear(animated)
    }
    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
    }
    func setNotification(task: Task) {
        let content = UNMutableNotificationContent()
        // タイトルと内容を設定(中身がない場合メッセージ無しで音だけの通知になるので「(xxなし)」を表示する)
        if task.title == "" {
            content.title = "(タイトルなし)"
        } else {
            content.title = task.title
        }
        if task.contents == "" {
            content.body = "(内容なし)"
        } else {
            content.body = task.contents
        }
        content.sound = UNNotificationSound.default
        
        // ローカル通知が発動するtrigger（日付マッチ）を作成
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: task.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // identifier, content, triggerからローカル通知を作成（identifierが同じだとローカル通知を上書き保存）
        let request = UNNotificationRequest(identifier: String(task.id), content: content, trigger: trigger)
        
        // ローカル通知を登録
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            print(error ?? "ローカル通知登録 OK")  // error が nil ならローカル通知の登録に成功したと表示します。errorが存在すればerrorを表示します。
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




