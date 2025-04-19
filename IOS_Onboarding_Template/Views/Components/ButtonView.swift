//
//  ButtonView.swift
//  IOS_Onboarding_Template
//
//  Created by William Liu on 2025-04-15.
//

import SwiftUI

struct ButtonView: View {
    var title: String
    var image: String

    var body: some View {
        HStack {
            Image(systemName: image)
            Text(title)
                .font(.system(size: 18, weight: .semibold, design: .default))
        }
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.25))
        .overlay(
            Capsule()
                .stroke(Color.white.opacity(0.4), lineWidth: 1)
        )
        .foregroundColor(.white)
        .clipShape(Capsule())
        .padding(.horizontal, 40)
    }
}

// Extension for preview (you can remove this part when using in your app)
struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            // Background gradient for preview
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.18, green: 0.8, blue: 0.8),
                    Color(red: 0.4, green: 0.65, blue: 0.9)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            ButtonView(title: "Get Started", image: "arrow.right.circle")
        }
    }
}
#Preview {
    ButtonView(title: "Get Started", image: "play.fill")
}
