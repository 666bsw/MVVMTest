//
//  CellView.swift
//  MVVMTest
//
//  Created by Bezdenezhnykh Sergey on 06.06.2021.
//

import UIKit

class CellView: UITableViewCell {
    
    weak var controller: Coordinating?
    
    private var pickerData: [Variant]?
    
    private lazy var labelObject: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .label
        label.text = "Name:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelText: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .label
        label.text = "Text:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private lazy var pickerView: UIPickerView = {
        var pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 30, height: 120))
        pickerView.center = self.center
        pickerView.layer.cornerRadius = 4
        pickerView.layer.borderColor = UIColor.primary.cgColor
        pickerView.layer.borderWidth = 1
        pickerView.backgroundColor = .systemBackground
        pickerView.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        return pickerView
    }()
    
    private lazy var tap: UITapGestureRecognizer = {
        var tap = UITapGestureRecognizer(target: self, action: #selector(oneTapGecture(sender:)))        
        return tap
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.contentView.backgroundColor = .systemBackground
        self.contentView.addSubview(labelObject)
        self.contentView.addSubview(labelText)
        self.contentView.addSubview(pickerView)
        self.contentView.addGestureRecognizer(tap)
        addConsrtraint()
    }
    
    @objc private func oneTapGecture(sender: UITapGestureRecognizer) {
        labelText.isHidden = false
    }
    
    private func addConsrtraint() {
        labelObject.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        labelObject.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        labelObject.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        labelObject.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        labelText.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        labelText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        labelText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        labelText.widthAnchor.constraint(equalToConstant: 130).isActive = true
    }
    
    var dataType: DataType? {
        didSet {
            if let data = controller?.viewData?.data.first(where: { $0.name == dataType?.rawValue }),
               let dataType = dataType {
                
                labelObject.text = data.name
                
                switch dataType {
                case .hz, .picture:
                    pickerView.isHidden = true
                    labelText.text = data.data.text
                case .selector:
                    pickerView.isHidden = false
                    pickerData = data.data.variants
                    pickerView.delegate = self
                    pickerView.dataSource = self
                    let inialPosition = (data.data.selectedID ?? 1) - 1
                    pickerView.selectRow(inialPosition, inComponent: 0, animated: true)
                }
            }
        }
    }
}

extension CellView: UIPickerViewDataSource, UIPickerViewDelegate  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 30, height: 40)
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 30, height: 40)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = String(pickerData?[row].id ?? 1)
        view.addSubview(label)
        view.transform = CGAffineTransform(rotationAngle: .pi / 2)
        labelText.text = pickerData?[row].text
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        labelText.isHidden = false
    }
}
