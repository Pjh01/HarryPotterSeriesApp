
import UIKit

class MainViewController: UIViewController {
    
    let dataService = DataService()
    var seriesNumber = 0
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
                    self.mainView.configure(book: books[self.seriesNumber], seriesNumber: self.seriesNumber)
                    
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}

