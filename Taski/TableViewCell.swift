//
//  TableViewCell.swift
//  MVC
//
//  Created by Mark Moeykens on 5/2/17.
//  Copyright © 2017 Moeykens. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var data1Label: UILabel!
    @IBOutlet weak var data2Label: UILabel!
    @IBOutlet weak var profileImagesStackView: UIStackView!
    
    func setup(model: Model) {
        titleLabel.text = model.title
        
        if model.subTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            subtitleLabel.isHidden = true
        } else {
            subtitleLabel.isHidden = false
             subtitleLabel.text = model.subTitle
        }
        
        if model.images.count > 0 {
            imageView?.translatesAutoresizingMaskIntoConstraints = false
            for image in model.images {
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
                imageView.image = image
                imageView.layer.borderColor = UIColor.lightGray.cgColor
                imageView.layer.borderWidth = 1
                imageView.layer.cornerRadius = 16
                imageView.clipsToBounds = true
                let height = imageView.heightAnchor.constraint(equalToConstant: 36)
                let width = imageView.widthAnchor.constraint(equalToConstant: 36)
                NSLayoutConstraint.activate([height, width])
                profileImagesStackView.addArrangedSubview(imageView)
            }
        }
       
        data1Label.text = model.data1
        data2Label.text = model.data2
    }
}
