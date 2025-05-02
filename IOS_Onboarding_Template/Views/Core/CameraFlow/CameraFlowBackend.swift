import Foundation
import SwiftUI

func uploadImageToServer(_ imageData: Data, completion: @escaping (Result<String, Error>) -> Void) {
    guard let url = URL(string: "http://192.168.88.2:8000/diagnose") else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = imageData
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        // Check for any network errors
        if let networkError = error {
            completion(.failure(networkError))
            return
        }
        
        // Validate and convert response data
        guard let receivedData = data,
              let responseText = String(data: receivedData, encoding: .utf8) else {
            // Create a specific error if data conversion fails
            let conversionError = NSError(
                domain: "ImageUpload",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to process server response"]
            )
            completion(.failure(conversionError))
            return
        }
        
        // Successfully processed response
        completion(.success(responseText))
    }.resume()
}

