//
//  EditTableViewCell.swift
//  TestProjectSwift
//
//  Created by  Данил Дарский on 13.03.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

class EditTableViewCell: UITableViewCell {
    
    //    id ячейки
    static let idCell = "EditTableViewCell"
    
    //    текст ячейки
    let textInCell: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .systemFont(ofSize: 13)
        //        text.textAlignment = .center
        text.textColor = UIColor.black
        text.autocapitalizationType = .allCharacters
        text.autocorrectionType = .yes
        text.spellCheckingType = .yes
        text.layer.cornerRadius = 4
        text.backgroundColor = #colorLiteral(red: 0.9516987205, green: 0.9630662799, blue: 1, alpha: 1)
        text.textAlignment = .natural
        text.isEditable = false
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        DispatchQueue.main.async {
            self.textInCellSetup()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: Constraint
extension EditTableViewCell {
    
    func textInCellSetup() {
        contentView.addSubview(textInCell)
        textInCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        textInCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        textInCell.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4).isActive = true
        textInCell.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4).isActive = true
        textInCell.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        textInCell.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
}
