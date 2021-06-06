//
//  ViewController.swift
//  MVVMTest
//
//  Created by Bezdenezhnykh Sergey on 05.06.2021.
//

import UIKit

class ViewController: UIViewController , Coordinating {
    
    var viewModel: ViewModelProtocol?
    var viewData: Welcome?
    private var header: HeaderViewProtocol?
    private let headerHeight: CGFloat = 50
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(CellView.self, forCellReuseIdentifier: "cell")
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Test"
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: headerHeight))
        setConstraint()
        updateView()
    }
    
    @objc func didTap(sender: UIButton) {
        viewModel?.eventTapped(with: .buttonTapped)
    }
    
    private func updateView() {
        viewModel?.viewData = { [weak self] viewData in
            print(viewData)
            self?.viewData = viewData
            self?.tableView.reloadSections([0], with: .automatic)
        }
    }
    
    func setConstraint() {        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData?.view.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellView {
            cell.controller = self
            cell.dataType = DataType.init(rawValue: viewData?.view[indexPath.row] ?? "-")
                //viewData?.view[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    //MARK: - Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        header?.buttonLoad.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        return header as? UIView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight - 2
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}
