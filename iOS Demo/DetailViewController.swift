//
//  DetailViewController.swift
//  iOS Demo
//
//  Created by c-Ang on 2023/6/13.
//


import UIKit
import SnapKit
import YYWebImage

class DetailViewController: UIViewController {
    
    private let text: String
    private let imageUrl: String
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36) // 设置字体大小为 24
        return label
    }()

    private let detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    init(text: String, imageUrl: String) {
        self.text = text
        self.imageUrl = imageUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(detailLabel)
        view.addSubview(detailImageView)
        
        detailLabel.text = text
        if let url = URL(string: imageUrl) {
            detailImageView.yy_setImage(with: url, options: .setImageWithFadeAnimation)
        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        detailImageView.snp.makeConstraints { (make) in
            make.top.equalTo(detailLabel.snp.bottom).offset(50)
            make.width.height.equalTo(300)
            make.centerX.equalToSuperview()
        }
    }
}
