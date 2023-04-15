//
//  SelectedDateEnvironment.swift
//  CoRun
//
//  Created by Marselus Richard on 12/04/23.
//

import SwiftUI

///Store currently selected date for calender view
private struct SelectedDateKey:EnvironmentKey{
    static let defaultValue:Binding<Date> = .constant(Date.now)
}

extension EnvironmentValues {
    var selectedDate: Binding<Date> {
        get { self[SelectedDateKey.self] }
        set { self[SelectedDateKey.self] = newValue }
    }
}

//extension View {
//    func updateDate(_ date: Binding<Date>) -> some View {
//        environment(\.selectedDate , date)
//    }
//}
