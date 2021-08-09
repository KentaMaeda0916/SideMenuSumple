//
//  ViewController.swift
//  SideMenu
//
//  Created by まえけん on 2021/08/08.
//

import UIKit
import SideMenu

class TopViewController: UIViewController {
    
    private var sideMenu: SideMenuNavigationController?
    private var sideMenuPresentationStyle: SideMenuPresentationStyle?
    //　SideMenuから遷移したいView
    let secondVC = UIStoryboard(name: "SecondView", bundle: nil)
        .instantiateViewController(identifier: "SecondViewController") as SecondViewController
    
    let thirdVC = UIStoryboard(name: "ThirdView", bundle: nil)
        .instantiateViewController(identifier: "ThirdViewController") as ThirdViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        // SideMenuの作成
        setupSideMenu()
    }
}

// SideMenu用extention
extension TopViewController: MenuControllerDelegate {
    
    // SideMenu表示ボタン
    @IBAction func sideMenuButton() {
        present(sideMenu!, animated: true)
    }
    
    //　SideMenu表示ボタンを押した時の処理
    func tappedMenuItems(title: String) {
        sideMenu?.dismiss(animated: true, completion: { [weak self] in

            self?.title = title
            
            //選択したView以外を非表示に変更
            func activationMenu(activationMenu: UIViewController?) {
                self?.secondVC.view.isHidden = true
                self?.thirdVC.view.isHidden = true

                activationMenu?.view.isHidden = false
            }
            
            switch title {

            case "top":
                activationMenu(activationMenu: nil)
            
            case "second":
                activationMenu(activationMenu: self?.secondVC)
            
            case "third":
                activationMenu(activationMenu: self?.thirdVC)
            
            default: break
            }
        })
    }
    
    //　SideMenuの設定
    func setupSideMenu() {
        let menu = MenuController(with: ["top","second","third"])
        
        menu.menuControllerDelegate = self
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        
        //　SideMenuのカスタマイズ
        //　左側に表示
        sideMenu?.leftSide = true
        //　元のViewに重なるように表示
        sideMenu?.presentationStyle = .menuSlideIn
        
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        //　子Viewの追加
        addChildController()
    }
    
    //　子Viewの追加
    private func addChildController() {
        createChildControllre(controllerName: secondVC)
        createChildControllre(controllerName: thirdVC)
    }
    
    //　子Viewの設定
    private func createChildControllre(controllerName: UIViewController) {
        addChild(controllerName)
        view.addSubview(controllerName.view)
        controllerName.didMove(toParent: self)
        controllerName.view.frame = view.bounds
        controllerName.view.isHidden = true
    }
}
