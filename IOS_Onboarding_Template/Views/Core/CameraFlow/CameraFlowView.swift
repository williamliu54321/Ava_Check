import SwiftUI
import AVFoundation

// MARK: - Main App Flow View
/// Manages the entire camera flow and state transitions
struct CameraFlowView: View {
    // View model to manage the application state and logic
    @StateObject private var viewModel = CameraViewModel()
    
    var body: some View {
        ZStack {
            // Dynamically render view based on current application state
            contentBasedOnState
        }
        .onAppear {
            // Request camera permission if needed when view appears
            if viewModel.flowState == .requestingPermission {
                viewModel.requestCameraPermission()
            }
        }
    }
    
    /// Renders different views based on the current application state
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
        case .error(let message):
            ErrorView(message: message, viewModel: viewModel)
        }
    }
}

// MARK: - Image Picker
/// Handles camera image selection using UIKit's UIImagePickerController
struct ImagePicker: UIViewControllerRepresentable {
    // Closure to handle selected image
    let selectedImage: (UIImage) -> Void
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(selectedImage: selectedImage)
    }
    
    /// Coordinator to handle image picker delegate methods
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let selectedImage: (UIImage) -> Void
        
        init(selectedImage: @escaping (UIImage) -> Void) {
            self.selectedImage = selectedImage
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // Extract and process selected image
            if let image = info[.originalImage] as? UIImage {
                selectedImage(image)
            }
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            // Dismiss picker if canceled
            picker.dismiss(animated: true)
        }
    }
}

// MARK: - Camera Permission Request View
/// View for requesting camera access permissions
struct PermissionRequestView: View {
    @ObservedObject var viewModel: CameraViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            // Camera icon
            Image(systemName: "camera.fill")
                .font(.system(size: 72))
                .foregroundColor(.blue)
            
            // Title
            Text("Camera Access Needed")
                .font(.title)
                .fontWeight(.bold)
            
            // Description
            Text("This app needs access to your camera to analyze skin conditions.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            // Permission request button
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

// MARK: - Camera Preview View
/// View for capturing a photo of the skin condition
struct CameraPreviewView: View {
    @ObservedObject var viewModel: CameraViewModel
    @State private var showCameraSheet = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Instruction text
            Text("Take a clear photo of the affected skin area")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            // Camera viewfinder icon
            Image(systemName: "camera.viewfinder")
                .font(.system(size: 80))
                .foregroundColor(.blue)
                .padding()
            
            // Open camera button
            Button(action: {
                showCameraSheet = true
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
                // Present image picker
                ImagePicker(selectedImage: { image in
                    viewModel.photoTaken(image: image)
                })
            }
        }
    }
}

// MARK: - Analyzing View
/// View shown while image is being processed
struct AnalyzingView: View {
    let image: UIImage?
    
    var body: some View {
        VStack(spacing: 25) {
            // Display captured image
            if let unwrappedImage = image {
                Image(uiImage: unwrappedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(12)
            }
            
            // Analysis progress text
            Text("Analyzing skin condition...")
                .font(.headline)
            
            // Loading indicator
            ProgressView()
                .scaleEffect(1.5)
        }
        .padding()
    }
}

// MARK: - Results View
/// View to display diagnosis results
struct ResultsView: View {
    @ObservedObject var viewModel: CameraViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Captured image
                if let image = viewModel.capturedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 250)
                        .cornerRadius(12)
                        .padding(.bottom)
                }
                
                // Results title
                Text("AI Analysis Results")
                    .font(.title)
                    .fontWeight(.bold)
                
                // Disclaimer
                Text("DISCLAIMER: This is not a medical diagnosis. Always consult with a qualified healthcare professional.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                // Diagnosis text
                Text(viewModel.diagnosisText)
                    .padding(.vertical)
                
                // Retake photo button
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
            .padding()
        }
    }
}

// MARK: - Error View
/// View to display errors during the process
struct ErrorView: View {
    let message: String
    @ObservedObject var viewModel: CameraViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            // Error icon
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 72))
                .foregroundColor(.orange)
            
            // Error title
            Text("Error")
                .font(.title)
                .fontWeight(.bold)
            
            // Error message
            Text(message)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            // Try again button
            Button(action: {
                viewModel.restart()
            }) {
                Text("Try Again")
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

// MARK: - Entry Point
/// Main entry point for the camera flow
struct CameraFlow: View {
    var body: some View {
        NavigationView {
            CameraFlowView()
                .navigationBarTitle("Skin Analysis", displayMode: .inline)
        }
    }
}

#Preview {
    CameraFlowView()
}
