//
//  UserQuestionsVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 3/2/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class UserQuestionsVC: UIViewController {
//MARK: Properties
    var questions: [(question: QuizQuestion, answer: String)] = []
//MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    var sizePicker = UIPickerView()
    var selectedIndex: Int = 0
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
//MARK: Navigation
    
//MARK: Private Methods
    fileprivate func setupViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: UserQuestionsCell.identifier, bundle: nil), forCellReuseIdentifier: UserQuestionsCell.identifier)
        sizePicker.delegate = self
        self.title = "Find the Right Portfolio"
        self.navigationController!.navigationBar.isTranslucent = false
//        table.register(BoxCell.self, forCellReuseIdentifier: BoxCell.identifier)
        tableView.tableFooterView = UIView()
        continueButton.isMainButton()
        continueButton.setTitle("Next", for: .normal)
        createQuestions()
    }
    
    fileprivate func createQuestions() {
        questions = [
            (QuizQuestion(question: "What is your employment status?", answers: ["Working", "Not working", "Prefer not to share"]), ""),
            (QuizQuestion(question: "What is your yearly income", answers: ["less than $10K", "more than $10K", "less than $50K", "less than $100K", "more than $250K", "more than $500K", "more than $1M"]), ""),
            (QuizQuestion(question: "How much is all your stuff worth (Networth)?", answers: ["less than $10K", "more than $10K", "less than $50K", "less than $100K", "more than $250K", "more than $500K", "more than $1M", "more than $1B"]), ""),
            (QuizQuestion(question: "What is your investment goal?", answers: ["High risk", "Medium risk", "Low risk", "Don't care"]), ""),
            (QuizQuestion(question: "What is your level of financial education?", answers: ["Less than 1 month", "Less than 3 months", "Less than 1 year", "Less than 5 years", "More than 5 years"]), ""),
            (QuizQuestion(question: "Initially, how much money do you plan to invest?", answers: ["less than $10K", "more than $10K", "less than $50K", "less than $100K", "more than $250K", "more than $500K", "more than $1M", "more than $1B", "morethan $1T"]), ""),
            (QuizQuestion(question: "What access do you need to your Spyyder investments?", answers: ["Everything", "Nothing", "Some things"]), ""),
        ]
        tableView.reloadData()
    }
    
//MARK: IBActions
    
//MARK: Helpers
    @objc func showOptions(controller: UIViewController) {
    }
    
    @objc func handleEndEditing(_ gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

//MARK: Extensions
extension UserQuestionsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath:
        IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
//        answers = questions[indexPath.row].answers //get the answers list
        let cell: UserQuestionsCell = tableView.cellForRow(at: indexPath) as! UserQuestionsCell
        cell.textField.becomeFirstResponder() //activate cell's textfield
        sizePicker.reloadAllComponents() //reload the picker's data
    }
}

extension UserQuestionsVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 //for title and question cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: //if title section
            return 1
        case 1: //if questions cells
            return questions.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: //if title
            let titleCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) //cell from storyboard
            return titleCell
        case 1:
            let cell: UserQuestionsCell = tableView.dequeueReusableCell(withIdentifier: UserQuestionsCell.identifier, for: indexPath) as! UserQuestionsCell
            cell.textField.delegate = self
            let question: QuizQuestion = questions[indexPath.row].question
            cell.populateCell(question: question)
            
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            let flexibleBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.handleEndEditing(_:)))
            toolBar.setItems([flexibleBar, doneButton], animated: true)
            cell.textField.inputAccessoryView = toolBar
            cell.textField.inputView = sizePicker
            cell.textField.clearButtonMode = .never
            let answer = questions[indexPath.row].answer
            cell.textField.text = answer
            print("selected index=", selectedIndex)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

//MARK: PickerView DataSource and Delegate
extension UserQuestionsVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == sizePicker {
            return questions[selectedIndex].question.answers.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == sizePicker {
            return questions[selectedIndex].question.answers[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == sizePicker {
            let answer = questions[selectedIndex].question.answers[row] //assign the answer of the question in the array as the question's answer
            questions[selectedIndex].answer = answer
//            tableView.reloadData()
        }
    }
}

//MARK: TextField
extension UserQuestionsVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        tableView.reloadData() //reload only after editing, or clicking done
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
////        if textField == myTextField {
////            print("You edit myTextField")
////        }
//    }
}
