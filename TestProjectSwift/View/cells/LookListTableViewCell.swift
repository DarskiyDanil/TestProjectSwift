//
//  LookListTableViewCell.swift
//  TestProjectSwift
//
//  Created by  Данил Дарский on 13.03.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

class LookListTableViewCell: UITableViewCell {
    
    //    id ячейки
    static let idCell = "LookListTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
