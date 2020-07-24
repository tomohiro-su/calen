//
//  PostTableViewCell.swift
//  Caren
//
//  Created by 須田　知弘 on 2020/07/23.
//  Copyright © 2020 tomohiro.suda. All rights reserved.
//

import UIKit
import RealmSwift

class PostTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var seachButton: UIButton!
    @IBOutlet weak var newTableButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//     func setPostData(_ postData: PostData) {
//
//
//        // Realmインスタンスを取得する
//           let realm = try! Realm()
//        var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending: true)
//        //let task : String = ""
//
//
//        self.dateLabel.text = ""
//        if let date = postData.date {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd HH:mm"
//            let dateString = formatter.string(from: date)
//            self.dateLabel.text = dateString
//        }
//
//    }
}
