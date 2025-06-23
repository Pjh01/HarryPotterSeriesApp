import UIKit
import SnapKit

class MainView: UIView, MainHeaderViewDelegate {
    var bookData = [Book]()
    var selectedSeries = 0
    let headerView = MainHeaderView()
    let contentView = MainContentView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        headerView.delegate = self  // delegate 연결
        addSubview(headerView)
        addSubview(contentView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func configure(books: [Book]) {
        self.bookData = books
        headerView.configure(books: bookData, selectedSeries: selectedSeries)
        contentView.configure(book: books[selectedSeries], selectedSeries: selectedSeries)
    }
    
    func didTapSeriesButton(seriesIndex: Int) {
        selectedSeries = seriesIndex
        configure(books: bookData)
    }
}
