//
//   CustomTableViewCell.swift
//  iOS Demo
//
//  Created by c-Ang on 2023/6/13.
//

import UIKit
import YYWebImage

class CustomTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellImageView)
        contentView.addSubview(titleLabel)
        
        cellImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(cellImageView.snp.trailing).offset(16)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(text: String, imageUrl: String) {
        titleLabel.text = text
        if let url = URL(string: imageUrl) {
            cellImageView.yy_setImage(with: url, options: YYWebImageOptions.setImageWithFadeAnimation)
        }
    }
}

