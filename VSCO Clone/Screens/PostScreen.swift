//
//  PostScreen.swift
//  VSCO Clone
//
//  Created by Muharrem Köroğlu on 14.01.2023.
//

import UIKit
import ImageSlideshow
import SDWebImage

class PostScreen: UIViewController{

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var remainingTime: UILabel!
    
    var selectedPost : PostModel?
    var imageInputArray = [SDWebImageSource]()
    var currentIndex = 0

    let imageSlideShow = ImageSlideshow()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let post = selectedPost {
            
         

            for postImage in post.postImage {
                imageInputArray.append(SDWebImageSource(urlString: postImage)!)
            }
            
            remainingTime.text = "Remaining Time: \(selectedPost!.timeDifference)"
            userName.text = "\(post.postOwner)"
            comment.text = "\(selectedPost!.postComment[0])"

            let pageIncdicator = UIPageControl()
            pageIncdicator.currentPageIndicatorTintColor = .gray
            pageIncdicator.pageIndicatorTintColor = .black
            
            
            imageSlideShow.frame = CGRect(x: 10, y: 10, width: view.frame.width * 0.95, height: view.frame.height * 0.58)
            imageSlideShow.pageIndicator = pageIncdicator
            imageSlideShow.backgroundColor = UIColor.white
            imageSlideShow.circular = false
            imageSlideShow.center = CGPoint(x: 197, y: 325)
            imageSlideShow.currentPageChanged = { page in
                self.currentIndex = page
                self.comment.text = "\(post.postComment[self.currentIndex])"
            }
            imageSlideShow.setImageInputs(imageInputArray)
            self.view.addSubview(imageSlideShow)

        }
    }

    
    

}
