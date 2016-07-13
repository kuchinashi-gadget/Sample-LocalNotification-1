//
//  Mkae_Local_Notification.swift
//  Sample_LocalNotification_1
//


import UIKit

class Mkae_Local_Notification: NSObject {
    
    class func set_localnotification_time(weekday:Int,alarm_hour:Int,alarm_minute:Int,alarm_second:Int) -> NSDate {
        //現在の日時を取得する
        let date = NSDate()
        let calender = NSCalendar.currentCalendar()
        let components = calender.components([.Year , .Month ,.Day , .Weekday], fromDate: date)
        let weekday = components.weekday  // 1が日曜日(week.swiftで設定)
        //        let hour = components.hour
        //        let minute = components.minute
        //        let second = components.second
        
        
        var now_time = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ss"
        var now_second = formatter.stringFromDate(now_time)
        print(now_second)
        formatter.dateFormat = "mm"
        var now_minute = formatter.stringFromDate(now_time)
        print(now_minute)
        formatter.dateFormat = "HH"
        var now_hour = formatter.stringFromDate(now_time)
        print(now_hour)
        
        
        //通知する曜日を指定
        //let fireWeekday = Week.Tuesday.rawValue
        //日:1
        //月:2
        //火:3
        //水:4
        //木:5
        //金:6
        //土:7
        let fireWeekday = weekday
        let interval: NSTimeInterval
        
        
        //現在の日時から次の月曜日を算出
        if(weekday > fireWeekday){
            print("次週")
            //次の週に設定
            interval = Double(60 * 60 * 24 * ((7 + fireWeekday) - weekday))
        }else if (weekday == fireWeekday) {
            var alarm_time_second = Double((alarm_hour * 60 + alarm_minute) * 60 + alarm_second)
            var now_time_second = (Double(now_hour)! * 60 + Double(now_minute)!) * 60 + Double(now_second)!
            
            if(alarm_time_second > now_time_second){
                print("今週")
                interval = Double(60 * 60 * 24 * (fireWeekday - weekday))
            }else{
                print("次週")
                interval = Double(60 * 60 * 24 * ((7 + fireWeekday) - weekday))
            }
            
        } else {
            print("今週")
            interval = Double(60 * 60 * 24 * (fireWeekday - weekday))
        }
        
        
        //通知する日時
        let nextDate = date.dateByAddingTimeInterval(interval)
        let fireDateComponents = calender.components([.Year , .Month ,.Day , .Weekday], fromDate: nextDate)
        //12時
        fireDateComponents.hour = alarm_hour
        //0分
        fireDateComponents.minute = alarm_minute
        //0秒
        fireDateComponents.second = alarm_second
        
        //fireDateComponents.repeatInterval = 1
        
        
        return calender.dateFromComponents(fireDateComponents)!
    }
    
    
    func make_localnotification() -> UILocalNotification{
        
        //ローカル通知
        let notification = UILocalNotification()
        
        //ローカル通知のタイトル
        notification.alertAction = "ローカル通知"
        
        //ローカル通知の本文
        notification.alertBody = "ローカル通知（アプリ内通知）のテスト"
        
        //通知される時間（バックグラウンドになってからの時間)
        //notification.fireDate = NSDate(timeIntervalSinceNow:10)
        
        //指定された時間に通知
        notification.fireDate = Mkae_Local_Notification.set_localnotification_time(5,alarm_hour: 15,alarm_minute: 36,alarm_second: 0)
        
        //通知音
        //notification.soundName = UILocalNotificationDefaultSoundName
        
        //mp3のファイルも指定可
        notification.soundName = "alarm.mp3"
        
        //アインコンバッジの数字
        notification.applicationIconBadgeNumber = notification.applicationIconBadgeNumber + 1
        
        //通知を識別するID
        notification.userInfo = ["notifyID":"test1"]
        
        
        //繰り返し処理
        //notification.repeatInterval = .Minute
        
        return notification
        
    }

}
