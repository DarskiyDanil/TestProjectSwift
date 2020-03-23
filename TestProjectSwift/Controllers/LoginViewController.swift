//
//  LoginViewController.swift
//  TestProjectSwift
//
//  Created by  Данил Дарский on 04.03.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var presentViewController = PresentViewController()
    //    фон-градиент
    var gradientView: GradientView = GradientView(colors: [.orange, .yellow ,.green])
    var timerBool: Bool = false
    
    let progressBar: UIProgressView = {
        let progress = UIProgressView()
        progress.progressTintColor = #colorLiteral(red: 0.5612952709, green: 0.9229263663, blue: 0.3202710152, alpha: 1)
        progress.trackTintColor = .yellow
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.alpha = 0
        progress.setProgress(0, animated: true)
        return progress
    }()
    
    //    для добавления кнопок
    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    //    для отступа от клавиатуры
    var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        return v
    }()
    
    //    имя пользователя
    let lableIog: UITextField = {
        var lbl = UITextField()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.cornerRadius = 8
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.backgroundColor = #colorLiteral(red: 0.8933718801, green: 0.9979824424, blue: 0.7020419836, alpha: 1)
        lbl.text = "123"
        lbl.placeholder = "логин"
        return lbl
    }()
    
    //    пароль пользователя
    let lablePass: UITextField = {
        var lbl = UITextField()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.cornerRadius = 8
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.backgroundColor = #colorLiteral(red: 0.8214086294, green: 1, blue: 0.6834984422, alpha: 1)
        lbl.text = "123"
        lbl.placeholder = "пароль"
        return lbl
    }()
    
    //    вход
    let buttonEnter: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = #colorLiteral(red: 0.8214086294, green: 1, blue: 0.6834984422, alpha: 1)
        button.setTitle("Вход", for: .normal)
        button.addTarget(self, action:  #selector(tapButton), for:.touchDown)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func loadView() {
        self.view = self.gradientView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        DispatchQueue.main.async {
            self.anchorConstrains()
        }
        
        // жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // присваиваем жест нажатия UIScrollVIew
        scrollView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе -- когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
        //     прячем панель вверху
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //      возвращаем верхнюю панель
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}


extension LoginViewController {
    
    // MARK: Constraint
    
    private func anchorConstrains() {
        
        self.view.addSubview(scrollView)
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        
        scrollView.addSubview(contentView)
        
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -0).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        
        contentView.addSubview(lableIog)
        contentView.addSubview(lablePass)
        contentView.addSubview(progressBar)
        
        self.progressBar.bottomAnchor.constraint(equalTo: lableIog.topAnchor, constant: -40).isActive = true
        self.progressBar.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        self.progressBar.heightAnchor.constraint(equalToConstant: 4).isActive = true
        self.progressBar.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 120).isActive = true
        self.progressBar.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -120).isActive = true
        
        self.lableIog.bottomAnchor.constraint(equalTo: lablePass.topAnchor, constant: -40).isActive = true
        self.lableIog.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        self.lableIog.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.lableIog.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 40).isActive = true
        self.lableIog.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -40).isActive = true
        
        self.lablePass.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        self.lablePass.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        self.lablePass.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.lablePass.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 40).isActive = true
        self.lablePass.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -40).isActive = true
        
        contentView.addSubview(buttonEnter)
        
        self.buttonEnter.bottomAnchor.constraint(equalTo: lablePass.bottomAnchor, constant: 80).isActive = true
        self.buttonEnter.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        self.buttonEnter.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.buttonEnter.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 120).isActive = true
        self.buttonEnter.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -120).isActive = true
    }
    
    // MARK: Action
    
    //    при нажатии на кнопку ВХОД
    @objc func tapButton () {
        self.progressBar.alpha = 1
        timerBool = true
        if timerBool {
            Timer.scheduledTimer(timeInterval: 0.1,
                                 target: self,
                                 selector: #selector(updateProgress),
                                 userInfo: nil, repeats: true)
        }
    }
    
    //    движение progressBar
    @objc func updateProgress() {
        if timerBool {
            if progressBar.progress != 1 {
                self.progressBar.progress += 2 / 10
            } else {
                timerBool = false
                self.progressBar.alpha = 0
                if lableIog.text == "123" && lablePass.text == "123"{
                    let transition = CATransition()
                    transition.duration = 0.3
                    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                    transition.type = CATransitionType.fade
                    navigationController?.view.layer.add(transition, forKey: "transition")
                    navigationController?.pushViewController(self.presentViewController, animated: false)
                } else {
                    progressBar.progress = 0
                    print("данные введены неверно")
                    // Создаем контроллер
                    let alert = UIAlertController(title: "Ошибка", message: "Введены неверные данные пользователя", preferredStyle: .alert)
                    // Создаем кнопку для UIAlertController
                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    // Добавляем кнопку на UIAlertController
                    alert.addAction(action)
                    // Показываем UIAlertController
                    present(alert, animated: true, completion: nil)
                    return
                }
            }
        }
    }
    
    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    //    клавиатура
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
}
