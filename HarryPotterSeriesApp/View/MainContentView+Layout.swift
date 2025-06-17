import UIKit

extension MainContentView {
    func makeImageAndInfoStack(book: Book, seriesNumber: Int) -> UIStackView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "harrypotter\(seriesNumber + 1)")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true  // 넘치는 이미지 잘라냄
        imageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(imageView.snp.width).multipliedBy(1.5)
        }

        let bookTitleLabel = UILabel()
        bookTitleLabel.text = book.title
        bookTitleLabel.font = .boldSystemFont(ofSize: 20)
        bookTitleLabel.textColor = .black
        bookTitleLabel.numberOfLines = 0

        let infoStack = UIStackView(arrangedSubviews: [
            bookTitleLabel,
            makeSubInfoStack(title: "Author", value: book.author),
            makeSubInfoStack(title: "Released", value: formattedDate(book.release_date)),
            makeSubInfoStack(title: "Pages", value: "\(book.pages)")
        ])
        infoStack.axis = .vertical
        infoStack.spacing = 8

        let horizontalStack = UIStackView(arrangedSubviews: [imageView, infoStack])
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 15
        horizontalStack.alignment = .top
        return horizontalStack
    }
    
    func makeSubInfoStack(title: String, value: String) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: title == "Author" ? 16 : 14)
        titleLabel.textColor = .black
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: title == "Author" ? 18 : 14)
        valueLabel.textColor = title == "Author" ? .darkGray : .gray

        let stack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }
    
    func formattedDate(_ dateValue: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // JSON의 날짜 포맷

        guard let date = formatter.date(from: dateValue) else { return dateValue }

        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .long // "July 2, 1998"
        displayFormatter.locale = Locale(identifier: "en_US") // 영어 스타일

        return displayFormatter.string(from: date)
    }
    
    func makeSummaryStack(title: String, value: String, seriesNumber: Int = 0) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black

        let valueLabel = UILabel()
        valueLabel.font = .systemFont(ofSize: 14)
        valueLabel.textColor = .darkGray
        valueLabel.numberOfLines = 0
        
        valueLabel.text = value

        let stack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }
}

