//
//  MainViewController.swift
//  BookList
//
//  Created by admin on 15.09.2022.
//

import UIKit
import SnapKit
import KeychainSwift

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Public Properties
    let keychain = KeychainSwift(keyPrefix: "book_")
    
    //MARK: - Private Properties
    private var data: [ModelBook] = []
    private var collectionView: UICollectionView?
    private var activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        fetchData(from: Link.bookListApi.rawValue)
        setupCollectionView()
        setupIndicator()

    }
    
    //MARK: - Public Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.reuseId,
                                                      for: indexPath) as! BookCollectionViewCell
        cell.configure(with: data[indexPath.row])
        return cell
    }
    
    //MARK: - Private Methods
    private func setupCollectionView() {
        
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
    
    private func setupNavigationBar() {
        title = "Список книг"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearence = UINavigationBarAppearance()
        navBarAppearence.configureWithOpaqueBackground()
        navBarAppearence.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navBarAppearence.backgroundColor = UIColor(
            red: 255/255,
            green: 165/255,
            blue: 0/255,
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
        if let isAuth = keychain.getBool("isAuth"), isAuth {
            keychain.delete("isAuth")
            keychain.set(false, forKey: "isAuth")
            let startVC = UINavigationController(rootViewController: StartViewController())
            startVC.modalPresentationStyle = .fullScreen
            present(startVC, animated: true)
        } else {
            dismiss(animated: true)
        }
    }
    
    private func setupIndicator() {
        collectionView?.addSubview(activityIndicator)
        activityIndicator.color = .orange
        activityIndicator.snp.makeConstraints { make in
            make.centerY.equalTo(view.center.y - 127)
            make.centerX.equalTo(view.center.x)
        }
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }

    //MARK: - Network Method
    private func fetchData(from url: String) {
        NetworkManager.shared.fetchDataAlamofire(from: url) { result in
            switch result {
            case .success(let listData):
                DispatchQueue.main.async {
                    self.data = listData
                    self.activityIndicator.stopAnimating()
                    self.collectionView?.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
