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
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.18, green: 0.8, blue: 0.8),
                                    Color(red: 0.4, green: 0.65, blue: 0.9)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .ignoresSafeArea())
                } else {
                    OnboardingView()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.18, green: 0.8, blue: 0.8),
                                    Color(red: 0.4, green: 0.65, blue: 0.9)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .ignoresSafeArea())
                }
            }
        }
    }
