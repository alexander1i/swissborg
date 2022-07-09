//
//  TraidingPairsView.swift
//  swissborg
//
//  Created by Alexander Lisovyk on 25.06.22.
//

import SnapKit
import UIKit

final class TraidingPairsView: UIView {
    let searchTextField = UITextField()
    private let tableView = UITableView()
    
    private var traidingPairs = [TraidingPairModel]()
    
    init() {
        super.init(frame: .zero)
        
        setupUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTraidingPairs(_ traidingPairs: [TraidingPairModel]) {
        self.traidingPairs = traidingPairs
        tableView.reloadData()
    }
}

// MARK: - Private functions
extension TraidingPairsView {
    private func setupUi() {
        addSubview(searchTextField)
        searchTextField.borderStyle = UITextField.BorderStyle.roundedRect
        
        addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        tableView.registerCell(TraidingPairTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.decelerationRate = .fast
        tableView.delaysContentTouches = false
        
        setupColors()
        setupConstraints()
    }
    
    private func setupColors() {
        backgroundColor = .white
        tableView.backgroundColor = .clear
    }
    
    private func setupConstraints() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TraidingPairsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return traidingPairs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TraidingPairTableViewCell = tableView.dequeueCell(for: indexPath)
        cell.bind(with: traidingPairs[indexPath.row])
        return cell
    }
}
