//
//  BookCollectionViewCell.swift
//  BookList
//
//  Created by admin on 13.09.2022.
//

import UIKit
import SnapKit

class BookCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "BookCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 0
        return label
    }()

    private let isbnLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowRadius = 7
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSize(width: 5, height: 8)

        self.clipsToBounds = false
    }
    
    func configure(with modelBook: ModelBook) {
        titleLabel.text = "Название книги: \(modelBook.title)"
        isbnLabel.text = "ISBN: \(modelBook.isbn)"
        authorLabel.text = "Автор: \(modelBook.author)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//contentView.addSubview()
extension BookCollectionViewCell {
    func setupConstraints() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(isbnLabel)
        contentView.addSubview(authorLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-5)
            make.left.equalTo(contentView.snp.left).offset(5)
        }

        isbnLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-5)
            make.left.equalTo(contentView.snp.left).offset(5)
        }

        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(isbnLabel.snp.bottom).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-5)
            make.left.equalTo(contentView.snp.left).offset(5)
        }
    }
}
