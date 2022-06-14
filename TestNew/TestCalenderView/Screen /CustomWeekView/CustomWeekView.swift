//
//  CustomWeekView.swift
//  TestNew
//
//  Created by Kavindu Dissanayake on 2022-06-13.
//

import UIKit
import JZCalendarWeekView


class CustomWeekView: JZBaseWeekView {

    override func registerViewClasses() {
        super.registerViewClasses()
       
        
        //event cell
        self.collectionView.register(UINib(nibName: EventCell.className, bundle: nil), forCellWithReuseIdentifier: EventCell.className)


        //for grid line 
        self.flowLayout.register(BlackGridLine.self, forDecorationViewOfKind: JZDecorationViewKinds.verticalGridline)
        self.flowLayout.register(BlackGridLine.self, forDecorationViewOfKind: JZDecorationViewKinds.horizontalGridline)
        
         
        
        self.collectionView.register(HourRowHeader.self, forSupplementaryViewOfKind: JZSupplementaryViewKinds.rowHeader, withReuseIdentifier: HourRowHeader.className)
        
        self.collectionView.register(CurrentTimelineAll.self, forSupplementaryViewOfKind: JZSupplementaryViewKinds.currentTimeline, withReuseIdentifier: CurrentTimelineAll.className)
        

        
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let date = flowLayout.dateForColumnHeader(at: indexPath)
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.className, for: indexPath) as? EventCell,
            let event = allEventsBySection[date]?[indexPath.row] as? DefaultEvent {
            cell.configureCell(event: event)
            
            return cell
        }
        preconditionFailure("EventCell and DefaultEvent should be casted")
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == JZSupplementaryViewKinds.rowHeader {
            if let rowHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HourRowHeader.className, for: indexPath) as? HourRowHeader {
                rowHeader.updateView(date: flowLayout.timeForRowHeader(at: indexPath))
                return rowHeader
            }
            preconditionFailure("HourRowHeader should be casted")
        } else if kind == JZSupplementaryViewKinds.currentTimeline {
            guard let currentTimeline = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CurrentTimelineAll.className, for: indexPath) as? CurrentTimelineAll else {
                preconditionFailure("CurrentTimelineAll should be casted")
            }
            let isToday = Calendar.current.isDateInToday(flowLayout.dateForColumnHeader(at: indexPath))
            currentTimeline.updateView(needShowBallView: isToday)
            return currentTimeline
        }
        return super.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
    
    
}

