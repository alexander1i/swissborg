//
//  TraidingPairsViewController.swift
//  swissborg
//
//  Created by Alexander Lisovyk on 25.06.22.
//

import UIKit

import SnapKit
import Combine
import Toast

final class TraidingPairsViewController: UIViewController {
    let interactor: TraidingPairsInteractor
    let viewModel: TraidingPairsViewModel
    
    private let traidingPairsView = TraidingPairsView()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(
        interactor: TraidingPairsInteractor,
        viewModel: TraidingPairsViewModel
    ) {
        self.interactor = interactor
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = traidingPairsView
    }
    
    // MARK: -  Overrides methods
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()

        traidingPairsView.searchTextField.textPublisher
            .removeDuplicates()
            .sink { [weak self] in
                self?.interactor.filterTraidingPairs(query: $0)
            }
            .store(in: &subscriptions)
        
        viewModel.$traidingPairs
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                self?.traidingPairsView.updateTraidingPairs($0)
            })
            .store(in: &subscriptions)
        
        viewModel.$toastMessage
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] message in
                self?.view.makeToast(message, duration: 3.0, position: .bottom)
            })
            .store(in: &subscriptions)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactor.viewWillDisappear()
    }
}

// MARK: - Private methods
extension TraidingPairsViewController {
    
}

// MARK: - Preview
import SwiftUI

@available(iOS 13.0, *)
struct TraidingPairsViewControllerContainer: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> TraidingPairsViewController {
        let viewModel = TraidingPairsViewModel()
        return TraidingPairsViewController(
            interactor: TraidingPairsInteractor(presenter: viewModel, fetchTraidingPairsUseCase: FetchTraidingPairsUseCase(repository: FetchTraidingPairsRepository(networkService: ProductionNetworkService()))),
            viewModel: viewModel
        )
    }
    
    func updateUIViewController(
        _ uiViewController: TraidingPairsViewController,
        context: Context
    ) {}
}

@available(iOS 13.0, *)
struct TraidingPairsViewControllerContainer_Previews: PreviewProvider {
    static var previews: some View {
        TraidingPairsViewControllerContainer()
            .previewDevice("iPhone 13")
            .preferredColorScheme(.light)
    }
}
