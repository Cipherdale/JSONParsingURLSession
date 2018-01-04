//
//  ItemDetailCell.swift
//  JSONParsingURLSession
//
//  Created by Andrian Rahardja on 04/01/18.
//  Copyright © 2018 episquare. All rights reserved.
//

import UIKit

class ItemDetailCell: UITableViewCell {
    
    let imageCache = NSCache<NSString, AnyObject>()
    
    let itemImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let errorImageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .red
        label.text = "There is no image for this item"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let itemLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var itemData: Items? {
        didSet {
            guard let data = itemData else { return }
            
            downloadImage(urlString: data.itemImageUrl)
            
            let titleAttributedText = NSMutableAttributedString(string: "id: \(data.itemId)", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .regular)])
            titleAttributedText.append(NSAttributedString(string: "\n\n", attributes: [.font: UIFont.systemFont(ofSize: 4)]))
            titleAttributedText.append(NSAttributedString(string: "Brand: \(data.itemBrand)", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .regular)]))
            titleAttributedText.append(NSAttributedString(string: "\n\n", attributes: [.font: UIFont.systemFont(ofSize: 4)]))
            titleAttributedText.append(NSAttributedString(string: "Name: \(data.itemName)", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .regular)]))
            titleAttributedText.append(NSAttributedString(string: "\n\n", attributes: [.font: UIFont.systemFont(ofSize: 4)]))
            titleAttributedText.append(NSAttributedString(string: "Price: \(data.itemPrice),-", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .regular)]))
            titleAttributedText.append(NSAttributedString(string: "\n\n", attributes: [.font: UIFont.systemFont(ofSize: 4)]))
            
            if data.itemDescription != "" {
                titleAttributedText.append(NSAttributedString(string: "Description:\n\(data.itemDescription)", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .regular)]))
            } else {
                titleAttributedText.append(NSAttributedString(string: "Description: N/A", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .regular)]))
            }
            
            itemLabel.attributedText = titleAttributedText
        }
    }
    
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
        errorImageLabel.removeFromSuperview()
        itemLabel.text = ""
    }
    
    private func setupViews() {
        contentView.addSubview(itemImageView)
        contentView.addSubview(itemLabel)
        
        itemImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        itemImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        itemImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        itemImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        itemLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 8).isActive = true
        itemLabel.leftAnchor.constraint(equalTo: itemImageView.leftAnchor, constant: 0).isActive = true
        itemLabel.rightAnchor.constraint(equalTo: itemImageView.rightAnchor, constant: 0).isActive = true
        itemLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
    }
    
    
    
    private func downloadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        proccessImage(url: url)
    }
    
    
    
    private func proccessImage(url: URL) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.itemImageView.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async {
                        self.handleImageError()
                    }
                    return
                }
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    self.imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
                    self.itemImageView.image = imageToCache
                }
                }.resume()
        }
    }
    
    
    
    private func handleImageError() {
        itemImageView.addSubview(errorImageLabel)
        errorImageLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        errorImageLabel.centerXAnchor.constraint(equalTo: itemImageView.centerXAnchor).isActive = true
        errorImageLabel.centerYAnchor.constraint(equalTo: itemImageView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
