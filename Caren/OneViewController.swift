//
//  OneViewController.swift
//  Caren
//
//  Created by 須田　知弘 on 2020/06/26.
//  Copyright © 2020 tomohiro.suda. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {
    
    @IBOutlet weak var memBotton: UIButton!
    
    
    let realm = try! Realm()
    var task: Task!
    var idCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
    }
    //MARK:memボタン押す
    @IBAction func memBotton(_ sender: Any) {
        //日時の変換
        let dt = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMdHms", options: 0, locale: Locale(identifier: "ja_JP"))
        
        //MARK:realmに書き込む
        try! realm.write {
            self.task.id = idCount
            self.task.date = dateFormatter.string(from: dt)
            self.realm.add(self.task, update: .modified)
            idCount += idCount
        }
        
    }
    
    
}



