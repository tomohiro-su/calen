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
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet var containerView: UIView!
    
    let realm = try! Realm()
    var task: Task!
    
    var idCount = 0
    var contents = ""
    var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending: true)
    var tagCollection = TKCollectionView()
   
    //MARK:最初に読まれる所
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
    //    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
    //    self.view.addGestureRecognizer(tapGesture)
    //    add(tagCollection, toView: containerView)
    //    tagCollection.tags = ["Some", "Tag", "For", "You"]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let OneVC:OneViewController = segue.destination as! OneViewController
        if segue.identifier == "cellSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow
            OneVC.task = taskArray[indexPath!.row]
        } else {
            let task = Task()
            let allTasks = realm.objects(Task.self)
            if allTasks.count != 0 {
                task.id = allTasks.max(ofProperty: "id")! + 1
//            }
            OneViewController.task = task
        }
    }    //MARK:memボタン押す
    
    override func viewWillDisappear(_ animated: Bool) {
        
        //日時の変換
        let dt = Date()
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMdHms", options: 0, locale: Locale(identifier: "ja_JP"))
        
        //MARK:realmに書き込む
        try! realm.write {
            self.task.id = task.id
            self.task.date = dt
            self.task.contents = self.inputTextField.text!
            self.realm.add(self.task, update: .modified)
        
        }
        
        setNotification(task: task)
        super.viewWillDisappear(animated)
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
      } // --- ここまで追加 ---
}



