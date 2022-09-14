//
//  UICollectionCollectionViewController.swift
//  BookList
//
//  Created by admin on 13.09.2022.
//

import UIKit

class BookListCollectionViewController: UICollectionViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.reuseId)
        
    }
    //MARK: - NavigationBar
        private func setupNavigationBar() {
            title = "Список книг"
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

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.reuseId, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
