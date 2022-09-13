//
//  ViewController.swift
//  BookList
//
//  Created by admin on 13.09.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    //MARK: - NavigationBar
        private func setupNavigationBar() {
            title = "Ваш город"
            navigationController?.navigationBar.prefersLargeTitles = false
            
            let navBarAppearence = UINavigationBarAppearance()
            navBarAppearence.configureWithOpaqueBackground()
            navBarAppearence.titleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            
            navBarAppearence.backgroundColor = UIColor(
                red: 255/255,
                green: 255/255,
                blue: 255/255,
                alpha: 227/255)
            
            navigationController?.navigationBar.standardAppearance = navBarAppearence
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearence
            
            navigationController?.navigationBar.tintColor = .white
            
        }


}

