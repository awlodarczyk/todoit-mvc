//
//  ToDoHeaderView.swift
//  todo
//
//  Created by Adam Wlodarczyk on 28/03/2019.
//  Copyright © 2019 Adam Wlodarczyk. All rights reserved.
//

import UIKit
import Material
import SnapKit
import SCLAlertView


protocol HeaderViewDelegate {
    func itemCreated(name: String)
}
class ToDoHeaderView: UIView {
    let CONTENT_XIB_NAME = "ToDoHeaderView"
    let color = UIColor.init(red: 1/255, green: 183/255, blue: 210/255, alpha: 1.0)
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var itemNameTextField: TextField!
    
    @IBOutlet weak var addButton: RaisedButton!
    

    var delegate: HeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
  
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
extension ToDoHeaderView: TextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.addItemAction(textField)
        self.endEditing(true)
        return true
    }
}
extension ToDoHeaderView{
    @IBAction func addItemAction(_ sender: Any) {
        if ((self.itemNameTextField?.text) != nil) && !(self.itemNameTextField?.text?.isEmpty ?? true) {
            delegate?.itemCreated(name: self.itemNameTextField.text ?? "")
            self.itemNameTextField.text = ""
            self.endEditing(true)
        } else { showError() }
    }
    func commonInit() {
        Bundle.main.loadNibNamed(CONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        setTextProperties()
    }
    func setTextProperties(){
        itemNameTextField.delegate = self
        itemNameTextField.textColor = .white
        itemNameTextField.tintColor = .white
        itemNameTextField.detailColor = .white
        itemNameTextField.clearButtonMode = .whileEditing
        itemNameTextField.leftViewActiveColor = color
        itemNameTextField.leftViewNormalColor = .white
        itemNameTextField.dividerActiveColor = color
        itemNameTextField.dividerNormalColor = .white
        itemNameTextField.placeholderActiveColor = color
        itemNameTextField.placeholderNormalColor = .white
        
        let leftView = UIImageView()
        leftView.image = Icon.cm.pen
        itemNameTextField.leftView = leftView
        
    }
    func showError(){
        self.endEditing(true)
        SCLAlertView().showError("Ooops!", subTitle: "You have to fill text input before add new item") // Error

    }
}
