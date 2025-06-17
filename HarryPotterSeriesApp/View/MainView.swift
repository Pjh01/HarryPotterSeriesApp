import UIKit
import SnapKit

class MainView: UIView {
    let headerView = MainHeaderView()
    let contentView = MainContentView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(headerView)
        addSubview(contentView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func configure(book: Book, seriesNumber: Int) {
        headerView.configure(title: book.title, seriesNumber: seriesNumber)
        contentView.configure(book: book, seriesNumber: seriesNumber)
    }
}
