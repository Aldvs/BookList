//
//  MainViewController.swift
//  BookList
//
//  Created by admin on 15.09.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var data: [ModelBook] = []
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        fetchData(from: Link.bookListApi.rawValue)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.sectionInset = Constants.sectionInsets
        layout.minimumLineSpacing = Constants.bookMinimumLineSpacing
        layout.itemSize = CGSize(width: Constants.itemWidth,
                                 height: Constants.itemHeight)

        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)

        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.reuseId)

        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.showsVerticalScrollIndicator = false
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.reuseId,
                                                      for: indexPath) as! BookCollectionViewCell
        cell.configure(with: data[indexPath.row])
        return cell
    }
    
    private func setupNavigationBar() {
        title = "Список книг"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearence = UINavigationBarAppearance()
        navBarAppearence.configureWithOpaqueBackground()
        navBarAppearence.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navBarAppearence.backgroundColor = UIColor(
            red: 21/255,
            green: 101/255,
            blue: 192/255,
            alpha: 194/255
        )
        
        navigationController?.navigationBar.standardAppearance = navBarAppearence
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearence
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Выйти",
            style: .plain,
            target: self,
            action: #selector(logOut)
        )
        navigationController?.navigationBar.tintColor = .white
    }

    @objc private func logOut() {
        dismiss(animated: true)
//        let newTaskVC = TaskViewController()
//        newTaskVC.modalPresentationStyle = .fullScreen
//        present(newTaskVC, animated: true)
    }

    //MARK: - Network Methods
    private func fetchData(from url: String) {
        NetworkManager.shared.fetchDataAlamofire(from: url) { result in
            switch result {
            case .success(let listData):
                self.data = listData
                print(self.data)
                self.collectionView?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
