//
//  PresentViewController.swift
//  TestProjectSwift
//
//  Created by  Данил Дарский on 04.03.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

class PresentViewController: UIViewController, UIToolbarDelegate {
    
    let toolBar =  UIToolbar()
    var bool: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.910679996, green: 0.8889362812, blue: 1, alpha: 1)
        
        DispatchQueue.main.async {
            self.toolBarSetip()
        }
        // жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(toolBarAlfa))
        // присваиваем жест нажатия
        view.addGestureRecognizer(hideKeyboardGesture)
    }
}


extension PresentViewController {
    
    // MARK: Constraint
    
    func toolBarSetip() {
        view.addSubview(toolBar)
        
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.8225412965, green: 0.7370750904, blue: 0.964071691, alpha: 1)
        self.navigationItem.leftItemsSupplementBackButton = true
        self.toolBar.barStyle = .default
        self.toolBar.isTranslucent = true
        self.toolBar.backgroundColor = #colorLiteral(red: 0.910679996, green: 0.8889362812, blue: 1, alpha: 1)
        self.toolBar.tintColor = .systemBlue
        self.toolBar.sizeToFit()
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        toolBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        toolBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        
        //        настройка кнопок
        let editImageForButton = UIImage(systemName: "square.and.pencil")
        let lookImageForButton = UIImage(systemName: "eyeglasses")
        let aboutProgrammImageForButton = UIImage(systemName: "info.circle")
        let editButton = UIBarButtonItem(title: nil, style: .done, target: self, action: #selector (tapEditButton))
        editButton.image = editImageForButton
        let lookButton = UIBarButtonItem(title: nil, style: .done, target: self, action: #selector (tapLookButton))
        lookButton.image = lookImageForButton
        let aboutProgrammButton = UIBarButtonItem(title: nil, style: .done, target: self, action: #selector (tapbAoutProgrammButton))
        aboutProgrammButton.image = aboutProgrammImageForButton
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        self.toolBar.setItems([editButton, lookButton, flexibleSpace, aboutProgrammButton], animated: false)
        self.toolBar.isUserInteractionEnabled = true
    }
    
    // MARK: Action
    
    @objc func tapEditButton () {
        navigationController?.pushViewController(EditListViewController(), animated: true)
    }
    
    @objc func tapLookButton () {
        navigationController?.pushViewController(LookListViewController(), animated: true)
    }
    
    //    появление toolBar
    @objc func toolBarAlfa() {
        self.bool = !bool
        if bool {
            self.toolBar.alpha = 0
        } else {
            self.toolBar.alpha = 1
        }
    }
    
    //    Аллерт
    @objc func tapbAoutProgrammButton () {
        // Создаем контроллер
        let alert = UIAlertController(title: "тестовое приложение", message: "Собрано из травы, палок и танцев с бубном \n Благодарю за внимание!", preferredStyle: .alert)
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // Добавляем кнопку на UIAlertController
        alert.addAction(action)
        // Показываем UIAlertController
        present(alert, animated: true, completion: nil)
    }
    
}
