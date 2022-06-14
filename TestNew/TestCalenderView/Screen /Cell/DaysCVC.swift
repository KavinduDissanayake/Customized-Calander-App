//
//  File.swift
//  TestNew
//
//  Created by Kavindu Dissanayake on 2022-06-14.
//


import UIKit

class DaysCVC: UICollectionViewCell {
    //MARK: outlets
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var dayNumberLbl: UILabel!
    @IBOutlet weak var dayNumberView: UIView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var cellBackGround: UIView!
    
    
    var date:String = ""
    
    //MARK: lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // view border
        self.contentView.layer.cornerRadius = 11.0
        self.contentView.layer.borderWidth = 0.5
        //inner view
        self.dayNumberView.layer.cornerRadius = 8.0
        
        self.cellBackGround.backgroundColor = UIColor.clear
        
    }
    
    
    func configCell(date:String,selectedDate:String){
        self.date = date
        dayLbl.text = formatDate(date:date, dateFormat: "EE")
        dayNumberLbl.text = formatDate(date:date, dateFormat: "dd")
        
       
        
        if  date ==  selectedDate {
            cellBackGround.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.5215686275, blue: 0.231372549, alpha: 1)
        }else{
            cellBackGround.backgroundColor = UIColor.clear
        }
        
        checkCurrentDate()
    }
    
    func checkCurrentDate(){
        //check current Date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyy"
        let now = Date()
        let dateString = formatter.string(from:now)
        

        
        print("---------------❤️❤️\(date)")
//        print("\n\(date)")
        
        if dateString == date {
            cellBackGround.backgroundColor = UIColor(named: "Red")
        }
        
    }
    
    func addColor(){
        cellBackGround.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.5215686275, blue: 0.231372549, alpha: 1)
    }
    
    func removeColor(){
        cellBackGround.backgroundColor = UIColor.clear
    }
    
    
    func reDrawCurrentDate(){
        //check current Date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyy"
        let now = Date()
        let dateString = formatter.string(from:now)
        

        
//        print(dateString)
        print("❤️❤️❤️\n\(date)")
        
        if dateString == date {
            cellBackGround.backgroundColor = .red
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

}
