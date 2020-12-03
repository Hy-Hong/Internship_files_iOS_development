//
//  ViewController.swift
//  unsplash
//
//  Created by Hy Horng on 10/26/20.
//  Copyright © 2020 Hy Horng. All rights reserved.
//

import UIKit
import SDWebImage

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showViewController()
    }
    
    func showViewController() {

        let vc1 = UINavigationController(rootViewController: FirstViewController())
        let vc2 = UINavigationController(rootViewController: SecondViewController())
        let vc3 = UINavigationController(rootViewController: ThirdViewController())
        
        vc1.title = "Photos"
        vc2.title = "Collections"
        vc3.title = "Search"
        
        viewControllers = [vc1, vc2, vc3]
//        tabBarVC.setViewControllers([vc1, vc2, vc3], animated: false)
        
        guard let items = tabBar.items else {
            return
        }
//
        let images = ["photo", "collection", "search"]
        items[0].image = UIImage(named: images[0])
        items[1].image = UIImage(named: images[1])
        items[2].image = UIImage(named: images[2])
//
//        for x in 0..<items.count {
//            items[0].badgeValue = "1"
//            items[1].badgeValue = "3"
//            items[2].badgeValue = "2"
//            items[x].image = UIImage(named: images[x])
//        }
//
//        tabBarVC.modalPresentationStyle = .fullScreen
        tabBar.barTintColor = UIColor.darkText
//        present(tabBarVC, animated: true)
    }
    
//    @objc func Tapped1() {
//        print("Tapped1")
//    }
}

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        title = "Photo"
    }
}

//Custom secondViewConstroller
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

struct Hero: Decodable {
    let localized_name: String
    let img: String
}

class SecondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var secondCollectionView: UICollectionView!
    let cell = "cellId"
    var heroes = [Hero]()
    
    let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTitleLabel()
        
        let attributedString = NSMutableAttributedString(string: "Explore")
        
        let textAttachment = NSTextAttachment()
        
        textAttachment.image = UIImage(named: "g0")
        
        let attrStringWithImage = NSAttributedString(attachment: textAttachment)
        
        attributedString.replaceCharacters(in: NSMakeRange(4, 1), with: attrStringWithImage)
        
        //create a new button
        let button: UIButton = UIButton(type: .custom)
        
        //set image for button
        button.setImage(UIImage(named: "fb.png"), for: UIControl.State.normal)
        
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let barButton = UIBarButtonItem(customView: button)
        
        //assign button to navigationbar
        self.navigationItem.leftBarButtonItem = barButton
        
        //Set up layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 145, height: 145)
        
        secondCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.secondCollectionView.delegate = self
        self.secondCollectionView.dataSource = self
        secondCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: self.cell)
        self.view.addSubview(secondCollectionView)
        
        // declear a variable to store url
        let urlString = URL(string: "https://api.opendota.com/api/heroStats")
        URLSession.shared.dataTask(with: urlString!) { (data, response, error) in
            if error == nil {
                do {
                    self.heroes = try JSONDecoder().decode([Hero].self, from: data!)
                }catch {
                    print("Parse Error")
                }
                DispatchQueue.main.sync {
                    self.secondCollectionView.reloadData()
                }
            }
        }.resume()
    }
    
    func customTitleLabel() {
        
        // Create a navView to add to the navigation bar
        let navView = UIView()
        
        // Create the label
        let label = UILabel()
        label.text = "Explore"
        label.sizeToFit()
        label.center = navView.center
        label.textAlignment = NSTextAlignment.left
        
        // Create the image view
        let image = UIImageView()
        image.image = UIImage(named: "g0")
        // To maintain the image's aspect ratio:
        let imageAspect = image.image!.size.width/image.image!.size.height
        // Setting the image frame so that it's immediately before the text:
        image.frame = CGRect(x: 29, y: label.frame.origin.y, width: label.frame.size.height*imageAspect, height: label.frame.size.height)
        image.contentMode = UIView.ContentMode.scaleAspectFit
        
        // Add both the label and image view to the navView
        navView.addSubview(label)
        navView.addSubview(image)
        
        // Set the navigation bar's navigation item's titleView to the navView
        self.navigationItem.titleView = navView
        
        // Set the navView's frame to fit within the titleView
        navView.sizeToFit()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = secondCollectionView.dequeueReusableCell(withReuseIdentifier: self.cell, for: indexPath) as! PhotoCollectionViewCell
        cell.layer.cornerRadius = 10
        cell.backgroundColor = UIColor.red
//        cell.bgImage?.image = images[indexPath.item]
        cell.label?.text = heroes[indexPath.item].localized_name.capitalized
        
        let defualtLink = "https://api.opendota.com"
        let imageLink = defualtLink + heroes[indexPath.item].img
        //        cell.imageView.downloadedFrom(link: imageLink)
        cell.bgImage?.sd_setImage(with: URL(string: imageLink), placeholderImage: nil)
        cell.bgImage?.sd_imageIndicator = SDWebImageActivityIndicator.white
        
        cell.backgroundView = imageView

        return cell
    }
    
}

class ThirdViewController: UIViewController {
    
    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 140, green: 239, blue: 244, alpha: 1)
        
        //add shadow bar
        
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.6
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        self.navigationController?.navigationBar.layer.shadowRadius = 1.5
        
        // add imageView
        assignbackground()
        
        //add text label
        let myLabel: UILabel = {
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Search Unsplash"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12)
            label.font = UIFont.boldSystemFont(ofSize: 30)
            return label
        }()
        
        view.addSubview(myLabel)
        
        // Set its constraint to display it on screen
        myLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        myLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        myLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -180).isActive = true
        
        searchBar.placeholder = "Search Unsplash"
        
        //create a new button
        let button: UIButton = UIButton(type: .custom)
        
        //set image for button
        button.setImage(UIImage(named: "fb.png"), for: UIControl.State.normal)
        
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let barButton = UIBarButtonItem(customView: button)
        
        //assign button to navigationbar
        self.navigationItem.leftBarButtonItem = barButton
        
    }
    
    func assignbackground(){
        let background = UIImage(named: "waterfall")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 1
        let nav = self.navigationController?.navigationBar
        // 2
        nav?.barTintColor = .white
        
        // 3
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit
        
        // 4
//        let image = UIImage(named: "fb.png")
//        imageView.image = image
        
        // 5
        navigationItem.titleView = searchBar
        
    }
    
    
}

