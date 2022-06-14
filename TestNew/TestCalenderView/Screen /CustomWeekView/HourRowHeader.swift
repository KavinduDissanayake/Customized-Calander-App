//
//  HourRowHeader.swift
//  TestNew
//
//  Created by Kavindu Dissanayake on 2022-06-13.
//

import UIKit
import JZCalendarWeekView

/// Custom Supplementary Hour Row Header View (No need to subclass, but **must** register and viewForSupplementaryElementOfKind)
class HourRowHeader: JZRowHeader {

    override func setupBasic() {
        // different dateFormat
        dateFormatter.dateFormat = "HH:mm aa"
        lblTime.textColor = UIColor(named: "TextColor")
        lblTime.font = UIFont.systemFont(ofSize: 12)
    }

}
