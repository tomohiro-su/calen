//
//  CarenViewController.swift
//  Caren
//
//  Created by 須田　知弘 on 2020/06/26.
//  Copyright © 2020 tomohiro.suda. All rights reserved.
//

import UIKit
import RealmSwift
import FSCalendar

class CarenViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource, FSCalendarDelegateAppearance {
    //    fileprivate weak var myCalendar: FSCalendar!
    
    var calenderView:FSCalendar = FSCalendar()
    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var myCalendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendar = FSCalendar()
        calendar.dataSource = self
        calendar.delegate = self
        //        view.addSubview(calendar)
        //        self.calendar = calendar
        //        setupCalender()
                let borderSelectionColors = ["2020/07/08": UIColor.brown]
        var datesWithEvent = ["2020-07-03"]
        // Do any additional setup after loading the view.
    }
    
//    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
//        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
//        // cellのデザインを変更
//        return cell
//    }
//
    //    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
    //        self.configure(cell: cell, for: date, at: position)
    //        // cellのデザインを変更
    //    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        labelDate.text = "\(year)/\(month)/\(day)"
        
        

        //        let formatter = DateFormatter()
        //        formatter.dateFormat = "yyyy/MM/dd"
        //        let da = formatter.string(from: date)
        //        labelDate.text = da
        //
        //        //スケジュール取得
        //        let realm = try! Realm()
        //        let result = realm.objects(Task.self).filter("date = '\(da)'")
        //        //ここでString型のdateと一致させている。
        //
        //        print(result)
        //        labelEvent.text = "イベントはありません"
        //        for ev in result {
        //            if ev.date == da {
        //                labelEvent.text = ev.event
        //            }
        //        }
    }
    
    
 //       override func loadView() {
   //         let view = UIView(frame: UIScreen.main.bounds)
          //      view.backgroundColor = UIColor.groupTableViewBackground
   //             self.view = view
                
    //            let height: CGFloat = UIDevice.current.model.hasPrefix("iPad") ? 450 : 300
//               let calendar = FSCalendar()
//                calendar.dataSource = self
//                calendar.delegate = self
//                calendar.allowsMultipleSelection = true
//                calendar.swipeToChooseGesture.isEnabled = true
   //                 calendar.backgroundColor = UIColor.white
//                calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]
//                self.view.addSubview(calendar)
            //    self.calendar = calendar
            //    calendar.select(self.dateFormatter1.date(from: "2015/10/03"))
             //   let todayItem = UIBarButtonItem(title: "TODAY", style: .plain, target: self, action: #selector(self.todayItemClicked(sender:)))
        //        self.navigationItem.rightBarButtonItem = todayItem
                
                // For UITest
            //    self.calendar.accessibilityIdentifier = "calendar"
          //  }
            
    //    extension ViewController:FSCalendarDelegate,FSCalendarDataSource {
    //        func calender(_ calender:FSCalendar,titleFor date: Date) -> String?{
    //            return "maxcodes.io"
    //        }
    //        func calender(_ calendar:FSCalendar,subtitleFor date: Date) -> String? {
    //            return "subscribe"
    //        }
    //
    //    func setupCalender(){
    //        view.addSubview(calenderView)
    //        calenderView.frame = view.frame
    //        calenderView.delegate = self
    //    }
    
}
