//
//  CalenderController.swift
//  TestNew
//
//  Created by Kavindu Dissanayake on 2022-06-14.
//

import UIKit
import JZCalendarWeekView

class CalenderController: UIViewController {
    
    
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var collectioonView: UICollectionView!
    
    @IBOutlet weak var weekView: CustomWeekView!
    
    var selectedDate = ""
    var selectedDateIndex =  0
    
    var monthToShow = ""
    var lastDateInTheArray  = ""
    var firstDateInTheArray = ""
    
    var sevenDates:[String] = []
    
    
    let viewModel = CalenderVM()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sample Calender App"
        setupCalanderView()
        setupCalanderWeekView(date: Date())
        getSevenDays()
        perFormGesture()
    }
    
    
    
}





//calender View
extension CalenderController :UICollectionViewDelegate, UICollectionViewDataSource{
    
    func setupCalanderView(){
        // Do any additional setup after loading the view.
        collectioonView.delegate = self
        collectioonView.dataSource = self
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sevenDates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = collectionView.frame.width / 7 - 5
        let height = collectionView.frame.height
        
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DaysCVCID", for: indexPath) as! DaysCVC
       
        cell.configCell(date: self.sevenDates[indexPath.row],selectedDate: selectedDate)
        
        
       
        
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        if let cell = collectionView.cellForItem(at: indexPath) as? DaysCVC {
            reDrawCells(selectedDate: cell.date)
            reDrawWeekView(date: cell.date)
        }
        
    }

    
    
//    func restCells(){
//
//        let allLoadedCells = collectioonView.getAllCells()
//
//        for cell in allLoadedCells {
//            (cell as! DaysCVC).removeColor()
//            (cell as! DaysCVC).reDrawCurrentDate()
//        }
//
//    }
    
    func reDrawCells(selectedDate:String){
      
        
        let allLoadedCells = collectioonView.getAllCells()
       
        
        
        
        for cell in allLoadedCells {
            if selectedDate ==  (cell as! DaysCVC).date {
                (cell as! DaysCVC).addColor()
            }else{
                (cell as! DaysCVC).removeColor()
                (cell as! DaysCVC).checkCurrentDate()

            }
        }

    }
   
    
    
    func formatDate(date: String,dateFormat:String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyy"
        let dateFormatterSet = DateFormatter()
        dateFormatterSet.dateFormat = dateFormat
        let dateObj = dateFormatterGet.date(from: date)!
        return dateFormatterSet.string(from: dateObj)
    }
    
    
    func getSevenDays(isFromWeekView:Bool = false,weekViewDate:String = ""){
        var isNotincudeExistingArray = false
        
        
        if isFromWeekView {
            if   sevenDates.contains(weekViewDate) {
                reDrawCells(selectedDate:weekViewDate)
            }else{
                selectedDate = weekViewDate
                isNotincudeExistingArray = true
            }
            
            
        }else{
            if self.selectedDate == "" {
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "dd-MM-yyyy"
                selectedDate = formatter.string(from: date)
                
            }
        }
        
        
        
        
        let selectdDateInString = self.selectedDate
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let date = dateFormatter.date(from: selectdDateInString)!
        
        
        
        
        let dateFormatterq1 = DateFormatter()
        dateFormatterq1.dateFormat = "EEEE"
        
        let weekDay = dateFormatterq1.string(from: date)
        
        
        self.selectedDateIndex = 0
        
        
        switch weekDay {
        case "Sunday": selectedDateIndex = 0
            break
        case "Monday": selectedDateIndex = 1
            break
        case "Tuesday": selectedDateIndex = 2
            break
        case "Wednsday": selectedDateIndex = 3
            break
        case "Thursday": selectedDateIndex = 4
            break
        case "Friday": selectedDateIndex = 5
            break
        case "Sturday": selectedDateIndex = 6
            break
            
        default:
            break
        }
        
        
        var sevenDayToShow:[String] = []
        
        sevenDayToShow.removeAll()
        
        
        for index in 0..<7 {
            let newIndex = index - selectedDateIndex
            
            sevenDayToShow.append(CalenderController.getDates(i:newIndex,currentDate:date).0)
        }
        
        
        //month selection
        
        let monethSelectFrom = sevenDayToShow[3]
        let dateFormatterMonth = DateFormatter()
        dateFormatterMonth.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterMonth.dateFormat = "dd-MM-yyyy"
        
        
        let monthDate = dateFormatterMonth.date(from: monethSelectFrom)!
        
        
        let dateFormatterMonth1 = DateFormatter()
        dateFormatterMonth1.dateFormat = "MMMM, yyyy"
        
        let month = dateFormatterMonth1.string(from: monthDate)
        self.monthToShow = month
        
        self.monthLabel.text =  month
        
        self.lastDateInTheArray = sevenDayToShow.last  ?? ""
        self.firstDateInTheArray  = sevenDayToShow.first  ?? ""
        self.sevenDates = sevenDayToShow
        
        
        if isNotincudeExistingArray {
            collectioonView.reloadData()
        }
        
        
        
    }
    
    
    
    static func getDates(i:Int,currentDate:Date)->(String,String){
        
        let dateFormatterq1 = DateFormatter()
        dateFormatterq1.locale = Locale(identifier: "en_US")
        var date = currentDate
        
        let cal = Calendar.current
        date = cal.date(byAdding: .day, value: i, to: date)!
        dateFormatterq1.dateFormat  = "dd-MM-yyyy"
        
        let stringFormate1 = dateFormatterq1.string(from: date)
        dateFormatterq1.dateFormat = "dd-MM-yyyy"
        let stingFormate2  = dateFormatterq1.string(from: date)
        
        return (stringFormate1,stingFormate2)
    }
    
    
    
