//
//  TraidingPairsBuilder.swift
//  swissborg
//
//  Created by Alexander Lisovyk on 25.06.22.
//

import Foundation
import UIKit

struct TraidingPairsBuilder {
    static func build() -> UIViewController {
        let viewModel = TraidingPairsViewModel()
        let networkService = ProductionNetworkService()
        let fetchTraidingPairsUseCese = FetchTraidingPairsUseCase(repository: FetchTraidingPairsRepository(networkService: networkService))
        
        let interactor = TraidingPairsInteractor(
            presenter: viewModel,
            fetchTraidingPairsUseCase: fetchTraidingPairsUseCese
        )
        let viewController = TraidingPairsViewController(interactor: interactor, viewModel: viewModel)
        
        return UINavigationController(rootViewController: viewController)
    }
}
