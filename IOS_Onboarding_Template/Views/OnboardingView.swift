import SwiftUI

struct OnboardingView: View {
    @State private var currentStep = 0
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    private let totalSteps = 9
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea() // ✅ Full-screen blue background
            VStack(spacing: 0) {
                ProgressBarView(totalSteps: totalSteps, currentStep: currentStep)
                    .padding(.top)
                
                TabView(selection: $currentStep) {
                    OnboardingPage1(currentStep: $currentStep).tag(0)
                    OnboardingPage2(currentStep: $currentStep).tag(1)
                    OnboardingPage3(currentStep: $currentStep).tag(2)
                    OnboardingPage4(currentStep: $currentStep).tag(3)
                    OnboardingPage5(currentStep: $currentStep).tag(4)
                    OnboardingPage6(currentStep: $currentStep).tag(5)
                    OnboardingPage7(currentStep: $currentStep).tag(6)
                    OnboardingPage8(currentStep: $currentStep).tag(7)
                    OnboardingPage9(currentStep: $currentStep, onComplete: {
                        hasSeenOnboarding = true
                    }).tag(8)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
        }
    }
}


import SwiftUI

struct OnboardingPage1: View {
    @Binding var currentStep: Int
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Text("Discover destiny")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("in your hands")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .padding()
            
            Spacer()
            
            Button {
                currentStep = 1
            } label: {
                ButtonView(title: "Get Started", image: "play.fill")
            }
            .padding()
        }
    }
}

struct OnboardingPage2: View {
    @Binding var currentStep: Int
    
    var body: some View {
        VStack {
            // Back button at top
            HStack {
                Button {
                    currentStep = 0
                } label: {
                    BackButtonView()
                }
                Spacer()
            }
            
            Spacer()
            
            Text("Your goals")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("What are your goals?")
                .font(.title2)
                .padding()
            
            VStack(spacing: 16) {
                CheckBoxView(text: "😊 Understand myself and others better")
                CheckBoxView(text: "💕 Improve relationship with my partner")
                CheckBoxView(text: "📆 Receive daily insights and tips")
                CheckBoxView(text: "🔮 Be prepared for the future")
                CheckBoxView(text: "💘 Find my perfect match")
                CheckBoxView(text: "🤝 Check compatibility with others")
                CheckBoxView(text: "🧭 Get guidance and advice")
            }
            .padding()
            
            Spacer()
            
            Button {
                currentStep = 2
            } label: {
                ButtonView(title: "Continue", image: "arrow.right")
            }
            .padding()
        }
    }
}
struct OnboardingPage3: View {
    @Binding var currentStep: Int
    
    var body: some View {
        VStack {
            
            HStack {
                           Button {
                               currentStep = 1
                           } label: {
                               BackButtonView()
                           }
                           Spacer()
                       }
            
            Spacer()
            
            Text("Your interests")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("What interests you most in life")
                .font(.title2)
                .padding()
            
            VStack(spacing: 16) {
                CheckBoxView(text: "💕 Love & relationships")
                CheckBoxView(text: "💰 Career & finances")
                CheckBoxView(text: "🧘 Personal growth")
                CheckBoxView(text: "🌍 Life purpose & destiny")
                CheckBoxView(text: "🧠 Mental clarity & decisions")
                CheckBoxView(text: "👨‍👩‍👧‍👦 Family & connections")
            }
            .padding()
            
            Spacer()
            
            Button {
                currentStep = 3
            } label: {
                ButtonView(title: "Continue", image: "arrow.right")
            }
            .padding()
        }
    }
}


struct OnboardingPage4: View {
    @Binding var currentStep: Int
    @State private var name: String = ""
    
    var body: some View {
        VStack {
            HStack {
                           Button {
                               currentStep = 2
                           } label: {
                               BackButtonView()
                           }
                           Spacer()
                       }
            Spacer()
            
            // Profile clipboard icon
            Image(systemName: "person.crop.rectangle")
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .foregroundColor(Color(UIColor.brown))
            
            Spacer()
                .frame(height: 30)
            
            Text("What is your name?")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(.bottom, 20)
            
            // Text field with underline
            TextField("Name", text: $name)
                .font(.title)  // Increased to larger font size
                .foregroundColor(.white)
                .multilineTextAlignment(.center)  // Center the text
                .padding(.bottom, 8)
                .background(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white)
                        .offset(y: 15)
                )
                .padding(.horizontal, 40)
            Spacer()
            
            // Continue button
            Button {
                currentStep = 4
            } label: {
                ButtonView(title: "Next", image: "arrow.right")
            }
            .padding()
        }
    }
}

