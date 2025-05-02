import SwiftUI

// MARK: - Privacy Policy Main View
struct PrivacyPolicyView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // Top Banner
            HStack {
                Text("Privacy policy")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(Color(red: 0.4, green: 0.75, blue: 0.85)) // Updated blue color
            
            // App Header
            HStack {
                HStack {
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.4, green: 0.75, blue: 0.85)) // Updated blue color
                            .frame(width: 40, height: 40)
                        
                        Image(systemName: "key.fill")
                            .foregroundColor(.white)
                    }
                    
                    Text("AvaCheck")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                Image(systemName: "line.horizontal.3")
                    .font(.title)
                    .foregroundColor(.black)
            }
            .padding()
            .background(Color.white)
            
            // Content
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    // Main Title
                    Text("AvaCheck User Support")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                        .padding(.horizontal)
                    
                    Divider()
                    
                    // Introduction Text
                    Text("Welcome to AvaCheck! This is a user support page to help you with any questions or concerns you may have about the app.")
                        .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    // Support Box
                    VStack(alignment: .leading, spacing: 5) {
                        HStack(spacing: 10) {
                            Image(systemName: "exclamationmark.triangle")
                                .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                            
                            Text("Email Support:")
                                .font(.headline)
                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                        }
                        
                        Text("For any questions or concerns, please email us at")
                            .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                        
                        Text("william@avacheck.ai")
                            .foregroundColor(Color(red: 0.4, green: 0.75, blue: 0.85))
                    }
                    .padding()
                    .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1)
                    )
                    .padding(.horizontal)
                    
                    // User Guide Box
                   
                
                    Spacer()
                    
                    // Footer
                    TermsFooterView()
                }
                .padding(.vertical)
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

// Example implementation for showing the Privacy Policy
struct PrivacyPolicyExampleView: View {
    @State private var showPrivacyPolicy = false
    
    var body: some View {
        ZStack {
            // Your main app content here
            VStack {
                Text("App Content")
                
                Button("Show Privacy Policy") {
                    showPrivacyPolicy = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            
            // Privacy Policy Sheet
            if showPrivacyPolicy {
                VStack {
                    Spacer()
                    
                    PrivacyPolicyView(isPresented: $showPrivacyPolicy)
                        .frame(height: UIScreen.main.bounds.height * 0.9)
                        .transition(.move(edge: .bottom))
                        .cornerRadius(16, corners: [.topLeft, .topRight])
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
                }
                .edgesIgnoringSafeArea(.all)
                .background(
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            showPrivacyPolicy = false
                        }
                )
            }
        }
    }
}



// Preview
struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyExampleView()
    }
}
