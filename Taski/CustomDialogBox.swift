//
//  CustomDialogView.swift
//  Animation
//
//  Created by Noura Abdualaziz on 12/04/2020.
//  Copyright © 2020 Noura Aziz. All rights reserved.
//

import Foundation
import UIKit

class CustomAlert: UIView, Modal, UITextViewDelegate {
var backgroundView = UIView()
var dialogView = UIView()

let dateTextField = UITextField()

convenience init(title:String,image:UIImage) {
    self.init(frame: UIScreen.main.bounds)
    initialize(title: title, image: image)
    
}
override init(frame: CGRect) {
    super.init(frame: frame)
}

required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    fatalError("init(coder:) has not been implemented")
}


func initialize(title:String, image:UIImage){
    dialogView.clipsToBounds = true
    
    backgroundView.frame = frame
    backgroundView.backgroundColor = UIColor.black
    backgroundView.alpha = 0.6
    backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
    addSubview(backgroundView)
    
    let dialogViewWidth = frame.width-64
    
    let titleLabel = UILabel(frame: CGRect(x: 8, y: 8, width: dialogViewWidth-16, height: 30))
    titleLabel.text = title
    titleLabel.textAlignment = .center
//    dialogView.addSubview(titleLabel)
    
    let separatorLineView = UIView()
    separatorLineView.frame.origin = CGPoint(x: 0, y: titleLabel.frame.height + 15)
    separatorLineView.frame.size = CGSize(width: dialogViewWidth, height: 1)
    separatorLineView.backgroundColor = UIColor.groupTableViewBackground
    dialogView.addSubview(separatorLineView)
    
    let imageView = UIImageView()
    imageView.frame.origin = CGPoint(x: 8, y: 8)
    imageView.frame.size = CGSize(width: 30, height: 30)
    imageView.tintColor = UIColor.white
    imageView.image = image
    imageView.layer.cornerRadius = imageView.frame.width / 2
    imageView.backgroundColor = UIColor.systemPink
    dialogView.addSubview(imageView)
    
    dateTextField.frame = CGRect(x: imageView.frame.origin.y + 40, y: 8, width: dialogViewWidth-30, height: 30)
    
    //date text
    let dateformatter = DateFormatter()
    dateformatter.locale = Locale(identifier: "en_US_POSIX")
    dateformatter.dateFormat = "yyyy-MM-dd | h:mm a"
    dateformatter.amSymbol = "AM"
    dateformatter.pmSymbol = "PM"
    let today = dateformatter.string(from: Date())
    dateTextField.text = today
    dateTextField.font = UIFont(name: "System", size: 13)
    dateTextField.textColor = UIColor.systemPink
    dateTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
    dialogView.addSubview(dateTextField)
    
    let textView = UITextView()
    textView.delegate = self
    textView.frame.origin = CGPoint(x: 8, y: separatorLineView.frame.height + separatorLineView.frame.origin.y + 8)
    textView.frame.size = CGSize(width: dialogViewWidth - 16 , height: 100)
    textView.backgroundColor = UIColor.groupTableViewBackground
    
    textView.text = "Reminder me ...."
    textView.textColor = UIColor.lightGray
    
    textView.becomeFirstResponder()
    textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
    
    textView.layer.cornerRadius = 4
    textView.clipsToBounds = true
    dialogView.addSubview(textView)
    
    let addButton = UIButton(frame: CGRect(x: 8, y: textView.frame.height + textView.frame.origin.y + 8, width: dialogViewWidth - 16, height: 30))
    addButton.backgroundColor = UIColor.systemPink
    addButton.layer.cornerRadius = 4
    addButton.setTitle("Add", for: .normal)
    addButton.tintColor = UIColor.white
    dialogView.addSubview(addButton)
    
    let dialogViewHeight = titleLabel.frame.height + 8 + separatorLineView.frame.height + 8 + textView.frame.height + 8 + addButton.frame.height + 16
    
    dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
    dialogView.frame.size = CGSize(width: frame.width-64, height: dialogViewHeight)
    dialogView.backgroundColor = UIColor.white
    dialogView.layer.cornerRadius = 6
    addSubview(dialogView)
}

    @objc func didTappedOnBackgroundView(){
    dismiss(animated: true)
}
    @objc func tapDone() {
        if let datePicker = self.dateTextField.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.locale = Locale(identifier: "en_US_POSIX")
            dateformatter.dateFormat = "yyyy-MM-dd | h:mm a"
            dateformatter.amSymbol = "AM"
            dateformatter.pmSymbol = "PM"
            datePicker.minimumDate = Date()
            self.dateTextField.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.dateTextField.resignFirstResponder() // 2-5
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Reminder me ...."
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {

            textView.text = "Reminder me ...."
            textView.textColor = UIColor.lightGray

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }

        // Else if the text view's placeholder is showing and the
        // length of the replacement string is greater than 0, set
        // the text color to black then set its text to the
        // replacement string
         else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }

        // For every other case, the text should change with the usual
        // behavior...
        else {
            return true
        }

        // ...otherwise return false since the updates have already
        // been made
        return false
    }
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
}
