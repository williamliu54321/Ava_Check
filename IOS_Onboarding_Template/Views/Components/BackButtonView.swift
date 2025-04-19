//
//  BackButtonView.swift
//  IOS_Onboarding_Template
//
//  Created by William Liu on 2025-04-18.
//

import SwiftUI

struct BackButtonView: View {
    
    
    var body: some View {
        Image(systemName: "arrow.left")
            .font(.system(size: 24))  // Increased font size
            .foregroundColor(.white)
            .padding(20)  // Increased padding all around
    }
}

#Preview {
    BackButtonView()
}
