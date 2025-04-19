import SwiftUI

// MARK: - Terms and Conditions Main View
struct TermsAndConditionsView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderBannerView(title: "Terms and conditions", isPresented: $isPresented)
            AppHeaderView(appName: "AvaCheck")
            TermsContentView()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

// MARK: - Header Banner Component
struct HeaderBannerView: View {
    var title: String
    @Binding var isPresented: Bool
    
    var body: some View {
        HStack {
            Text(title)
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
        .background(Color(red: 0.4, green: 0.75, blue: 0.85))
    }
}

// MARK: - App Header Component
struct AppHeaderView: View {
    var appName: String
    
    var body: some View {
        HStack {
            HStack {
                ZStack {
                    Circle()
                        .fill(Color(red: 0.4, green: 0.75, blue: 0.85))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: "key.fill")
                        .foregroundColor(.white)
                }
                
                Text(appName)
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
    }
}

// MARK: - Terms Section Component
struct TermsSectionView: View {
    var number: String
    var title: String
    var content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Text("\(number).")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.3))
                
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.3))
            }
            
            Text(content)
                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
        }
        .padding(.horizontal)
    }
}

// MARK: - Footer Component
struct TermsFooterView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Text("app name" )
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.3))
            
            Text("Copyright ©2024 Company name. All rights reserved.")
                .font(.footnote)
                .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
            
            // Social media icons
            HStack(spacing: 50) {
                Image(systemName: "f.square.fill")
                    .font(.title)
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                
                Image(systemName: "camera.fill")
                    .font(.title)
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                
                Image(systemName: "music.note")
                    .font(.title)
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
            }
            
            Divider()
                .padding(.vertical, 10)
            
            // Links
            VStack(spacing: 15) {
                Text("Support")
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                
                Text("Privacy")
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                
                Text("Terms of Use")
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
            }
            .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 40)
    }
}

// MARK: - Main Terms Content
struct TermsContentView: View {
    let termsData: [(number: String, title: String, content: String)] = [
        ("1", "Acceptance of Terms",
         "By accessing or using AvaCheck (Skin Analysis Application), you agree to comply with and be bound by these Terms of Use (\"Terms\"). If these Terms are not acceptable to you, please refrain from utilizing AvaCheck."),
        
        ("2", "Beta Status Notice",
         "AvaCheck is presently in beta testing phase. While we aim to provide precise and trustworthy information, AvaCheck should not be considered a replacement for qualified dermatological advice, diagnosis, or treatment. By accessing AvaCheck, you acknowledge its developmental status and potential for containing errors or inaccuracies."),
        
        ("3", "Informational Purposes Only",
         "The details provided through AvaCheck are exclusively for informational purposes and are not intended as medical recommendations. Always consult with a qualified healthcare practitioner regarding any skin-related concerns. Never ignore or delay obtaining professional medical advice because of information accessed through AvaCheck."),
        
        ("4", "Usage Liability",
         "Your engagement with AvaCheck is at your own risk. Avacheck Apps LLC, its affiliates, and partners disclaim responsibility for any harm or damage arising from your use of AvaCheck."),
        
        ("5", "Data Usage Practices",
         "We collect and anonymize information during the beta phase to enhance AvaCheck's effectiveness and stability. By using AvaCheck, you consent to the gathering and utilization of your data as described in our Privacy Policy."),
        
        ("6", "User Contributions",
         "Your suggestions are important to us. By submitting feedback, you provide Avacheck Apps LLC with a non-exclusive, royalty-free, global, perpetual authorization to employ, replicate, adapt, and distribute the feedback in any format."),
        
        ("7", "Ownership Rights",
         "All materials, functionalities, and capabilities of AvaCheck, including but not limited to text, imagery, logos, and software code, are the exclusive property of Avacheck Apps LLC and are safeguarded by copyright, trademark, and additional intellectual property regulations."),
        
        ("8", "Terms Adjustments",
         "We maintain the right to revise these Terms at our discretion. Any modifications will take effect immediately upon publication. Your continued engagement with AvaCheck following the posting of changes signifies your acceptance of those revisions."),
        
        ("9", "Access Suspension",
         "We retain the authority to discontinue or restrict your access to AvaCheck at any point, without prior notification, for behavior that we determine violates these Terms or poses a risk to other users."),
        
        ("10", "Responsibility Limitations",
         "To the maximum extent allowable by law, Avacheck Apps LLC shall not assume liability for any consequential, incidental, particular, resulting, or exemplary damages, or any forfeiture of earnings or income, whether sustained directly or indirectly, or any loss of information, utility, goodwill, or other intangible assets, arising from (a) your access or inability to access AvaCheck; (b) any unauthorized infiltration or use of our systems and/or any personal information contained therein; (c) any disruption or cessation of transmission to or from our services; (d) any malware, viruses, trojans, or similar that might be transmitted to or through our services by any external party; (e) any inaccuracies or oversights in any content or for any damages incurred as a consequence of your use of any content published, emailed, transmitted, or otherwise made accessible through AvaCheck; and/or (f) the defamatory, objectionable, or unlawful behavior of any third party."),
        
        ("11", "Jurisdictional Framework",
         "These Terms are administered and interpreted in accordance with the laws of the Province of British Columbia, Canada, disregarding its conflict of law doctrines. Any legal dispute or process arising from these Terms will be adjudicated solely in the provincial or federal courts situated in British Columbia, and you hereby agree to submit to the personal jurisdiction and venue therein."),
        
        ("12", "Communication Details",
         "If you have inquiries regarding these Terms, please reach out to us at: Avacheck Apps LLC\nEmail: william@avacheck.ai\n\nBy engaging with AvaCheck, you confirm that you have reviewed, comprehended, and consented to be bound by these Terms of Use.")
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("AvaCheck Terms of Use")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.3))
                    .padding(.horizontal)
                
                // Dynamic Generation of Terms Sections
                ForEach(termsData, id: \.number) { term in
                    TermsSectionView(
                        number: term.number,
                        title: term.title,
                        content: term.content
                    )
                }
                
                // Footer
                TermsFooterView()
            }
            .padding(.vertical)
        }
        .background(Color(red: 0.98, green: 0.98, blue: 0.98))
    }
}

// MARK: - Implementation for showing the Terms and Conditions
struct ExampleTermsView: View {
    @State private var showTermsAndConditions = false
    
    var body: some View {
        ZStack {
            // Your main app content here
            VStack {
                Text("App Content")
                
                Button("Show Terms and Conditions") {
                    showTermsAndConditions = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            
            // Terms and Conditions Sheet
            if showTermsAndConditions {
                VStack {
                    Spacer()
                    
                    TermsAndConditionsView(isPresented: $showTermsAndConditions)
                        .frame(height: UIScreen.main.bounds.height * 0.9)
                        .transition(.move(edge: .bottom))
                        .animation(.spring())
                        .cornerRadius(16, corners: [.topLeft, .topRight])
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
                }
                .edgesIgnoringSafeArea(.all)
                .background(
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            showTermsAndConditions = false
                        }
                )
            }
        }
    }
}

// MARK: - Helper extension for rounded corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCornerShape(radius: radius, corners: corners))
    }
}

struct RoundedCornerShape: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// MARK: - Preview
struct TermsView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleTermsView()
    }
}
