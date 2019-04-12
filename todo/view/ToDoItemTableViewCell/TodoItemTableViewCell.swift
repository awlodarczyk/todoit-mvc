//
//  TodoItemTableViewCell.swift
//  todo
//
//  Created by Adam Wlodarczyk on 27/03/2019.
//  Copyright © 2019 Adam Wlodarczyk. All rights reserved.
//

import UIKit
import Material

class TodoItemTableViewCell: UITableViewCell {
 
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priorityView: UIView!
    let formatter = DateFormatter()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(item: TodoItem, atIndex:Int){
        indexLabel.text = "\(atIndex+1)"
        let date = formatter.string(from: item.createdAt as Date)
        var attrNameString: NSAttributedString?
        var attrDateString: NSAttributedString?
        var priorityColor:UIColor?
        switch item.priority {
        case .urgent:
            priorityColor = Color.red.base
            break
        case .important:
            priorityColor = Color.orange.base
            break
        default:
            priorityColor = Color.lightGreen.base
        }
        if item.done{
           attrNameString = NSAttributedString(string: item.name, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,NSAttributedString.Key.foregroundColor : UIColor.gray])
           attrDateString = NSAttributedString(string: date, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,NSAttributedString.Key.foregroundColor : UIColor.gray])
        }else{
            attrNameString = NSAttributedString(string:  item.name, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
            
            attrDateString = NSAttributedString(string: date, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        }
        nameLabel.attributedText = attrNameString
        dateLabel.attributedText = attrDateString
        priorityView.backgroundColor = priorityColor
    }
    static func cellFromXib() -> TodoItemTableViewCell{
        let nib = Bundle.main.loadNibNamed(defaultReuseIdentifier(), owner: self, options: nil)! as NSArray
        let cell = nib.object(at: 0) as! TodoItemTableViewCell
        return cell
    }
    static func defaultReuseIdentifier() -> String{
        return "TodoItemTableViewCell"
    }
    static func defaultCellHeight() -> CGFloat{
        return 88.0
    }
}
