//
//  UserQuestionsCell.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 3/2/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class UserQuestionsCell: UITableViewCell {
    
    static let identifier: String = "UserQuestionsCell"
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var textField: UnderlinedTextField!
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    fileprivate func setup() {
        textField.placeholder = "Select..."
    }
    
    func populateCell(question: QuizQuestion) {
        questionLabel.text = question.question
    }
}
