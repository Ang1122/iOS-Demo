//
//  ViewController.swift
//  iOS Demo
//
//  Created by c-Ang on 2023/6/13.
//
import UIKit
import SnapKit
import YYWebImage

class ViewController: UIViewController {

    private let titleLabel1: UILabel = {
        let label = UILabel()
        label.text = "云层"
        label.font = UIFont.systemFont(ofSize: 48)
        return label
    }()
    
    private let titleLabel2: UILabel = {
        let label = UILabel()
        label.text = "山川"
        label.font = UIFont.systemFont(ofSize: 48)
        return label
    }()
    
    private let exampleImageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let exampleImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(titleLabel1)
        view.addSubview(exampleImageView1)
        view.addSubview(titleLabel2)
        view.addSubview(exampleImageView2)

        
        titleLabel1.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
        }
        
        exampleImageView1.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel1.snp.bottom).offset(20)
            make.width.height.equalTo(200)
            make.centerX.equalToSuperview()
        }

        let imageUrl1 = "https://images.unsplash.com/photo-1501630834273-4b5604d2ee31?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2xvdWRzfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60"
        if let url = URL(string: imageUrl1) {
            exampleImageView1.yy_setImage(with: url, options: .setImageWithFadeAnimation)
        }
        
        titleLabel2.snp.makeConstraints { (make) in
            make.top.equalTo(exampleImageView1.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        exampleImageView2.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel2.snp.bottom).offset(20)
            make.width.height.equalTo(200)
            make.centerX.equalToSuperview()
        }
        
        let imageUrl2 = "https://th.bing.com/th/id/OIP.Xa2OLK_S48MurWK7bXz6cwHaE8?w=302&h=201&c=7&r=0&o=5&dpr=1.3&pid=1.7"
        if let url = URL(string: imageUrl2) {
            exampleImageView2.yy_setImage(with: url, options: .setImageWithFadeAnimation)
        }
    }
}
