//
//  task.swift
//  Caren
//
//  Created by 須田　知弘 on 2020/06/26.
//  Copyright © 2020 tomohiro.suda. All rights reserved.
//

import RealmSwift

class Task: Object {
    // 管理用 ID。プライマリーキー
    @objc dynamic var id = 0

    // タイトル
    @objc dynamic var title = ""

    // 内容
    @objc dynamic var contents = ""

    // 日時
    @objc dynamic var date = Date()

    // start日時
    @objc dynamic var startDate = Date()

    // end日時
    @objc dynamic var endDate = Date()

    
    // tag
    @objc dynamic var tag = ""
    

    // id をプライマリーキーとして設定
    override static func primaryKey() -> String? {
        return "id"
    }
}
