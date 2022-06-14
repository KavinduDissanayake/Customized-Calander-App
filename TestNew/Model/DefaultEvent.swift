//
//  DefaultEvent.swift
//  TestNew
//
//  Created by Kavindu Dissanayake on 2022-06-14.
//

import Foundation
import JZCalendarWeekView

class DefaultEvent: JZBaseEvent {

    var location: String
    var title: String

    init(id: String, title: String, startDate: Date, endDate: Date, location: String) {
        self.location = location
        self.title = title

        // If you want to have you custom uid, you can set the parent class's id with your uid or UUID().uuidString (In this case, we just use the base class id)
        super.init(id: id, startDate: startDate, endDate: endDate)
    }

    override func copy(with zone: NSZone?) -> Any {
        return DefaultEvent(id: id, title: title, startDate: startDate, endDate: endDate, location: location)
    }
}
