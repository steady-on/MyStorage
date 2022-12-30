//
//  Created by Roen White on 2022/11/22.
//

import Foundation

class LoadJSON {
    // MARK: class 내에서 발생하는 에러처리
    enum LoadJSONError: Error, LocalizedError {
        case invalidURL
        
        var errorDescription: String {
            switch self {
            case .invalidURL:
                return "invalid URL. Cannot convert String."
            }
        }
    }
    
    // MARK: - 매개변수로 받아온 url에 있는 JSON을 구조체로 decoding해서 리턴하는 메서드
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

    // MARK: - 매개변수로 받아온 url에 있는 String 타입으로 리턴. 데이터 확인용 메서드
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

