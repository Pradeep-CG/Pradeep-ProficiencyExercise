//
//  CanadaTableViewCell.swift
//  Pradeep-ProficiencyExercise
//
//  Created by Pradeep on 03/07/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit

class CanadaTableViewCell: UITableViewCell {
    let rowImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = Constants.imageCornerRadius
        img.clipsToBounds = true
        return img
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        label.numberOfLines = Constants.numberOfLines
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var rowData: CanadaRowModel? {
        didSet {
            titleLabel.text = rowData?.title
            descriptionLabel.text = rowData?.rowDescription
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(rowImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        rowImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        rowImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.leadingValue).isActive = true
        rowImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth).isActive = true
        rowImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Constants.leadingValue).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: rowImageView.rightAnchor, constant: Constants.trailingValue).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -Constants.leadingValue).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: Constants.titleLabelHeight).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: Constants.vertialGap).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: rowImageView.rightAnchor, constant: Constants.trailingValue).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -Constants.leadingValue).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -Constants.leadingValue).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
