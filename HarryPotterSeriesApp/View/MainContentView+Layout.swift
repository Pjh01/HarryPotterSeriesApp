import UIKit

extension MainContentView {
    func makeImageAndInfoStack() -> UIStackView {
        bookImageView.contentMode = .scaleAspectFill
        bookImageView.clipsToBounds = true  // 넘치는 이미지 잘라냄
        bookImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(bookImageView.snp.width).multipliedBy(1.5)
        }

        bookTitleLabel.font = .boldSystemFont(ofSize: 20)
        bookTitleLabel.textColor = .black
        bookTitleLabel.numberOfLines = 0

        let infoStack = UIStackView(arrangedSubviews: [
            bookTitleLabel,
            makeSubInfoStack(title: "Author", valueLabel: authorValueLabel),
            makeSubInfoStack(title: "Released", valueLabel: releasedValueLabel),
            makeSubInfoStack(title: "Pages", valueLabel: pagesValueLabel)
        ])
        infoStack.axis = .vertical
        infoStack.spacing = 8

        let imageAndInfoStack = UIStackView(arrangedSubviews: [bookImageView, infoStack])
        imageAndInfoStack.axis = .horizontal
        imageAndInfoStack.spacing = 16
        imageAndInfoStack.alignment = .top
        return imageAndInfoStack
    }
    
    func makeSubInfoStack(title: String, valueLabel: UILabel) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: title == "Author" ? 16 : 14)
        titleLabel.textColor = .black
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        valueLabel.font = .systemFont(ofSize: title == "Author" ? 18 : 14)
        valueLabel.textColor = title == "Author" ? .darkGray : .gray

        let subInfoStack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        subInfoStack.axis = .horizontal
        subInfoStack.spacing = 8
        return subInfoStack
    }
    
    func makeSummaryStack(title: String, valueLabel: UILabel) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black

        valueLabel.font = .systemFont(ofSize: 14)
        valueLabel.textColor = .darkGray
        valueLabel.numberOfLines = 0

        let summaryStack = UIStackView(arrangedSubviews: title == "Summary" ? [titleLabel, valueLabel, summaryMoreButton] : [titleLabel, valueLabel])
        summaryStack.axis = .vertical
        summaryStack.spacing = 8
        return summaryStack
    }
    
    func makeChapterStack() -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = "Chapter"
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        
        chapterValueStack.axis = .vertical
        chapterValueStack.spacing = 8

        let chapterStack = UIStackView(arrangedSubviews: [titleLabel, chapterValueStack])
        chapterStack.axis = .vertical
        chapterStack.spacing = 8
        return chapterStack
    }
}

