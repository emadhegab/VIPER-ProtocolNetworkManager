//
//  QuoteProtocols.swift
//  VIPER+ProtocolNetworkManager
//
//  Created Mohamed Hegab on 5/2/18.
//  Copyright © 2018 Mohamed Emad Hegab. All rights reserved.
//
//

import Foundation

//MARK: Wireframe -
protocol QuoteWireframeProtocol: class {

}
//MARK: Presenter -
protocol QuotePresenterProtocol: class {
    func getRandomQuote(onComplete: @escaping (Quote) -> Void, onError: @escaping (Error) -> Void) 
}

//MARK: Interactor -
protocol QuoteInteractorProtocol: class {
    func getRandomQuote(onComplete: @escaping (Quote) -> Void, onError: @escaping (Error) -> Void)
    var presenter: QuotePresenterProtocol?  { get set }
}

//MARK: View -
protocol QuoteViewProtocol: class {

  var presenter: QuotePresenterProtocol?  { get set }
}
