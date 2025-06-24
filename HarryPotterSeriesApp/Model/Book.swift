import Foundation

// JSON 최상위 응답 객체
struct BookResponse: Decodable {
    let data: [BookContainer]
}

// 각 책 정보를 감싸는 중간 계층
struct BookContainer: Decodable {
    let attributes: Book
}

// 책의 실제 데이터
struct Book: Decodable {
    let title: String
    let author: String
    let pages: Int
    let releaseDate: Date
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [Chapter]
    
    // JSON 키와 Swift 프로퍼티 이름이 다를 경우 명시적으로 매핑
    enum CodingKeys: String, CodingKey {
        case title, author, pages, dedication, summary, wiki, chapters
        case releaseDate = "release_date"   // JSON의 "release_date" → Swift의 "releaseDate"
    }
}

// 각 책의 챕터 제목 정보
struct Chapter: Decodable {
    let title: String
}