struct OnboardingPage5: View {
    @Binding var currentStep: Int
    @State private var selectedAge: Int = 25
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    currentStep = 3
                } label: {
                    BackButtonView()
                }
                Spacer()
            }
            
            Spacer()
            
            // Calendar with cake icon
            Image(systemName: "calendar.badge.clock")
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .foregroundColor(Color(UIColor.brown))
            
            Spacer()
                .frame(height: 30)
            
            Text("What is your Age?")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(.bottom, 20)
            
            // Age picker
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 120, height: 60)
                
                Picker("Age", selection: $selectedAge) {
                    ForEach(1...100, id: \.self) { age in
                        Text("\(age)")
                            .foregroundColor(.white)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 100, height: 100)
                .clipped()
            }
            
            Spacer()
            
            // Continue button
            Button {
                currentStep = 5
            } label: {
                ButtonView(title: "Continue", image: "arrow.right")
            }
            .padding()
        }
    }
}

struct OnboardingPage6: View {
    @Binding var currentStep: Int
    
    var body: some View {
        VStack {
            
            HStack {
                           Button {
                               currentStep = 4
                           } label: {
                               BackButtonView()
                           }
                           Spacer()
                       }
            
            Spacer()
            
            Text("What is your Gender?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("Select your gender")
                .font(.title2)
                .padding()
            
            VStack(spacing: 16) {
                CheckBoxView(text: "👨 Male")
                CheckBoxView(text: "👩 Female")
                CheckBoxView(text: "💎 Non-binary")
                CheckBoxView(text: "✨ Other")
            }
            .padding()
            
            Spacer()
            
            Button {
                currentStep = 6
            } label: {
                ButtonView(title: "Continue", image: "arrow.right")
            }
            .padding()
        }
    }
}

struct OnboardingPage7: View {
    @Binding var currentStep: Int
    @State private var rated: Bool = false
    @ObservedObject private var appServices = AppServices.shared
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    currentStep = 5
                } label: {
                    BackButtonView()
                }
                Spacer()
            }
            
            Spacer()
            
            Text("Leave a rating!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("We're a small team, so a rating goes a really long way!")
                .font(.callout)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.bottom, 40)
            
            Spacer()
            
            // Star rating image
            Image(systemName: "bubble.left.and.bubble.right")
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .overlay(
                    HStack(spacing: 8) {
                        ForEach(0..<5) { _ in
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                    .offset(y: 10)
                )
                .foregroundColor(Color(UIColor.brown))
                .padding(.bottom, 40)
            
            Spacer()
            
            Button {
                if rated {
                    currentStep = 7
                } else {
                    // Call the app review functionality
                    appServices.requestAppReview()
                    rated = true
                }
            } label: {
                ButtonView(title: rated ? "I rated!" : "Leave a rating!", image: rated ? "arrow.right" : "")
            }
            .padding()
        }
    }
}

struct OnboardingPage8: View {
    @Binding var currentStep: Int
    @State private var notificationsEnabled: Bool = false
    @ObservedObject private var appServices = AppServices.shared
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    currentStep = 6
                } label: {
                    BackButtonView()
                }
                Spacer()
            }
            
            Spacer()
            
            Text("Stay Updated!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Enable notifications to receive daily insights and important updates")
                .font(.callout)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.bottom, 40)
            
            Spacer()
            
            // Notification bell image
            Image(systemName: "bell.badge.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .foregroundColor(Color(UIColor.brown))
                .padding(.bottom, 40)
            
            Spacer()
            
            Button {
                if notificationsEnabled || appServices.notificationsAuthorized {
                    currentStep = 8
                } else {
                    // Request notification permission
                    appServices.requestNotificationPermission()
                    notificationsEnabled = true
                }
            } label: {
                ButtonView(title: (notificationsEnabled || appServices.notificationsAuthorized) ? "I Enabled!" : "Allow Notifications", image: (notificationsEnabled || appServices.notificationsAuthorized) ? "arrow.right" : "")
            }
            .padding()
        }
        .onAppear {
            // Check if notifications are already authorized
            appServices.checkNotificationAuthorizationStatus()
        }
    }
}

struct OnboardingPage9: View {
    @Binding var currentStep: Int
    var onComplete: () -> Void
    @ObservedObject private var appServices = AppServices.shared
    @State private var personalizationEnabled: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    currentStep = 7
                } label: {
                    BackButtonView()
                }
                Spacer()
            }
            
            Spacer()
            
            Text("Enhance Your Experience")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Allow personalized content for the best experience tailored to your needs")
                .font(.callout)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.bottom, 40)
            
            Spacer()
            
            // Personalization icon
            Image(systemName: "person.text.rectangle")
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .foregroundColor(Color(UIColor.brown))
                .padding(.bottom, 40)
            
            Spacer()
            
            Button {
                if personalizationEnabled || appServices.personalizationEnabled {
                    // Save setting and complete onboarding
                    appServices.setPersonalization(enabled: true)
                    onComplete()
                } else {
                    // Enable personalization
                    appServices.setPersonalization(enabled: true)
                    personalizationEnabled = true
                }
            } label: {
                ButtonView(title: (personalizationEnabled || appServices.personalizationEnabled) ? "Continue" : "Allow Personalization", image: (personalizationEnabled || appServices.personalizationEnabled) ? "checkmark" : "")
            }
            .padding()
        }
        .onAppear {
            // Check current personalization status
            personalizationEnabled = appServices.personalizationEnabled
        }
    }
}
#Preview {
    OnboardingView()
}
