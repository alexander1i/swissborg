//
//  UITableView+Register.swift
//  swissborg
//
//  Created by Alexander Lisovyk on 25.06.22.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }

    func dequeueCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier) as? T else {
            fatalError("Could not cast dequeued cell with identifier: \(T.identifier) to type: \(T.self)")
        }
        return cell
    }

    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }
}

extension UITableViewCell: Identifiable {}

extension UITableViewHeaderFooterView: Identifiable {}
