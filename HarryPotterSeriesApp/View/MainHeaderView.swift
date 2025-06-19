// 상단 제목 및 시리즈 버튼
import UIKit
import SnapKit

class MainHeaderView: UIView {
    let titleLabel = UILabel()
    let seriesButton = UIButton()

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
        addSubview(seriesButton)

        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        seriesButton.titleLabel?.font = .systemFont(ofSize: 16)
        seriesButton.titleLabel?.textAlignment = .center
        seriesButton.setTitleColor(.white, for: .normal)
        seriesButton.backgroundColor = .systemBlue
        seriesButton.layer.cornerRadius = 20
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        seriesButton.snp.makeConstraints {
            //$0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(40)
            $0.bottom.equalToSuperview()
        }
    }
    
    func configure(title: String, seriesNumber: Int) {
        titleLabel.text = title
        seriesButton.setTitle("\(seriesNumber + 1)", for: .normal)
    }
}
