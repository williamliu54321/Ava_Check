//
//  ProgressBarView.swift
//  IOS_Onboarding_Template
//
//  Created by William Liu on 2025-04-17.
//

import SwiftUI

struct ProgressBarView: View {
    let totalSteps: Int
    let currentStep: Int
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 8) {
                ForEach(0..<totalSteps, id: \.self) { step in
                    Rectangle()
                        .fill(step <= currentStep ? Color.blue : Color.gray.opacity(0.3))
                        .frame(height: 4)
                }
            }
            .frame(width: geometry.size.width)
        }
        .frame(height: 4) // Add this line to limit the height
        .padding(.horizontal)
    }
}
