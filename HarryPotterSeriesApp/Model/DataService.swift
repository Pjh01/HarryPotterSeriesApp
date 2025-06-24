
import Foundation

// MARK: - 에러 타입 정의
enum DataError: Error, LocalizedError {
    case fileNotFound
    case parsingFailed
    
    // 사용자에게 보여질 에러 메시지 정의
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "데이터 파일을 찾을 수 없습니다."
        case .parsingFailed:
            return "데이터를 불러오는 데 실패했습니다."
        }
    }
}

// MARK: - JSON 데이터를 로드하는 서비스 클래스
class DataService {
    
    func loadBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        
        // JSON 파일 경로 가져오기
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            completion(.failure(DataError.fileNotFound))
            return
        }
        
        // 날짜 디코딩 설정 (release_date → Date)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted({
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter
        }())
        
        do {
            // 파일 데이터 읽기
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            
            // JSON을 BookResponse 객체로 디코딩 → BookContainer 배열에서 Book 배열만 추출 후 전달
            let bookResponse = try decoder.decode(BookResponse.self, from: data)
            let books = bookResponse.data.map { $0.attributes }
            completion(.success(books))
        } catch {
            // 파싱 실패 시 콘솔 로그 및 실패 결과 전달
            print("🚨 JSON 파싱 에러 : \(error)")
            completion(.failure(DataError.parsingFailed))
        }
    }
}
