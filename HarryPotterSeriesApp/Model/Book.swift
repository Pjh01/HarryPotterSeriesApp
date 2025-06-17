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
    let release_date: String
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [Chapter]
}

struct Chapter: Decodable {
    let title: String
}
