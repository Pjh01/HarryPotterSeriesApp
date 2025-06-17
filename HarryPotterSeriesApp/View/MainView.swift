import UIKit
import SnapKit

class MainView: UIView {
    let headerView = MainHeaderView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(headerView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func configure(book: Book, seriesNumber: Int) {
        headerView.configure(title: book.title, seriesNumber: seriesNumber)
    }
}
