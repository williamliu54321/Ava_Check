//
//  BackgroundColorView.swift
//  IOS_Onboarding_Template
//
//  Created by William Liu on 2025-04-19.
//



import SwiftUI

struct MainColorView: View {
    
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.18, green: 0.8, blue: 0.8),
                Color(red: 0.4, green: 0.65, blue: 0.9)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()

    }
}

#Preview {
    MainColorView()
}
