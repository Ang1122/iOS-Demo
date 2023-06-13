//
//  ViewController.swift
//  iOS Demo
//
//  Created by c-Ang on 2023/6/13.
//
import UIKit
import SnapKit
import YYWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let data: [(text: String, imageUrl: String)] = [
        (text: "朝霞", imageUrl: "https://images.unsplash.com/photo-1675993681314-ea3aa3675e00?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8bW9ybmluZyUyMGdsb3d8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60"),
        (text: "晚霞", imageUrl: "https://images.unsplash.com/photo-1528022818011-8374ef7cc92e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fGV2ZW5pbmclMjBnbG93fGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60"),
        (text: "海洋", imageUrl: "https://images.unsplash.com/photo-1488278905738-514111aa236c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fG9jZWFufGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60"),
        (text: "黄河", imageUrl: "https://th.bing.com/th/id/OIP.ug0zhkcmx_7dJAKx4BBfOwHaE8?w=262&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7"),
        (text: "长江", imageUrl: "https://th.bing.com/th/id/OIP._rKkq6Kiq1Jw9bVOPvXhdwHaGm?w=202&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7"),
        (text: "岛屿", imageUrl: "https://images.unsplash.com/photo-1553603227-2358aabe821e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8aXNsYW5kfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60"),
        (text: "山川", imageUrl: "https://th.bing.com/th/id/OIP.Xa2OLK_S48MurWK7bXz6cwHaE8?w=302&h=201&c=7&r=0&o=5&dpr=1.3&pid=1.7"),
        (text: "草原", imageUrl: "https://th.bing.com/th/id/OIP.zfxO47wZXlSNPS0_5tXlsgHaE8?w=268&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7"),
        (text: "云层", imageUrl: "https://images.unsplash.com/photo-1501630834273-4b5604d2ee31?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2xvdWRzfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60"),
        (text: "雪山", imageUrl: "https://images.unsplash.com/photo-1512273222628-4daea6e55abb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8c25vdyUyMG1vdW50YWlufGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60"),
        (text: "南极", imageUrl: "https://images.unsplash.com/photo-1632347562052-83f2d630ac03?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8YW50YXJjdGljYSUyMGljZWJlcmclMjBwZW5pbnN1bGF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60"),
        (text: "银河", imageUrl: "https://images.unsplash.com/photo-1536108978996-128e3e2a9783?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dGhlJTIwTWlsa3klMjBXYXl8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60"),
        (text: "园林", imageUrl: "https://th.bing.com/th/id/OIP.mHMPWZieItYmQqJIzH7M9QHaFN?w=264&h=185&c=7&r=0&o=5&dpr=1.3&pid=1.7"),
        (text: "田地", imageUrl: "https://th.bing.com/th/id/OIP.OK6LTab0D9VVn6XMechjSQHaE6?w=261&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7"),
        (text: "宫殿", imageUrl: "https://th.bing.com/th/id/OIP.uz50vQHx83sAEGjvRCDzgwHaFj?w=203&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7"),
        (text: "长城", imageUrl: "https://th.bing.com/th/id/OIP.wKZRbUhlEDaqJpt7uuSX6wHaE7?w=292&h=194&c=7&r=0&o=5&dpr=1.3&pid=1.7"),
        (text: "校园", imageUrl: "https://th.bing.com/th/id/OIP.fdtxrI8i_EU_jld2GrKi9AHaEo?w=293&h=183&c=7&r=0&o=5&dpr=1.3&pid=1.7"),
        (text: "城市", imageUrl: "https://th.bing.com/th/id/OIP.eagw2ojbsVnDe7DjqGXapAHaFZ?w=216&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7")
    ]

    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let item = data[indexPath.row]
        cell.configure(text: item.text, imageUrl: item.imageUrl)
        return cell
    }
    
    // MARK: - UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = data[indexPath.row]
        let detailVC = DetailViewController(text: item.text, imageUrl: item.imageUrl)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
