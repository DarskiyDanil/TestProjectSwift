//
//  ExpandebleEditListHeaderFooterView.swift
//  TestProjectSwift
//
//  Created by  Данил Дарский on 22.03.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

// для скрытия и отображения ячеек в секции
protocol ExpandebleEditListHeaderFooterViewDelegate {
    func toggleSection(header: ExpandebleEditListHeaderFooterView, section: Int)
}

class ExpandebleEditListHeaderFooterView: UITableViewHeaderFooterView {
    
//    let editListViewController = EditListViewController()
//    let ddd = EditListViewController.shared
    var delegate: ExpandebleEditListHeaderFooterViewDelegate?
    var section: Int?
    
    //    для удаление всей секции Person
    let dellOnePersonButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.darkGray, for: .normal)
        button.setImage(UIImage(systemName: "person.crop.circle.badge.minus"), for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action:  #selector(EditListViewController.shared.tapDellOnePersonButton), for:.touchDown)
        return button
    }()
    
    //    для добавления ячейки в секцию Person
    let buttonAdd: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.darkGray, for: .normal)
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action:  #selector(EditListViewController.shared.tapAddCellInSectionButton), for:.touchDown)
        return button
    }()
    
    //    ФИО человека
    let name: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .systemFont(ofSize: 13)
        text.textColor = UIColor.black
        text.autocapitalizationType = .allCharacters
        text.autocorrectionType = .yes
        text.spellCheckingType = .yes
        text.sizeToFit()
        text.clipsToBounds = true
        text.layer.cornerRadius = 4
        text.backgroundColor = #colorLiteral(red: 0.9304324985, green: 0.919935286, blue: 1, alpha: 1)
        text.textAlignment = .natural
        return text
    }()
    
    //    вью для добавления кнопок и размещения в секции
    let view: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = #colorLiteral(red: 0.910679996, green: 0.8889362812, blue: 1, alpha: 1)
        return view
    }()
    
    //    для создания секции
    func setupSection(withTitle title: String, section: Int, delegate: ExpandebleEditListHeaderFooterViewDelegate) {
        self.delegate = delegate
        self.section = section
        self.name.text = title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        внешний вид секции
        contentView.backgroundColor = .clear
        DispatchQueue.main.async {
            self.addSectionView()
        }
    }
    
    //    инициализация ячеек по нажатию на секцию
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        guard let section = section else {return}
        delegate?.toggleSection(header: self, section: section)
//        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ExpandebleEditListHeaderFooterView {
    
    // MARK: Constraint
    
    func addSectionView() {
        
        contentView.addSubview(view)
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        
        view.addSubview(dellOnePersonButton)
        view.addSubview(name)
        view.addSubview(buttonAdd)
        
        name.topAnchor.constraint(equalTo: view.topAnchor, constant: 2).isActive = true
        name.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -2).isActive = true
        name.rightAnchor.constraint(equalTo: dellOnePersonButton.leftAnchor, constant: -12).isActive = true
        name.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6).isActive = true
        name.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        dellOnePersonButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 2).isActive = true
        dellOnePersonButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -2).isActive = true
        dellOnePersonButton.rightAnchor.constraint(equalTo: buttonAdd.leftAnchor, constant: -4).isActive = true
        dellOnePersonButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        dellOnePersonButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        buttonAdd.topAnchor.constraint(equalTo: view.topAnchor, constant: 2).isActive = true
        buttonAdd.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -2).isActive = true
        buttonAdd.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
//        buttonAdd.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 120).isActive = true
        buttonAdd.widthAnchor.constraint(equalToConstant: 40).isActive = true
        buttonAdd.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    // MARK: Action
    
//    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
//        let cell = gestureRecognizer.view as! ExpandebleEditListHeaderFooterView
//        guard let section = cell.section else {return}
//        delegate?.toggleSection(header: self, section: section)
//    }
    
}
