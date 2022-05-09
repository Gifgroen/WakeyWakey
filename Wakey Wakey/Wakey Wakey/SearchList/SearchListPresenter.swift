//
//  SearchListPresenter.swift
//  Wakey Wakey
//
//  Created by Karsten Westra on 09/05/2022.
//

class SearchListPresenter {
    private let view: SearchListView
    private let interactor: SearchListInteractor
    
    public init(
        view: SearchListView,
        interactor: SearchListInteractor
    ) {
        self.view = view
        self.interactor = interactor
    }
    
    public func search(query: String) {
        self.interactor.search(query: query, completion: { reponse in
            self.view.show(decodable: reponse)
        })
    }
}
