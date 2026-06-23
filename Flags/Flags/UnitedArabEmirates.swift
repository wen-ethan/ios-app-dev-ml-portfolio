//
//  UnitedArabEmirates.swift
//  Flags
//
//  Created by 27 BGCC Loan Library on 6/23/26.
//

import SwiftUI

struct UnitedArabEmirates: View {
    var body: some View {
        HStack(spacing: 0) {
            Color.red
                .frame(width: 200)
            VStack(spacing: 0) {
                Color.green
                Color.white
                Color.black
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    UnitedArabEmirates()
}
