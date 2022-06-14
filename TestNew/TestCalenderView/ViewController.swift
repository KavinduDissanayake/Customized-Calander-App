//
//  ViewController.swift
//  TestNew
//
//  Created by Kavindu Dissanayake on 2022-06-13.
//

import UIKit
import JZCalendarWeekView
import FSCalendar

class ViewController: UIViewController {
    

    @IBOutlet weak var weekView: CustomWeekView!
    
    @IBOutlet weak var calanderView: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
        calanderView.delegate = self
        calanderView.dataSource = self
        calanderView.scope =  .week
        calanderView.calendarHeaderView.isHidden = true
        
        weekView.isUserInteractionEnabled = true
        weekView.baseDelegate = self
        
        
        weekView.accessibilityLabel = ""
        weekView.updateFlowLayout(JZWeekViewFlowLayout(hourHeight: 50, rowHeaderWidth: 70, columnHeaderHeight: 0, hourGridDivision: JZHourGridDivision.noneDiv))
    
        
        setWeekView(date:Date())
        setUPCalanderDate(date:Date())

    }
    
    
    

    
    func setWeekView(date:Date){
        
        
        let isoDate = "2022-06-13T10:44:00+0000"

         let dateFormatter = DateFormatter()
         dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
         let date = dateFormatter.date(from:isoDate)!
        
        
        let isoDate2 = "2022-06-14T10:44:00+0000"

         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
         let date2 = dateFormatter.date(from:isoDate2)!

        
        
        
        
                    
//        lazy var eventsByDate = JZWeekViewHelper.getIntraEventsByDate(originalEvents: events)
     
//        var eventArray:[Date: [JZBaseEvent] = [:]
                        
                    
        weekView.setupCalendar(numOfDays: 1, setDate: date, allEvents: [:])
    }
    
    func setUPCalanderDate(date:Date){
        calanderView.select(date)
    }
    

}


extension  ViewController:FSCalendarDelegate ,FSCalendarDataSource{
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        setWeekView(date: date)
        setUPCalanderDate(date: date)
    }
    
}

extension ViewController: JZBaseViewDelegate {
    
    func initDateDidChange(_ weekView: JZBaseWeekView, initDate: Date) {
        var date:Date = initDate.add(component: .day, value: (weekView.numOfDays))
       
        
//        print(date)
        
        setUPCalanderDate(date: date)

  
        
        
    }
    

}




extension DateFormatter {

    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}

extension String {

    func toDate (dateFormatter: DateFormatter) -> Date? {
        return dateFormatter.date(from: self)
    }

    func toDateString (dateFormatter: DateFormatter, outputFormat: String) -> String? {
        guard let date = toDate(dateFormatter: dateFormatter) else { return nil }
        return DateFormatter(format: outputFormat).string(from: date)
    }
}

extension Date {

    func toString (dateFormatter: DateFormatter) -> String? {
        return dateFormatter.string(from: self)
    }
}
