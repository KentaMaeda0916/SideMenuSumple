//
//  SideMenu.swift
//  SideMenu
//
//  Created by まえけん on 2021/08/08.
//


// 使用ライブラリ　https://github.com/jonkykong/SideMenu


import Foundation
import UIKit

protocol MenuControllerDelegate {
    func tappedMenuItems(title: String)
}

//　Headerの表示内容
class CustomHeaderFooterView: UITableViewHeaderFooterView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .darkGray
    }
}

/// SideMenu用TableView
class MenuController: UITableViewController {
    
    let topViewController = TopViewController()

    public var menuControllerDelegate: MenuControllerDelegate?

    //　cellの中身
    private let menuItems: [String]
    
    init(with menuItems: [String]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Headerの追加
        let xib = UINib(nibName: "CustomHeaderFooterView", bundle: nil)
        tableView.register(xib, forHeaderFooterViewReuseIdentifier: "CustomHeaderFooterView")
        
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = 150
        
        
    }
    
    //　メニューの項目数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    //　cellの内容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.backgroundColor = .systemGray6
        
        return cell
    }

    //　cellが選択された時の動作
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = menuItems[indexPath.row]
        menuControllerDelegate?.tappedMenuItems(title: selectedItem)
    }
    
    //　Headerの表示内容
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderFooterView") as! CustomHeaderFooterView
        return headerFooterView
    }
    
    //
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
