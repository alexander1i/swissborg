//
//  TraidingPairTableViewCell.swift
//  swissborg
//
//  Created by Alexander Lisovyk on 25.06.22.
//

import SnapKit

final class TraidingPairTableViewCell: UITableViewCell {
    private let containerView = UIView()
    private let stackView = UIStackView()
    private let nameSymbolStackView = UIStackView()
    private let priceInterestStackView = UIStackView()
    
    private let assetImageView = UIImageView()
    private let nameLabel = UILabel()
    private let symbolLabel = UILabel()
    private let priceLabel = UILabel()
    private let interestLabel = UILabel()
    
    // MARK: - Life Cycle
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        setupUi()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUi()
    }

    func bind(with model: TraidingPairModel) {
        nameLabel.text = model.name
        symbolLabel.text = model.symbol
        priceLabel.text = model.price
        interestLabel.text = model.interest
        assetImageView.image = UIImage(named: model.symbol.lowercased())
    }
    
    // MARK: - Private methods
    private func setupUi() {
        backgroundColor = .clear
        
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 10
        containerView.addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .center
        
        stackView.addArrangedSubview(assetImageView)
        stackView.addArrangedSubview(nameSymbolStackView)
        stackView.addArrangedSubview(priceInterestStackView)
        
        nameSymbolStackView.axis = .vertical
        nameSymbolStackView.spacing = 5
        
        priceInterestStackView.axis = .vertical
        priceInterestStackView.spacing = 5
        
        // Name Label
        nameSymbolStackView.addArrangedSubview(nameLabel)
        nameLabel.text = "Tether USD"
        nameLabel.font = .systemFont(ofSize: 16, weight: .black)
        nameLabel.textColor = .black
        
        // Symbol Label
        nameSymbolStackView.addArrangedSubview(symbolLabel)
        symbolLabel.text = "USDT"
        symbolLabel.font = .systemFont(ofSize: 14, weight: .regular)
        symbolLabel.textColor = .gray
        
        // Price Label
        priceInterestStackView.addArrangedSubview(priceLabel)
        priceLabel.text = "EUR 0.8,615"
        priceLabel.textAlignment = .right
        priceLabel.font = .systemFont(ofSize: 16, weight: .black)
        priceLabel.textColor = .black
        
        // Interest Label
        priceInterestStackView.addArrangedSubview(interestLabel)
        interestLabel.text = "+4.55%"
        interestLabel.textAlignment = .right
        interestLabel.font = .systemFont(ofSize: 14, weight: .regular)
        interestLabel.textColor = .gray
        
        setupColors()
        setupConstraints()
    }
    
    private func setupColors() {
        containerView.backgroundColor = .lightText
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview().inset(15)
            make.top.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        
        assetImageView.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
    }
}

// MARK: - SwiftUI Preview
#if (DEBUG || ENTERPRISE) && canImport(SwiftUI)
import SwiftUI

@available(iOS 13.0, *)
struct TraidingPairTableViewCellContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> TraidingPairTableViewCell {
        let cell = TraidingPairTableViewCell(style: .default, reuseIdentifier: nil)
        //cell.bind(with: .init(logoImage: Asset.efektLogo.image))
        return cell
    }
    
    func updateUIView(_ uiView: TraidingPairTableViewCell, context: Context) {}
}

@available(iOS 13.0, *)
struct FilterPromotionCellContainer_Previews: PreviewProvider {
    static var previews: some View {
        TraidingPairTableViewCellContainer()
            .colorScheme(.light)
            .previewLayout(.fixed(width: 414, height: 80))
    }
}

#endif
