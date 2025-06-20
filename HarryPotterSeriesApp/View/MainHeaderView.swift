// 상단 제목 및 시리즈 버튼
import UIKit
import SnapKit

protocol MainHeaderViewDelegate: AnyObject {
    func didTapSeriesButton(seriesIndex: Int)
}

class MainHeaderView: UIView {
    
    weak var delegate: MainHeaderViewDelegate?
    let titleLabel = UILabel()
    let seriesButtonStack = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(seriesButtonStack)

        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        seriesButtonStack.axis = .horizontal
        seriesButtonStack.spacing = 10
        seriesButtonStack.alignment = .center
        seriesButtonStack.distribution = .equalCentering
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        seriesButtonStack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    func configure(books: [Book], selectedSeries: Int) {
        titleLabel.text = books[selectedSeries].title
                
        seriesButtonStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for index in 0..<books.count {
            let seriesButton = UIButton()
            seriesButton.setTitle("\(index + 1)", for: .normal)
            seriesButton.titleLabel?.font = .systemFont(ofSize: 16)
            seriesButton.setTitleColor(selectedSeries == index ? .white : .systemBlue, for: .normal)
            seriesButton.backgroundColor = selectedSeries == index ? .systemBlue : .systemGray5
            seriesButton.layer.cornerRadius = 20
            seriesButton.tag = index
            seriesButton.addTarget(self, action: #selector(seriesButtonTapped), for: .touchUpInside)
            
            seriesButton.snp.makeConstraints {
                $0.width.height.equalTo(40)
            }
            
            seriesButtonStack.addArrangedSubview(seriesButton)
        }
    }
    
    @objc func seriesButtonTapped(_ sender: UIButton) {
        delegate?.didTapSeriesButton(seriesIndex: sender.tag)
    }
}
