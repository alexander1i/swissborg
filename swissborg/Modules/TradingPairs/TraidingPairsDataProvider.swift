////
////  TraidingPairsDataProvider.swift
////  swissborg
////
////  Created by Alexander Lisovyk on 25.06.22.
////
//
//import UIKit
//
//protocol TraidingPairsDataProviderProtocol: UITableViewDataSource, UITableViewDelegate {
////    func updateModels(_ models: [FilterListCellType])
////    func onSelect(_ closure: @escaping (FilterListCellModel) -> Void)
////    func onDidScroll(_ closure: @escaping (CGPoint) -> Void)
////    func onWillScroll(_ closure: @escaping () -> Void)
//}
//
//final class TraidingPairsDataProvider: NSObject, TraidingPairsDataProviderProtocol {
//    private var models: [FilterListCellType] = []
//
//    private var selectAction: (FilterListCellModel) -> Void = { _ in }
//    private var scrollChanged: (CGPoint) -> Void = { _ in }
//    private var willScroll: () -> Void = {}
//
//    // MARK: - Life cycle
//    init(context: FilterListContext,
//         filterFont: UIFont) {
//        self.context = context
//        self.filterFont = filterFont
//        super.init()
//    }
//
//    // MARK: - FilterPresentationDataProvider
//    func updateModels(_ models: [FilterListCellType]) {
//        self.models = models
//    }
//
//    func onSelect(_ closure: @escaping (FilterListCellModel) -> Void) {
//        selectAction = closure
//    }
//
//    func onWillScroll(_ closure: @escaping () -> Void) {
//        willScroll = closure
//    }
//
//    func onDidScroll(_ closure: @escaping (CGPoint) -> Void) {
//        scrollChanged = closure
//    }
//}
//
//// MARK: - UITableViewDataSource
//extension TraidingPairsDataProviderProtocol: UITableViewDataSource {
//    func tableView(_ tableView: UITableView,
//                   numberOfRowsInSection section: Int) -> Int {
//        return models.count
//    }
//
//    func tableView(_ tableView: UITableView,
//                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cellType = models[indexPath.row]
//        switch cellType.modelType {
//        case .filter(let model):
//            let cell: FilterListCell = tableView.dequeueCell(for: indexPath)
//            cell.bind(context: context,
//                      model: model,
//                      filterFont: filterFont)
//            return cell
//        case .promotion(let model):
//            let cell: FilterPromotionCell = tableView.dequeueCell(for: indexPath)
//            cell.bind(with: model)
//            return cell
//        case .title:
//            let cell: FilterTitleCell = tableView.dequeueCell(for: indexPath)
//            return cell
//        case .empty:
//            let cell: FilterListEmptyCell = tableView.dequeueCell(for: indexPath)
//            return cell
//        }
//    }
//}
//
//// MARK: - UITableViewDelegate
//extension TraidingPairsDataProviderProtocol: UITableViewDelegate {
//    func tableView(_ tableView: UITableView,
//                   willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        let cellType = models[indexPath.row]
//        switch cellType.modelType {
//        case .filter:
//            return indexPath
//        case .title, .promotion, .empty:
//            return nil
//        }
//    }
//
//    func tableView(_ tableView: UITableView,
//                   didSelectRowAt indexPath: IndexPath) {
//        let cellType = models[indexPath.row]
//        switch cellType.modelType {
//        case .filter(let model):
//            selectAction(model)
//        case .title, .promotion, .empty:
//            return
//        }
//    }
//
//    func tableView(_ tableView: UITableView,
//                   heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cellType = models[indexPath.row]
//        return cellType.height
//    }
//
//    func tableView(_ tableView: UITableView,
//                   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cellType = models[indexPath.row]
//        return cellType.height
//    }
//}
//
//// MARK: - UIScrollViewDelegate
//extension TraidingPairsDataProviderProtocol: UIScrollViewDelegate {
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        willScroll()
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        scrollChanged(scrollView.contentOffset)
//    }
//
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
//                                   withVelocity velocity: CGPoint,
//                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        guard let tableView = scrollView as? UITableView else { return }
//        let contentOffset = desiredContentOffset(tableView: tableView,
//                                                 at: targetContentOffset.pointee,
//                                                 velocity: velocity)
//        targetContentOffset.pointee = contentOffset
//    }
//
//    // MARK: - Private methods
//    private func desiredContentOffset(tableView: UITableView,
//                                      at contentOffset: CGPoint,
//                                      velocity: CGPoint) -> CGPoint {
//        let maxY = tableView.contentSize.height + tableView.contentInset.bottom + tableView.contentInset.top - tableView.bounds.height
//        guard let maxIndexPath = tableView.indexPathForRow(at: CGPoint(x: .zero, y: maxY)) else {
//            return .zero
//        }
//        let maxContentOffset = tableView.rectForRow(at: maxIndexPath).minY
//        guard let indexPath = tableView.indexPathForRow(at: contentOffset) else {
//            if contentOffset.y < .zero {
//                return .zero
//            }
//            return CGPoint(x: .zero, y: maxContentOffset)
//        }
//        let cellRect = tableView.rectForRow(at: indexPath)
//        let expectedOffset = contentOffset.y + velocity.y
//        if expectedOffset < cellRect.midY {
//            return CGPoint(x: .zero,
//                           y: min(maxContentOffset, cellRect.minY))
//        }
//        return CGPoint(x: .zero,
//                       y: min(maxContentOffset, cellRect.maxY))
//    }
//}
