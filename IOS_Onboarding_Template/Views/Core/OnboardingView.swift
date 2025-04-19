import SwiftUI

struct OnboardingView: View {
    @State private var currentStep = 0
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    private let totalSteps = 9
    
    var body: some View {
        ZStack {
            MainColorView()
            VStack(spacing: 0) {
                
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
            
            Image(systemName: "faceid")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .foregroundColor(.white)
                .padding(.bottom, 40)
            
            VStack(spacing: 8) {
                Text("Welcome to")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Ava Check")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .padding()
            
            Text("Advanced AI analysis of your skin condition")
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
            
            Button {
                currentStep = 1
            } label: {
                ButtonView(title: "Get Started", image: "arrow.right.circle.fill")
            }
            .padding(.bottom, 50)
        }
    }
}


struct OnboardingPage2: View {
    @Binding var currentStep: Int
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "camera.viewfinder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .foregroundColor(.white)
                .padding(.bottom, 40)
            
            VStack(spacing: 8) {
                Text("Start Scanning")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Your Skin")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .padding()
            
            Spacer()
            
            Text("Ava Check may contain errors or inaccuracies. It is not a substitute for professional medical advice. Please consult a healthcare provider for any health concerns")
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
                .padding(.bottom, 40)
                .padding(.horizontal,40)
            
                            
                Button {
                    currentStep = 2
                } label: {
                    ButtonView(title: "Scan", image: "arrow.right.circle.fill")
                }
            NavigationLink(destination: CameraFlow()) {
                Text("Analyze Skin")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            }
            .padding(.bottom, 50)
        }
    }

struct OnboardingPage3: View {
    @Binding var currentStep: Int
    @State private var showTermsAndConditions = false
    @State private var showPrivacyPolicy = false
    @StateObject private var payments = PaymentManager.shared
    @State private var selectedOption: SubscriptionOption = .monthly
    
    enum SubscriptionOption {
        case monthly, yearly
    }
    
    var body: some View {
        VStack {
            
            ZStack {
                Image("Arm")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                    //.blur(radius: 10)
                    .blur(radius: 2)
                    //.opacity(0.5)
                    .opacity(0.6)
                    .clipped()
                    .mask(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: .black.opacity(0), location: 0),
                                .init(color: .black, location: 0.1),
                                .init(color: .black, location: 0.9),
                                .init(color: .black.opacity(0), location: 1)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )

                
                VStack(spacing: 16) {
                    HStack {
                        Button {
                            currentStep = 1
                        } label: {
                            BackButtonView()
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    Spacer()

                    Text("Unlock Premium")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Get unlimited access to all features")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                    
                    // Feature list
                    VStack(alignment: .leading, spacing: 12) {
                        FeatureRow(icon: "checkmark.circle.fill", text: "Unlimited skin scans")
                        FeatureRow(icon: "checkmark.circle.fill", text: "Advanced skin analysis")
                        FeatureRow(icon: "checkmark.circle.fill", text: "Cancel any time")
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
            
            // Subscription options
            VStack(spacing: 16) {
                // Monthly option
                SubscriptionOptionView(
                    isSelected: selectedOption == .monthly,
                    title: "Monthly",
                    price: "$6.99",
                    description: "Billed monthly",
                    onTap: { selectedOption = .monthly }
                )
                
                // Yearly option with discount
                SubscriptionOptionView(
                    isSelected: selectedOption == .yearly,
                    title: "Yearly",
                    price: "$39.99",
                    description: "Save 52% compared to monthly",
                    isBestValue: true,
                    onTap: { selectedOption = .yearly }
                )
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 10)

            // Terms and privacy text
            Text("By continuing, you agree to our Terms and Privacy Policy. Subscription automatically renews unless auto-renew is turned off.")
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .padding(.bottom, 10)
             //



            // Subscribe button
            Button {

                if selectedOption == .monthly {
                    payments.buyMonthly()
                } else {
                    payments.buyYearly()
                }
                // Move to next screen when purchase is complete
                if payments.isSubscribed {
                    currentStep = 3
                }
            } label: {
                ButtonView(title: "Subscribe Now", image: "lock.open.fill")
            }
            .padding(.bottom, 5)
            
            // Restore purchases button
            HStack {
                Button {
                    payments.restore()
                    // Check if subscription was restored
                    if payments.isSubscribed {
                        currentStep = 3
                    }
                } label: {
                    Text("Restore Purchases")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Button {
                    showTermsAndConditions = true
                } label: {
                    Text("Terms and Conditions")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Button {
                    showPrivacyPolicy = true
                } label: {
                    Text("Privacy Policy")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .padding(.bottom, 20)
        }
        .onAppear {
            // If already subscribed, skip to next page
            if payments.isSubscribed {
                currentStep = 3
            }
        }
        .sheet(isPresented: $showPrivacyPolicy) {
            PrivacyPolicyView(isPresented: $showPrivacyPolicy)
        }
        .sheet(isPresented: $showTermsAndConditions) {
            TermsAndConditionsView(isPresented: $showTermsAndConditions)
        }
    }
}
// Feature list item
struct FeatureRow: View {
    var icon: String
    var text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.white)
            
            Text(text)
                .foregroundColor(.white)
        }
    }
}
// Subscription option view
struct SubscriptionOptionView: View {
    var isSelected: Bool
    var title: String
    var price: String
    var description: String
    var isBestValue: Bool = false
    var onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        if isBestValue {
                            Text("BEST VALUE")
                                .font(.system(size: 10, weight: .bold))
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.yellow)
                                .foregroundColor(.black)
                                .cornerRadius(4)
                        }
                    }
                    
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Spacer()
                
                Text(price)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .padding()
            .background(isSelected ? Color.white.opacity(0.3) : Color.white.opacity(0.15))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.white : Color.clear, lineWidth: 2)
            )
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
