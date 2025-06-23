import Foundation

struct BookResponse: Decodable {
    let data: [BookContainer]
}

struct BookContainer: Decodable {
    let attributes: Book
}

struct Book: Decodable {
    let title: String
    let author: String
    let pages: Int
    let releaseDate: Date
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [Chapter]
    
    enum CodingKeys: String, CodingKey {
        case title, author, pages, dedication, summary, wiki, chapters
        case releaseDate = "release_date"
    }
}

struct Chapter: Decodable {
    let title: String
}
