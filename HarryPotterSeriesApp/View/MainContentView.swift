//하단 책 내용 scrollView
import UIKit
import SnapKit

class MainContentView: UIView {
    
    let scrollView = UIScrollView()
    let totalStack = UIStackView()
    
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
        totalStack.arrangedSubviews.forEach { $0.removeFromSuperview() } // 갱신 시 기존 제거

        let stacks: [UIStackView] = [
            makeImageAndInfoStack(book: book, seriesNumber: selectedSeries),
            makeSummaryStack(title: "Dedication", value: book.dedication),
            makeSummaryStack(title: "Summary", value: book.summary, seriesNumber: selectedSeries),
            makeChapterStack(title: "Chapter", value: book.chapters)
        ]
        stacks.forEach { totalStack.addArrangedSubview($0) }
    }
}
