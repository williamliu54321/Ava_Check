import SwiftUI
import AVFoundation
import Photos

// MARK: - Models and ViewModels

enum CameraFlowState {
    case requestingPermission
    case takingPhoto
    case analyzing
    case showingResults
}

struct SkinConditionResult {
    let condition: String
    let confidence: Double
    let description: String
    let recommendations: [String]
}

class CameraViewModel: ObservableObject {
    @Published var flowState: CameraFlowState = .requestingPermission
    @Published var capturedImage: UIImage?
    @Published var analysisResult: SkinConditionResult?
    
    func requestCameraPermission() {
        // For preview safety
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            self.flowState = .takingPhoto
            return
        }
        
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                if granted {
                    self.flowState = .takingPhoto
                } else {
                    print("Camera permission denied")
                }
            }
        }
    }
    
    func photoTaken(image: UIImage) {
        self.capturedImage = image
        self.flowState = .analyzing
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.analyzeSkinCondition(image: image)
        }
    }
    
    func simulatePhotoForPreview() {
        let placeholderImage = UIImage(systemName: "person") ?? UIImage()
        self.photoTaken(image: placeholderImage)
    }
    
    private func analyzeSkinCondition(image: UIImage) {
        let mockResult = SkinConditionResult(
            condition: "Mild Eczema",
            confidence: 0.89,
            description: "Eczema is characterized by itchy, red, and inflamed skin. The affected areas may appear dry, thickened, or scaly.",
            recommendations: [
                "Apply moisturizer regularly",
                "Avoid known triggers",
                "Consider using a mild topical corticosteroid",
                "Consult with a dermatologist for personalized treatment"
            ]
        )
        
        DispatchQueue.main.async {
            self.analysisResult = mockResult
            self.flowState = .showingResults
        }
    }
    
    func restart() {
        self.flowState = .takingPhoto
        self.capturedImage = nil
        self.analysisResult = nil
    }
}

// MARK: - Views

struct CameraView: View {
    @StateObject private var viewModel = CameraViewModel()
    
    var body: some View {
        ZStack {
            contentBasedOnState
        }
        .onAppear {
            if viewModel.flowState == .requestingPermission {
                viewModel.requestCameraPermission()
            }
        }
    }
    
    @ViewBuilder
    private var contentBasedOnState: some View {
        switch viewModel.flowState {
        case .requestingPermission:
            PermissionRequestView(viewModel: viewModel)
        case .takingPhoto:
            CameraPreviewView(viewModel: viewModel)
        case .analyzing:
            AnalyzingView(image: viewModel.capturedImage)
        case .showingResults:
            ResultsView(viewModel: viewModel)
        }
    }
}

struct PermissionRequestView: View {
    @ObservedObject var viewModel: CameraViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "camera.fill")
                .font(.system(size: 72))
                .foregroundColor(.blue)
            
            Text("Camera Access Needed")
                .font(.title)
                .fontWeight(.bold)
            
            Text("This app needs access to your camera to analyze skin conditions. Your photos are processed securely and not stored permanently.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {
                viewModel.requestCameraPermission()
            }) {
                Text("Allow Camera Access")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Rectangle().fill(Color.blue))
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct CameraPreviewView: View {
    @ObservedObject var viewModel: CameraViewModel
    @State private var showCameraSheet = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Take a clear photo of the affected skin area")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Image(systemName: "camera.viewfinder")
                .font(.system(size: 80))
                .foregroundColor(.blue)
                .padding()
            
            Button(action: {
                if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
                    viewModel.simulatePhotoForPreview()
                } else {
                    showCameraSheet = true
                }
            }) {
                Text("Open Camera")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200)
                    .background(Rectangle().fill(Color.blue))
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showCameraSheet) {
                SafeImagePicker(selectedImage: { image in
                    viewModel.photoTaken(image: image)
                })
            }
        }
    }
}

struct SafeImagePicker: UIViewControllerRepresentable {
    let selectedImage: (UIImage) -> Void
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(selectedImage: selectedImage)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let selectedImage: (UIImage) -> Void
        
        init(selectedImage: @escaping (UIImage) -> Void) {
            self.selectedImage = selectedImage
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                selectedImage(image)
            }
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

struct AnalyzingView: View {
    let image: UIImage?
    
    var body: some View {
        VStack(spacing: 25) {
            if let unwrappedImage = image {
                Image(uiImage: unwrappedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(12)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .foregroundColor(.gray)
                    .opacity(0.5)
            }
            
            Text("Analyzing skin condition...")
                .font(.headline)
            
            ProgressView()
                .scaleEffect(1.5)
            
            Text("Our AI is examining the image for potential skin conditions")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
    }
}

struct ResultsView: View {
    @ObservedObject var viewModel: CameraViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                imageSection
                
                if let result = viewModel.analysisResult {
                    resultSection(result)
                }
                
                actionButton
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private var imageSection: some View {
        if let image = viewModel.capturedImage {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 250)
                .cornerRadius(12)
                .padding(.bottom)
        }
    }
    
    private func resultSection(_ result: SkinConditionResult) -> some View {
        Group {
            HStack {
                
                Text(result.condition)
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("\(Int(result.confidence * 100))% confidence")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            }
            Text("DISCLAIMER: This is not a medical diagnosis. Always consult with a qualified healthcare professional.")
                .font(.caption)
                .foregroundColor(.secondary)

            
            
            Text("Description")
                .font(.headline)
                .padding(.top)
            
            Text(result.description)
                .padding(.bottom)
            
            Text("Recommendations")
                .font(.headline)
            
            ForEach(result.recommendations, id: \.self) { recommendation in
                HStack(alignment: .top) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .padding(.top, 2)
                    
                    Text(recommendation)
                }
                .padding(.vertical, 4)
            }
            
            Divider()
                .padding(.vertical)
            
        }
    }
    
    private var actionButton: some View {
        Button(action: {
            viewModel.restart()
        }) {
            Text("Take Another Photo")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Rectangle().fill(Color.blue))
                .cornerRadius(10)
        }
        .padding(.top)
    }
}

struct CameraFlow: View {
    var body: some View {
        NavigationView {
            CameraView()
                .navigationBarTitle("Skin Analysis", displayMode: .inline)
        }
    }
}

// MARK: - Preview

struct CameraFlow_Previews: PreviewProvider {
    static var previews: some View {
        CameraFlow()
    }
}
