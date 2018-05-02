//
//  QuoteInteractor.swift
//  VIPER+ProtocolNetworkManager
//
//  Created Mohamed Hegab on 5/2/18.
//  Copyright © 2018 Mohamed Emad Hegab. All rights reserved.
//
//

import UIKit

class QuoteInteractor: QuoteInteractorProtocol {

    weak var presenter: QuotePresenterProtocol?
    func getRandomQuote(onComplete: @escaping (Quote) -> Void, onError: @escaping (Error) -> Void) {
        let environment = Environment()
        let networkDispatcher = NetworkDispatcher(environment: environment)
        let quoteTask = QuoteTask<Quote>()
        quoteTask.exeute(in: networkDispatcher, completed: { (quote) in
            DispatchQueue.main.async {
                onComplete(quote)
            }
        }) { (error) in
            onError(error)
        }
    }
}
