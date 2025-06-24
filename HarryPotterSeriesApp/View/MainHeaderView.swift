// 상단 제목 및 시리즈 버튼
import UIKit
import SnapKit

// 델리게이트 프로토콜 정의
protocol MainHeaderViewDelegate: AnyObject {
    func didTapSeriesButton(seriesIndex: Int)
}

class MainHeaderView: UIView {
    
    weak var delegate: MainHeaderViewDelegate?  // 버튼 클릭을 위임받을 객체
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
    
    // MARK: - UI 구성
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(seriesButtonStack)

        // 제목 설정
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        // 버튼 스택 설정
        seriesButtonStack.axis = .horizontal
        seriesButtonStack.spacing = 10
        seriesButtonStack.alignment = .center
        seriesButtonStack.distribution = .equalCentering
        
        // 총 7개의 시리즈 버튼 생성
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
            seriesButton.tag = index        // 버튼에 tag를 지정. 인덱스 쉽게 구분 가능
            seriesButton.isSelected = (index == 0)  // 기본값. 첫 번째 버튼만 선택 상태
            
            // 버튼의 isSelected 값에 따라 배경 및 텍스트 색상 자동 업데이트
            seriesButton.configurationUpdateHandler = { button in
                var updatedConfig = button.configuration
                updatedConfig?.baseBackgroundColor = button.isSelected ? .systemBlue : .systemGray5
                updatedConfig?.baseForegroundColor = button.isSelected ? .white : .systemBlue
                button.configuration = updatedConfig
            }
            seriesButton.addTarget(self, action: #selector(seriesButtonTapped), for: .touchUpInside)
            
            seriesButton.snp.makeConstraints {
                $0.width.equalTo(seriesButton.snp.height)
            }
            
            seriesButtonStack.addArrangedSubview(seriesButton)
        }
    }
    
    // MARK: - 오토레이아웃 설정
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
    
    // 버튼 클릭 시 선택 상태 갱신 및 델리게이트 호출
    @objc func seriesButtonTapped(_ sender: UIButton) {
        for seriesButton in seriesButtonStack.arrangedSubviews.compactMap({$0 as? UIButton}) {
            seriesButton.isSelected = (seriesButton == sender)
        }
        delegate?.didTapSeriesButton(seriesIndex: sender.tag)
    }
}
