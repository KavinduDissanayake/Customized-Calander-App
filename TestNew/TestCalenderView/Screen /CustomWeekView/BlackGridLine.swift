//
//  BlackGridLine.swift
//  TestNew
//
//  Created by Kavindu Dissanayake on 2022-06-13.
//

import UIKit

/// Custom Decoration View
class BlackGridLine: UICollectionReusableView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
