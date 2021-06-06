//
//  Coordinator.swift
//  MVVMTest
//
//  Created by Bezdenezhnykh Sergey on 05.06.2021.
//

import UIKit

enum Event {
    case buttonTapped
}

protocol Coordinator: AnyObject {
    //var children: [Coordinator]? { get }
    func start()
}

protocol Coordinating: AnyObject  {
    var viewModel: ViewModelProtocol? { get set }
    var viewData: Welcome?  { get set }
}

