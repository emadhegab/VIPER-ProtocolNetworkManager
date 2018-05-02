//
//  QuotePresenter.swift
//  VIPER+ProtocolNetworkManager
//
//  Created Mohamed Hegab on 5/2/18.
//  Copyright © 2018 Mohamed Emad Hegab. All rights reserved.
//
//

import UIKit

class QuotePresenter: QuotePresenterProtocol {



    weak private var view: QuoteViewProtocol?
    var interactor: QuoteInteractorProtocol?
    private let router: QuoteWireframeProtocol

    init(interface: QuoteViewProtocol, interactor: QuoteInteractorProtocol?, router: QuoteWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func getRandomQuote(onComplete: @escaping (Quote) -> Void, onError: @escaping (Error) -> Void)  {
        self.interactor?.getRandomQuote(onComplete: onComplete, onError: onError)
    }

}
