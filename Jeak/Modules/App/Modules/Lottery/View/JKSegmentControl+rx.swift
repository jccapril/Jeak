//
//  JKSegmentControl+rx.swift
//  App
//
//  Created by Flutter on 2021/3/17.
//

import UICore

extension Reactive where Base: JKSegmentControl {

    
    internal var selectedIndex: ControlProperty<Int> {
         value
    }
    
    internal var value: ControlProperty<Int> {
        return base.rx.controlProperty (
            editingEvents: [.valueChanged],
            getter:{ segmentedControl in
                segmentedControl.selectedIndex
            } ,
            setter: { segmentedControl, value in
                segmentedControl.selectedIndex = value
            }
        )

    }
   
}


