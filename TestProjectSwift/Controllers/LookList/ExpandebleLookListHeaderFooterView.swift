//
//  ExpandebleLookListHeaderFooterView.swift
//  TestProjectSwift
//
//  Created by  Данил Дарский on 20.03.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

// для скрытия и отображения ячеек в секции
protocol ExpandebleLookListHeaderFooterViewDelegate {
    func toggleSection(header: ExpandebleLookListHeaderFooterView, section: Int)
}

class ExpandebleLookListHeaderFooterView: UITableViewHeaderFooterView {
    
    var delegate: ExpandebleLookListHeaderFooterViewDelegate?
    var section: Int?
    
    //    для редактирования
    let buttonCorrect: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action:  #selector(LookListViewController.shared.tapButtonCorrect), for:.touchDown)
        button.setImage(UIImage(systemName: "pencil.and.ellipsis.rectangle"), for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    //    ФИО человека
    let name: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = .darkGray
        lbl.textAlignment = .natural
        return lbl
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
    func setupSection(withTitle title: String, section: Int, delegate: ExpandebleLookListHeaderFooterViewDelegate) {
        self.delegate = delegate
        self.section = section
        self.name.text = title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .clear
        DispatchQueue.main.async {
            self.addSectionView()
        }
    }
    
    //    инициализация ячеек по нажатию на секцию
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ExpandebleLookListHeaderFooterView {
    
    // MARK: Constraint
    
    func addSectionView() {
        contentView.addSubview(view)
        view.addSubview(buttonCorrect)
        view.addSubview(name)
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        
        name.topAnchor.constraint(equalTo: view.topAnchor, constant: 2).isActive = true
        name.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -2).isActive = true
        name.rightAnchor.constraint(equalTo: buttonCorrect.leftAnchor, constant: -14).isActive = true
        name.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        name.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        buttonCorrect.topAnchor.constraint(equalTo: view.topAnchor, constant: 2).isActive = true
        buttonCorrect.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -2).isActive = true
        buttonCorrect.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        buttonCorrect.widthAnchor.constraint(equalToConstant: 40).isActive = true
        buttonCorrect.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    // MARK: Action
    
    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! ExpandebleLookListHeaderFooterView
        guard let section = cell.section else {return}
        delegate?.toggleSection(header: self, section: section)
    }
    
}
