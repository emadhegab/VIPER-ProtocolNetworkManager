//
//  QuoteRouter.swift
//  VIPER+ProtocolNetworkManager
//
//  Created Mohamed Hegab on 5/2/18.
//  Copyright © 2018 Mohamed Emad Hegab. All rights reserved.
//
//

import UIKit

class QuoteRouter: QuoteWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = QuoteViewController(nibName: nil, bundle: nil)
        let interactor = QuoteInteractor()
        let router = QuoteRouter()
        let presenter = QuotePresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }

    static func route(from vc: UIViewController) {
        let quoteVC = createModule()
        vc.navigationController?.pushViewController(quoteVC, animated: false)
    }
}
