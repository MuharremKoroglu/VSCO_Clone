//
//  HomeScreen.swift
//  VSCO Clone
//
//  Created by Muharrem Köroğlu on 9.01.2023.
//

import UIKit

class HomeScreen: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var feedCollection: UICollectionView!
    
    var posts = [PostModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedCollection.delegate = self
        feedCollection.dataSource = self
        
        let post1 = PostModel(postImage: UIImage(named: "image6")!, postComment: "Awesome", postOwner: "Muharrem Koroglu")
        let post2 = PostModel(postImage: UIImage(named: "image6")!, postComment: "Awesome", postOwner: "Muharrem Koroglu")
        let post3 = PostModel(postImage: UIImage(named: "image6")!, postComment: "Awesome", postOwner: "Muharrem Koroglu")
        let post4 = PostModel(postImage: UIImage(named: "image6")!, postComment: "Awesome", postOwner: "Muharrem Koroglu")
        let post5 = PostModel(postImage: UIImage(named: "image6")!, postComment: "Awesome", postOwner: "Muharrem Koroglu")
        let post6 = PostModel(postImage: UIImage(named: "image6")!, postComment: "Awesome", postOwner: "Muharrem Koroglu")
        
        posts.append(post1)
        posts.append(post2)
        posts.append(post3)
        posts.append(post4)
        posts.append(post5)
        posts.append(post6)
       

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = feedCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PostCell
        cell.userName.text = posts[indexPath.row].postOwner
        cell.comment.text = posts[indexPath.row].postComment
        cell.postImage.image = posts[indexPath.row].postImage
        return cell
    }


}