    func getNextSevenDays(CompletionHandler: @escaping (String) -> Void){
        
        let selectedDateInString = self.lastDateInTheArray
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let date = dateFormatter.date(from: selectedDateInString)!
        
        
        var sevenDayToShow:[String] = []
        
        for index in 1...7{
            sevenDayToShow.append(CalenderController.getDates(i: index, currentDate: date).0)
            
        }
        
        
        //month selection
        
        let monethSelectFrom = sevenDayToShow[3]
        let dateFormatterMonth = DateFormatter()
        dateFormatterMonth.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterMonth.dateFormat = "dd-MM-yyyy"
        
        
        let monthDate = dateFormatterMonth.date(from: monethSelectFrom)!
        
        
        let dateFormatterMonth1 = DateFormatter()
        dateFormatterMonth1.dateFormat = "MMMM, yyyy"
        
        let month = dateFormatterMonth1.string(from: monthDate)
        self.monthToShow = month
        
        
        self.lastDateInTheArray = sevenDayToShow.last  ?? ""
        self.firstDateInTheArray  = sevenDayToShow.first  ?? ""
        self.sevenDates = sevenDayToShow
        
        return CompletionHandler("success")
    }
    
    
    func getPreviousSevenDays(CompletionHandler: @escaping (String) -> Void){
        
        let selectedDateInString = self.firstDateInTheArray
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let date = dateFormatter.date(from: selectedDateInString)!
        
        
        var sevenDayToShow:[String] = []
        
        var count =  7
        
        
        while count != 0{
            sevenDayToShow.append(CalenderController.getDates(i: -count, currentDate: date).0)
            count = count - 1
        }
        
        
        //month selection
        
        let monethSelectFrom = sevenDayToShow[3]
        let dateFormatterMonth = DateFormatter()
        dateFormatterMonth.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterMonth.dateFormat = "dd-MM-yyyy"
        
        
        let monthDate = dateFormatterMonth.date(from: monethSelectFrom)!
        
        
        let dateFormatterMonth1 = DateFormatter()
        dateFormatterMonth1.dateFormat = "MMMM, yyyy"
        
        let month = dateFormatterMonth1.string(from: monthDate)
        self.monthToShow = month
        
        
        self.lastDateInTheArray = sevenDayToShow.last  ?? ""
        self.firstDateInTheArray  = sevenDayToShow.first  ?? ""
        self.sevenDates = sevenDayToShow
        
        return CompletionHandler("success")
    }
    
    
    func perFormGesture(){
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(sender:)))
        
        let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(sender:)))
        
        leftGesture.direction = .left
        rightGesture.direction = .right
        
        
        self.collectioonView.addGestureRecognizer(leftGesture)
        self.collectioonView.addGestureRecognizer(rightGesture)
        
    }
    
    
    func swipeTransationToLeftSide(_ leftSide: Bool)-> CATransition {
        let transition = CATransition()
        transition.startProgress = 0.0
        transition.endProgress = 1.0
        
        transition.type = CATransitionType.push
        transition.subtype = leftSide ? CATransitionSubtype.fromLeft : CATransitionSubtype.fromRight
        
        transition.duration = 0.3
        
        return transition
        
        
    }
    
    @objc func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left){
            
            self.getNextSevenDays { response in
                                
                if response == "success" {
                    DispatchQueue.main.async {
                        self.collectioonView.layer.add(self.swipeTransationToLeftSide(true),forKey:nil)
                        
                        self.collectioonView.collectionViewLayout.invalidateLayout()
                        self.collectioonView.layoutSubviews()
                        self.collectioonView.reloadData()
                        
                        self.monthLabel.text = self.monthToShow
                        
                    }
                }
            }
        }
        
        
        
        if (sender.direction == .right){
            
            self.getPreviousSevenDays { response in
                
                

                
                if response == "success" {
                    DispatchQueue.main.async {
                        self.collectioonView.layer.add(self.swipeTransationToLeftSide(false),forKey:nil)
                        
                        self.collectioonView.collectionViewLayout.invalidateLayout()
                        self.collectioonView.layoutSubviews()
                        self.collectioonView.reloadData()
                        
                        self.monthLabel.text = self.monthToShow
                        
                    }
                }
            }
        }
    }
    
   
}



//week View
extension CalenderController:JZBaseViewDelegate {
    
    func  setupCalanderWeekView(date:Date) {
        weekView.setupCalendar(numOfDays: 1, setDate: date, allEvents:  viewModel.eventsByDate)
        weekView.baseDelegate = self
        weekView.updateFlowLayout(JZWeekViewFlowLayout(hourHeight: 50, rowHeaderWidth: 70, columnHeaderHeight: 0, hourGridDivision: JZHourGridDivision.noneDiv))
    }
    
    func reDrawWeekView(date:String){
        let dateFormatter = DateFormatter()
        // Set Date Format
        dateFormatter.dateFormat = "dd-MM-yyyy"
        // Convert String to Date
        let dateCast = dateFormatter.date(from: date)!
        
        print("💚\(date)💚")
        weekView.setupCalendar(numOfDays: 1, setDate: dateCast, allEvents: viewModel.eventsByDate)
    
    }
    func initDateDidChange(_ weekView: JZBaseWeekView, initDate: Date) {
        let date:Date = initDate.add(component: .day, value: (weekView.numOfDays))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        getSevenDays(isFromWeekView:true,weekViewDate: formatter.string(from: date))
    }
    
   
}
