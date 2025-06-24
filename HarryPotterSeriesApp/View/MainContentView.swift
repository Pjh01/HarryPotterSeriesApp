//하단 책 상세 내용 scrollView
import UIKit
import SnapKit

// 책 정보 타입 정의
enum BookInfoType: String {
    case author = "Author"
    case released = "Released"
    case pages = "Pages"
    case dedication = "Dedication"
    case summary = "Summary"
    case chapter = "Chapter"
}

class MainContentView: UIView {
    
    let scrollView = UIScrollView() // 전체 스크롤뷰
    let totalStack = UIStackView()  // 콘텐츠를 담는 수직 스택뷰
    
    let bookImageView = UIImageView()
    let bookTitleLabel = UILabel()
    let authorValueLabel = UILabel()
    let releasedValueLabel = UILabel()
    let pagesValueLabel = UILabel()
    
    let dedicationValueLabel = UILabel()
    
    let summaryPreviewLimit = 450
    let summaryValueLabel = UILabel()
    let summaryMoreButton = UIButton()
    
    var chapterValueStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 설정
    private func setupUI() {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(totalStack)
        
        addSubview(scrollView)
        totalStack.axis = .vertical
        totalStack.spacing = 24
        
        summaryMoreButton.titleLabel?.font = .systemFont(ofSize: 14)
        summaryMoreButton.setTitleColor(.systemBlue, for: .normal)
        summaryMoreButton.contentHorizontalAlignment = .right
        
        let stacks: [UIStackView] = [
            makeImageAndInfoStack(),
            makeDedicationAndSummaryStack(type: .dedication, valueLabel: dedicationValueLabel),
            makeDedicationAndSummaryStack(type: .summary, valueLabel: summaryValueLabel),
            makeChapterStack()
        ]
        stacks.forEach { totalStack.addArrangedSubview($0) }
    }
    
    // MARK: - 오토레이아웃 설정
    private func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        totalStack.snp.makeConstraints {
            $0.top.bottom.equalTo(scrollView.contentLayoutGuide)
            $0.leading.trailing.equalTo(scrollView.frameLayoutGuide).inset(20)
        }
    }
    
    // MARK: - 데이터 구성
    func configure(book: Book, selectedSeries: Int) {
        bookImageView.image = UIImage(named: "harrypotter\(selectedSeries + 1)")
        bookTitleLabel.text = book.title
        authorValueLabel.text = book.author
        releasedValueLabel.text = "\(book.releaseDate, format: .long, locale: Locale(identifier: "en_US"))"
        pagesValueLabel.text = "\(book.pages)"
        dedicationValueLabel.text = book.dedication
        
        // 요약 텍스트 처리
        configureSummary(value: book.summary, selectedSeries: selectedSeries)
        
        //기존 챕터 제거
        chapterValueStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // 새로운 챕터 추가
        for chapter in book.chapters {
            let chapterLabel = UILabel()
            chapterLabel.text = chapter.title
            chapterLabel.font = .systemFont(ofSize: 14)
            chapterLabel.textColor = .darkGray
            chapterLabel.numberOfLines = 0
            chapterValueStack.addArrangedSubview(chapterLabel)
        }
    }
    
    // MARK: - 요약 텍스트 처리
    func configureSummary(value: String, selectedSeries: Int) {
        let key = "isExpanded_\(selectedSeries)"
        let isExpanded = UserDefaults.standard.bool(forKey: key)
        let isTruncate = value.count > summaryPreviewLimit
        
        // 요약 내용 잘라서 표시
        summaryValueLabel.text = isTruncate && !isExpanded
        ? "\(value.prefix(summaryPreviewLimit))..."
        : value
        
        // 버튼 텍스트 변경 및 숨김 처리
        summaryMoreButton.setTitle(isExpanded ? "접기" : "더 보기", for: .normal)
        summaryMoreButton.isHidden = !isTruncate
        
        // 기존 액션 제거 후 새로운 액션 등록
        summaryMoreButton.removeTarget(nil, action: nil, for: .allEvents)
        summaryMoreButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            let toggled = !UserDefaults.standard.bool(forKey: key)
            UserDefaults.standard.set(toggled, forKey: key)
            self.configureSummary(value: value, selectedSeries: selectedSeries)  // 상태 토글 후 다시 값 설정. configureSummary() 재호출로 간결화
        }, for: .touchUpInside)
    }
}

// 문자열 보간을 통해 Date → String 포맷 간편 처리
extension String.StringInterpolation {
    mutating func appendInterpolation(_ date: Date, format: DateFormatter.Style = .long, locale: Locale = .current) {
        let formatter = DateFormatter()
        formatter.dateStyle = format
        formatter.locale = locale
        appendLiteral(formatter.string(from: date))
    }
}
