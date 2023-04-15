//
//  SelectedViewKey.swift
//  CoRun
//
//  Created by Marselus Richard on 16/04/23.
//

import Foundation
import SwiftUI

///Store currently selected displayed view
private struct SelectedViewKey:EnvironmentKey{
    static let defaultValue:Binding<ViewList> = .constant(ViewList.home)
}

extension EnvironmentValues{
    var selectedView: Binding<ViewList>{
        get { self[SelectedViewKey.self] }
        set { self[SelectedViewKey.self] = newValue }
    }
}

enum ViewList{
    case splash
    case assessment
    case healthPermission
    case home
//    case profile
//    case trainee
}
