import SwiftUI

struct CheckBoxView: View {
    @State private var ticked: Bool = false
    var text: String

    var body: some View {
        Button(action: {
            ticked.toggle()
        }) {
            HStack {
                Text(text)
                    .font(.system(size: 18, weight: .medium))

                Spacer()

                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(ticked ? Color.MossYellow : Color.SandYellow, lineWidth: 3)
                        .frame(width: 26, height: 26)

                    if ticked {
                        ZStack {
                            // Gradient background
                            RoundedRectangle(cornerRadius: 5)
                                .fill(
                                    LinearGradient(
                                        colors: [Color.MossYellow, Color.SandYellow],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )

                            // Checkmark icon
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .bold))
                        }
                        .frame(width: 26, height: 26)
                    }

                }
            }
            .padding(.horizontal)
            .frame(width: 375, height: 46)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(ticked ? Color.MossYellow : Color.SandYellow, lineWidth: 3)
            )
        }
        .buttonStyle(PlainButtonStyle()) // Removes default button look
    }
}

#Preview {
    CheckBoxView(text: "😊 whatever")
}
