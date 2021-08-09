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
    
    let secondVC = UIStoryboard(name: "SecondView", bundle: nil)
        .instantiateViewController(identifier: "SecondViewController") as SecondViewController
    
    let thirdVC = UIStoryboard(name: "ThirdView", bundle: nil)
        .instantiateViewController(identifier: "ThirdViewController") as ThirdViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSideMenu()
    }
}

extension TopViewController: MenuControllerDelegate {
    @IBAction func didTapMenuButton() {
        present(sideMenu!, animated: true)
    }
    
    func tappedMenuItems(title: String) {
        sideMenu?.dismiss(animated: true, completion: { [weak self] in

            self?.title = title

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
    
    func setupSideMenu() {
        let menu = MenuController(with: ["top","second","third"])
        
        menu.menuControllerDelegate = self
        
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        addChildController()
    }
    
    
    private func addChildController() {
        createChildControllre(controllerName: secondVC)
        createChildControllre(controllerName: thirdVC)
    }
    
    private func createChildControllre(controllerName: UIViewController) {
        addChild(controllerName)
        view.addSubview(controllerName.view)
        controllerName.didMove(toParent: self)
        controllerName.view.frame = view.bounds
        controllerName.view.isHidden = true
    }
}
