//
//  IOS_Onboarding_TemplateApp.swift
//  IOS_Onboarding_Template
//
//  Created by William Liu on 2025-04-15.
//



import SwiftUI

@main
struct IOS_Onboarding_TemplateApp: App {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    
    var body: some Scene {
        WindowGroup {                
                // Conditional view based on onboarding status
                if hasSeenOnboarding {
                    HomeScreenView()
                        .background(Color.blue) // Your background color
                } else {
                    OnboardingView()
                        .background(Color.blue) // Your background color
                }
            }
        }
    }
