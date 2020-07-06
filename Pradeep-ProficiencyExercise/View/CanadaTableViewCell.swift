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
        img.layer.cornerRadius = 15
        img.clipsToBounds = true
        return img
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        label.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        label.numberOfLines = 0
        label.textColor =  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
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
        // swiftlint:disable:next line_length
        rowImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.leadingValue).isActive = true
        rowImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth).isActive = true
        rowImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight).isActive = true
        // swiftlint:disable:next line_length
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Constants.leadingValue).isActive = true
        // swiftlint:disable:next line_length
        titleLabel.leftAnchor.constraint(equalTo: rowImageView.rightAnchor, constant: Constants.trailingValue).isActive = true
        // swiftlint:disable:next line_length
        titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -Constants.leadingValue).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 35).isActive = true
        // swiftlint:disable:next line_length
        descriptionLabel.leftAnchor.constraint(equalTo: rowImageView.rightAnchor, constant: Constants.trailingValue).isActive = true
        // swiftlint:disable:next line_length
        descriptionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -Constants.leadingValue).isActive = true
        // swiftlint:disable:next line_length
        descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -Constants.leadingValue).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
