//
//  TraidingPairsInteractor.swift
//  swissborg
//
//  Created by Alexander Lisovyk on 25.06.22.
//

import Foundation
import Combine

final class TraidingPairsInteractor {
    let presenter: TraidingPairsPresenter
    let fetchTraidingPairsUseCase: FetchTraidingPairsUseCase
    
    private let filterTraidingPairsQueue = DispatchQueue(label: "com.filter.queue", attributes: .concurrent)
    
    private var subscriptions = Set<AnyCancellable>()
    private var timerSubscription: Cancellable?
    
    private let fiatSymbol = "USD"
    
    private var traidingPairs = [[Any]]()
    private var filteredTraidingPairs = [[Any]]()
    
    private var timer: Timer?
    private var filterQuery: String?
    
    init(
        presenter: TraidingPairsPresenter,
        fetchTraidingPairsUseCase: FetchTraidingPairsUseCase
    ) {
        self.presenter = presenter
        self.fetchTraidingPairsUseCase = fetchTraidingPairsUseCase
    }
    
    func viewDidLoad() {
        fetchTraidingPairs()
        timerSubscription = Timer.publish(every: 5.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.fetchTraidingPairs()
            }
    }
    
    func filterTraidingPairs(query: String) {
        filterQuery = query
        if query.isEmpty {
            filterQuery = nil
        }
        filterTraidingPairs()
    }
    
    func viewWillDisappear() {
        timerSubscription?.cancel()
    }
}

// MARK: - Private functions
extension TraidingPairsInteractor {
    private func fetchTraidingPairs() {
        let cryptoSymbols = ["BTC", "ETH", "AAVE", "CHSB", "DOGE", "EOS", "LTC", "MATIC", "XRP"]
        fetchTraidingPairsUseCase.fetchTraidingPairs(cryptoSymbols: cryptoSymbols, fiatSymbol: fiatSymbol)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:     self?.presenter.showMessage(text: "Data was successfully updated.")
                case .failure(_):   self?.presenter.showMessage(text: "Failure getting traiding pairs. Data is not relevant.")
                }
                
            } receiveValue: { [weak self] traidingPairs in
                guard
                    let self = self,
                    let traidingPairs = traidingPairs
                else {
                    return
                }

                self.traidingPairs = traidingPairs
                self.filteredTraidingPairs = traidingPairs
                
                self.filterTraidingPairs()
            }
            .store(in: &subscriptions)
    }
    
    private func filterTraidingPairs() {
        filterTraidingPairsQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else {
                return
            }
            
            if let filterQuery = self.filterQuery {
                self.filteredTraidingPairs = self.traidingPairs.filter { pair in
                    if (pair[0] as? String)?.lowercased().contains(filterQuery.lowercased()) ?? false {
                        return true
                    }
                    
                    let symbol = ((pair[0] as? String) ?? "")
                        .replacingOccurrences(of: "t", with: "")
                        .replacingOccurrences(of: self.fiatSymbol, with: "")
                    
                    if CryptoNameResolver.resolveName(with: symbol).lowercased().contains(filterQuery.lowercased()) {
                        return true
                    }
                    
                    return false
                }
                self.presenter.updateTraidingPairs(traidingPairs: self.filteredTraidingPairs, fiatSymbol: self.fiatSymbol)
            } else {
                self.presenter.updateTraidingPairs(traidingPairs: self.traidingPairs, fiatSymbol: self.fiatSymbol)
            }
        }
    }
}
