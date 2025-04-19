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
        
            .background(
                LinearGradient(
                    
                    gradient: Gradient(colors: [Color.LagoonGreen,Color.MossYellow]),
                
                startPoint: .top,
                
                endPoint: .bottom
                
            )
)
            .foregroundColor(.black)
            .clipShape(Capsule())
            .padding(.horizontal, 40)
        }
    }


#Preview {
    ButtonView(title: "Get Started", image: "play.fill")
}
