//
//  QuoteViewController.swift
//  VIPER+ProtocolNetworkManager
//
//  Created Mohamed Hegab on 5/2/18.
//  Copyright © 2018 Mohamed Emad Hegab. All rights reserved.
//
//

import UIKit

class QuoteViewController: UIViewController, QuoteViewProtocol {

    @IBOutlet weak var autherLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    var presenter: QuotePresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getRandomQuote(onComplete: { (quote) in
            self.quoteLabel.text = quote.quote
            self.autherLabel.text = quote.author
        }, onError: { (error) in
            print(error)
        })
    }

}
