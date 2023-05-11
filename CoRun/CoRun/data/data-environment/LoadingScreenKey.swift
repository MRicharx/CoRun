//
//  LoadingScreenKey.swift
//  CoRun
//
//  Created by Marselus Richard on 11/05/23.
//

import Foundation
import SwiftUI

//Store currently selected date for calender view
private struct LoadingScreenKey:EnvironmentKey{
    static let defaultValue:Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var onLoading: Binding<Bool>{
        get { self[LoadingScreenKey.self] }
        set { self[LoadingScreenKey.self] = newValue }
    }
}
