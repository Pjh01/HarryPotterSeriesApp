//
import UIKit
import SnapKit

class MainContentView: UIView {
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
        addSubview(totalStack)
        totalStack.axis = .vertical
        totalStack.spacing = 24
    }
    
    private func setupConstraints() {
        totalStack.snp.makeConstraints {
            //$0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            //$0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func configure(book: Book, seriesNumber: Int) {
        totalStack.arrangedSubviews.forEach { $0.removeFromSuperview() } // 갱신 시 기존 제거

        let stacks: [UIStackView] = [
            makeImageAndInfoStack(book: book, seriesNumber: seriesNumber)
        ]
        stacks.forEach { totalStack.addArrangedSubview($0) }
    }
}
