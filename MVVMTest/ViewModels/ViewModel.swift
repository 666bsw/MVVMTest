//
//  ViewModel.swift
//  MVVMTest
//
//  Created by Bezdenezhnykh Sergey on 05.06.2021.
//

import Foundation

protocol ViewModelProtocol {
    var viewData: ((Welcome)->())? { get set }
    func eventTapped(with type: Event)
}

struct ViewModel: ViewModelProtocol {
    weak var coordinator: Coordinator?
    private var apiService: APIServiceProtocol
    var viewData: ((Welcome) -> ())?
    
    init() {
        self.apiService =  APIService()
    }
    
    func eventTapped(with type: Event) {
        apiService.getData { velcome in
            guard let velcome = velcome else { return }
            viewData?(velcome)
        }
    }
}
