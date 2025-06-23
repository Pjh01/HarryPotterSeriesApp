
import UIKit
import SnapKit

class MainViewController: UIViewController, MainHeaderViewDelegate {
    
    var bookData = [Book]()
    var selectedSeries = 0
    
    let headerView = MainHeaderView()
    let contentView = MainContentView()
    let dataService = DataService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        loadBooks()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        headerView.delegate = self
        
        view.addSubview(headerView)
        view.addSubview(contentView)
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let books):
                    guard !books.isEmpty else { return }
                    self.bookData = books
                    self.updateContent()
                    
                case .failure(let error):
                    self.handleError(error)
                }
            }
        }
    }
    
    private func updateContent() {
        headerView.configure(books: bookData, selectedSeries: selectedSeries)
        contentView.configure(book: bookData[selectedSeries], selectedSeries: selectedSeries)
    }
    
    func handleError(_ error: Error) {
        let alert = UIAlertController(title: "데이터 로딩 실패", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    func didTapSeriesButton(seriesIndex: Int) {
        selectedSeries = seriesIndex
        updateContent()
    }
}

