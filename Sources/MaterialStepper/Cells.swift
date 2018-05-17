//
//  ElementCell.swift
//  MaterialStepper
//
//  Created by julien on 16/05/2018.
//  Copyright © 2018 juliensimmer. All rights reserved.
//

import UIKit

protocol ElementCellDelegate: class {
    func didSwitch(to isOn: Bool, indexRow: Int)
}

class ElementCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activateSwitch: UISwitch!
    
    weak var delegate: ElementCellDelegate?
    var indexRow: Int = 0
    
    public func setup(forElement element: Element, indexRow idx: Int) {
        titleLabel.text = element.title
        activateSwitch.isOn = element.isActivate
        indexRow = idx
    }
    
    @IBAction func didChangeSwitchValue(_ sender: Any) {
        delegate?.didSwitch(to: activateSwitch.isOn, indexRow: indexRow)
    }
}

class SectionCellInElementTable: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    public func setup(title: String) {
        titleLabel.text = title
    }
}

class SectionCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var aboveTrait: UIView!
    @IBOutlet weak var belowtrait: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        // nothing
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        // nothing
    }
    
    public func setup(forTitle: String, atIndexRow: Int, over: Int, highlight: Bool) {
        titleLabel.text = forTitle
        aboveTrait.isHidden = atIndexRow == 0
        belowtrait.isHidden = atIndexRow + 1 == over
        numberLabel.text = "\(atIndexRow + 1)"
        titleLabel.font = highlight ? UIFont.boldSystemFont(ofSize: 15) : UIFont.systemFont(ofSize: 15)
        numberLabel.backgroundColor = highlight ? Color.smoothWhite : Color.grey800
        numberLabel.textColor = highlight ? Color.grey800 : Color.smoothWhite
    }
}

