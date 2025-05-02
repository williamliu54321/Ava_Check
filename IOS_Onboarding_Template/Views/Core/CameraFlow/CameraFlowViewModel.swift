import SwiftUI
import AVFoundation

// State management enum for the app flow
enum CameraFlowState: Equatable {
    case requestingPermission  // Asking for camera access
    case takingPhoto           // Ready to take a photo
    case analyzing             // Processing the photo
    case showingResults        // Displaying diagnosis
    case error(String)         // Showing error message
    
    // Custom equality implementation for comparison
    static func == (lhs: CameraFlowState, rhs: CameraFlowState) -> Bool {
        switch (lhs, rhs) {
        case (.requestingPermission, .requestingPermission),
             (.takingPhoto, .takingPhoto),
             (.analyzing, .analyzing),
             (.showingResults, .showingResults):
            return true
        case (.error(let lhsMessage), .error(let rhsMessage)):
            return lhsMessage == rhsMessage
        default:
            return false
        }
    }
}

// Main view model that manages app state and business logic
class CameraViewModel: ObservableObject {
    @Published var flowState: CameraFlowState = .requestingPermission
    @Published var capturedImage: UIImage?
    @Published var diagnosisText: String = ""
    
    // Function to check camera permissions
    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                if granted {
                    self.flowState = .takingPhoto
                } else {
                    self.flowState = .error("Camera permission denied")
                }
            }
        }
    }
    
    // Function called when a photo is taken
    func photoTaken(image: UIImage) {
        self.capturedImage = image
        self.flowState = .analyzing
        
        // Convert image to JPEG data
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            uploadImageToServer(imageData)
        } else {
            self.flowState = .error("Failed to process image")
        }
    }
    
    // Function to upload image to server
    private func uploadImageToServer(_ imageData: Data) {
        // Create URL request
        guard let url = URL(string: "http://192.168.88.2:8000/diagnose") else {
            self.flowState = .error("Invalid API URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Create form data
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        // Send request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.flowState = .error(error.localizedDescription)
                    return
                }
                
                if let data = data, let responseText = String(data: data, encoding: .utf8) {
                    self.diagnosisText = responseText
                    self.flowState = .showingResults
                } else {
                    self.flowState = .error("No response received")
                }
            }
        }.resume()
    }
    
    // Function to restart the flow
    func restart() {
        self.flowState = .takingPhoto
        self.capturedImage = nil
        self.diagnosisText = ""
    }
}
