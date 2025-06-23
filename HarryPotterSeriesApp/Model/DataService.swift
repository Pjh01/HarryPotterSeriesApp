
import Foundation

enum DataError: Error, LocalizedError {
    case fileNotFound
    case parsingFailed
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "데이터 파일을 찾을 수 없습니다."
        case .parsingFailed:
            return "데이터를 불러오는 데 실패했습니다."
        }
    }
}

class DataService {
    
    func loadBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            completion(.failure(DataError.fileNotFound))
            return
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted({
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter
        }())
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let bookResponse = try decoder.decode(BookResponse.self, from: data)
            let books = bookResponse.data.map { $0.attributes }
            completion(.success(books))
        } catch {
            print("🚨 JSON 파싱 에러 : \(error)")
            completion(.failure(DataError.parsingFailed))
        }
    }
}
