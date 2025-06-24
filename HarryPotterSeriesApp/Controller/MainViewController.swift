
import UIKit
import SnapKit

// MainHeaderViewDelegate를 채택해 버튼 탭 이벤트 처리
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
        
        headerView.delegate = self      // 델리게이트 연결 (버튼 클릭 이벤트 전달)
        
        view.addSubview(headerView)
        view.addSubview(contentView)
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(15)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // JSON 데이터를 로드하고 UI에 반영
    private func loadBooks() {
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
    
    // 현재 선택된 시리즈를 기준으로 UI 업데이트
    private func updateContent() {
        guard bookData.indices.contains(selectedSeries) else { return } // 유효한 인덱스인지 확인
        
        headerView.configure(title: bookData[selectedSeries].title)
        contentView.configure(book: bookData[selectedSeries], selectedSeries: selectedSeries)
    }
    
    // 에러 발생 시 알림창 표시
    private func handleError(_ error: Error) {
        let alert = UIAlertController(title: "데이터 로딩 실패", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    // 시리즈 버튼 클릭 시 호출되는 델리게이트 메서드
    func didTapSeriesButton(seriesIndex: Int) {
        selectedSeries = seriesIndex
        updateContent()
    }
}

