//하단 책 내용 scrollView
import UIKit
import SnapKit

class MainContentView: UIView {
    
    let scrollView = UIScrollView()
    let totalStack = UIStackView()
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
            makeSummaryStack(title: "Dedication", valueLabel: dedicationValueLabel),
            makeSummaryStack(title: "Summary", valueLabel: summaryValueLabel),
            makeChapterStack()
        ]
        stacks.forEach { totalStack.addArrangedSubview($0) }
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        totalStack.snp.makeConstraints {
            $0.top.bottom.equalTo(scrollView.contentLayoutGuide)
            $0.leading.trailing.equalTo(scrollView.frameLayoutGuide).inset(20)
        }
    }
    
    func configure(book: Book, selectedSeries: Int) {
        bookImageView.image = UIImage(named: "harrypotter\(selectedSeries + 1)")
        bookTitleLabel.text = book.title
        authorValueLabel.text = book.author
        releasedValueLabel.text = formattedDate(book.releaseDate)
        pagesValueLabel.text = "\(book.pages)"
        dedicationValueLabel.text = book.dedication
        configureSummary(value: book.summary, selectedSeries: selectedSeries)
        
        //기존 레이블 제거
        chapterValueStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for chapter in book.chapters {
            let chapterLabel = UILabel()
            chapterLabel.text = chapter.title
            chapterLabel.font = .systemFont(ofSize: 14)
            chapterLabel.textColor = .darkGray
            chapterLabel.numberOfLines = 0
            chapterValueStack.addArrangedSubview(chapterLabel)
        }
    }
    
    func configureSummary(value: String, selectedSeries: Int) {
        let key = "isExpanded_\(selectedSeries)"
        let isExpanded = UserDefaults.standard.bool(forKey: key)
        let isTruncate = value.count > summaryPreviewLimit
        
        summaryValueLabel.text = isTruncate && !isExpanded
        ? "\(value.prefix(summaryPreviewLimit))..."
        : value
        
        summaryMoreButton.setTitle(isExpanded ? "접기" : "더 보기", for: .normal)
        summaryMoreButton.isHidden = !isTruncate
        
        summaryMoreButton.removeTarget(nil, action: nil, for: .allEvents) // 기존 이벤트 제거 후 새 이벤트 추가
        summaryMoreButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            let toggled = !UserDefaults.standard.bool(forKey: key)
            UserDefaults.standard.set(toggled, forKey: key)
            self.configureSummary(value: value, selectedSeries: selectedSeries)  // 상태 토글 후 다시 값 설정. configureSummary() 재호출로 간결화
        }, for: .touchUpInside)
    }
}
