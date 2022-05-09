//
//  ViewController.swift
//  Wakey Wakey
//
//  Created by Karsten Westra on 09/05/2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!

    private var presenter: SearchListPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter = SearchListPresenter(
            view: self,
            interactor: SearchListInteractor()
        )
        self.presenter.search(query: "Wakeboard")
    }
}

extension ViewController: SearchListView {
    public func show(decodable: DecodableType) {
        self.resultLabel.text = decodable.videos.description
    }
}
