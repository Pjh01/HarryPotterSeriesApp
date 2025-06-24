import UIKit

extension MainContentView {
    func makeImageAndInfoStack() -> UIStackView {
        // 이미지뷰 설정
        bookImageView.contentMode = .scaleAspectFill
        bookImageView.clipsToBounds = true  // 넘치는 이미지 잘라냄
        bookImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(bookImageView.snp.width).multipliedBy(1.5)
        }

        // 책 제목 라벨 설정
        bookTitleLabel.font = .boldSystemFont(ofSize: 20)
        bookTitleLabel.textColor = .black
        bookTitleLabel.numberOfLines = 0

        // 책 관련 부가정보 (저자, 출판일, 페이지 수) 스택 구성
        let infoStack = UIStackView(arrangedSubviews: [
            bookTitleLabel,
            makeSubInfoStack(type: .author, valueLabel: authorValueLabel),
            makeSubInfoStack(type: .released, valueLabel: releasedValueLabel),
            makeSubInfoStack(type: .pages, valueLabel: pagesValueLabel)
        ])
        infoStack.axis = .vertical
        infoStack.spacing = 8

        // 이미지 + 정보 스택 구성
        let imageAndInfoStack = UIStackView(arrangedSubviews: [bookImageView, infoStack])
        imageAndInfoStack.axis = .horizontal
        imageAndInfoStack.spacing = 16
        imageAndInfoStack.alignment = .top
        return imageAndInfoStack
    }
    
    func makeSubInfoStack(type: BookInfoType, valueLabel: UILabel) -> UIStackView {
        // 제목 라벨 설정
        let titleLabel = UILabel()
        titleLabel.text = type.rawValue
        titleLabel.font = .boldSystemFont(ofSize: type == .author ? 16 : 14)
        titleLabel.textColor = .black
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        // 값 라벨 설정 (저자만 강조 표시)
        valueLabel.font = .systemFont(ofSize: type == .author ? 18 : 14)
        valueLabel.textColor = type == .author ? .darkGray : .gray

        // 수평 정렬 스택 구성
        let subInfoStack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        subInfoStack.axis = .horizontal
        subInfoStack.spacing = 8
        return subInfoStack
    }
    
    func makeDedicationAndSummaryStack(type: BookInfoType, valueLabel: UILabel) -> UIStackView {
        // 제목 라벨
        let titleLabel = UILabel()
        titleLabel.text = type.rawValue
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black

        // 내용 라벨
        valueLabel.font = .systemFont(ofSize: 14)
        valueLabel.textColor = .darkGray
        valueLabel.numberOfLines = 0

        // Summary인 경우만 더보기 버튼 포함
        let summaryStack = UIStackView(arrangedSubviews: type == .summary ? [titleLabel, valueLabel, summaryMoreButton] : [titleLabel, valueLabel])
        summaryStack.axis = .vertical
        summaryStack.spacing = 8
        return summaryStack
    }
    
    func makeChapterStack() -> UIStackView {
        // 제목 라벨
        let titleLabel = UILabel()
        titleLabel.text = BookInfoType.chapter.rawValue
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        
        // 챕터 라벨들을 쌓는 스택뷰
        chapterValueStack.axis = .vertical
        chapterValueStack.spacing = 8

        let chapterStack = UIStackView(arrangedSubviews: [titleLabel, chapterValueStack])
        chapterStack.axis = .vertical
        chapterStack.spacing = 8
        return chapterStack
    }
}

