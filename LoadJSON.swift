//
//  Created by Roen White on 2022/11/22.
//

import Foundation

class LoadJSON {
    enum LoadJSONError: Error, LocalizedError {
        case invalidURL
        
        var errorDescription: String {
            switch self {
            case .invalidURL:
                return "invalid URL. Cannot convert String."
            }
        }
    }
    
    func loadWebJSON<T: Decodable>(_ url: String) async throws -> T {
        guard let url = URL(string: url) else {
            print(LoadJSONError.invalidURL.errorDescription)
            throw LoadJSONError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            fatalError("Unable to parse data : \(error)")
        }
    }

    func loadWebJSONtoString(_ url: String) async throws -> String {
        guard let url = URL(string: url) else {
            print(LoadJSONError.invalidURL.errorDescription)
            throw LoadJSONError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return String(data: data, encoding: .utf8)!
        } catch {
            fatalError("Unable to parse data : \(error)")
        }
    }
}

