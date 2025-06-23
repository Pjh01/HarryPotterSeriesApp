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
        
        for index in 0...6 {
            var config = UIButton.Configuration.filled()
            config.title = "\(index + 1)"
            config.titleAlignment = .center
            config.cornerStyle = .capsule
            config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
                var newAttributes = attributes
                newAttributes.font = .systemFont(ofSize: 16)
                return newAttributes
            }
            
            let seriesButton = UIButton(configuration: config)
            seriesButton.tag = index
            seriesButton.isSelected = (index == 0)
            seriesButton.configurationUpdateHandler = { button in
                var updatedConfig = button.configuration
                updatedConfig?.baseBackgroundColor = button.isSelected ? .systemBlue : .systemGray5
                updatedConfig?.baseForegroundColor = button.isSelected ? .white : .systemBlue
                button.configuration = updatedConfig
            }
            seriesButton.addTarget(self, action: #selector(seriesButtonTapped), for: .touchUpInside)
            
            seriesButton.snp.makeConstraints {
                $0.height.equalTo(seriesButton.snp.width)
            }
            
            seriesButtonStack.addArrangedSubview(seriesButton)
        }
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
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
    @objc func seriesButtonTapped(_ sender: UIButton) {
        for seriesButton in seriesButtonStack.arrangedSubviews.compactMap({$0 as? UIButton}) {
            seriesButton.isSelected = (seriesButton == sender)
        }
        delegate?.didTapSeriesButton(seriesIndex: sender.tag)
    }
}
