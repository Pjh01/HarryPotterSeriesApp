
import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let dataService = DataService()
    let mainView = MainView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainView)
        mainView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        loadBooks()
    }

    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let books):
                    guard !books.isEmpty else { return }
                    self.mainView.configure(books: books)
                    
                case .failure(let error):
                    self.handleError(error)
                }
            }
        }
    }
    
    func handleError(_ error: Error) {
        let message: String
        
        switch error {
        case DataError.fileNotFound:
            message = "데이터 파일을 찾을 수 없습니다."
        case DataError.parsingFailed:
            message = "데이터를 불러오는 데 실패했습니다."
        default:
            message = error.localizedDescription
        }
        
        let alert = UIAlertController(title: "데이터 로딩 실패", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

