//
//  PickerViewModel.swift
//  iosApp
//
//  Created by Sean Howard on 12/04/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

class PickerViewModel: ObservableObject {
    
    private static let changeValue: CGFloat = 50.0
    
    var xOffset: CGFloat = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    func increment() {
        xOffset += Self.changeValue
    }
    
    func decrement() {
        xOffset -= Self.changeValue
    }
}
