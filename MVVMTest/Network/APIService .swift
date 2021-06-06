//
//  File.swift
//  MVVMTest
//
//  Created by Bezdenezhnykh Sergey on 05.06.2021.
//

import Foundation
import Alamofire

protocol APIServiceProtocol {
    func getData(completion : @escaping (Welcome?) -> ())
}

class APIService: APIServiceProtocol {
    
    private let endpointUrl = URL(string: "https://pryaniky.com/static/json/sample.json")
    
    func getData(completion : @escaping (Welcome?) -> ()) {
        guard let endpointUrl = endpointUrl else { completion(nil); return }
        
        AF.request(endpointUrl, method: .get)
            .validate()
            .responseDecodable(of: Welcome.self) { (response) in
                switch response.result {
                case .success(let value):
                    completion(value)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
    }
}
