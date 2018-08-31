//
//  ViewController.swift
//  FiveStarsDemo
//
//  Created by Public on 2018/8/30.
//  Copyright © 2018年 Public. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var label : UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.label = UILabel.init(frame: CGRect.init(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 30))
        self.label?.textAlignment = .center
        self.label?.text = "当前得分:0.0"
        self.view.addSubview(self.label!)
        
        //总高度为星星的宽度，总宽度为(starWidth+starSpace)*5
        let fiveStar = FiveStars.init(orgin: CGPoint.init(x: (UIScreen.main.bounds.size.width-200)/2, y: 150), starWidth: 35, starSpace: 5, totalPoint: 10, darkImage: UIImage.init(named: "darkStar")!, lightImage: UIImage.init(named: "lightStar")!)
        fiveStar.isTouched = true
        fiveStar.delegate = self
        self.view.addSubview(fiveStar)
        
        
        ///////////////////////////////////////////////////////////////////////////////////////////////////////
        
        let imageView = UIView.init(frame: CGRect.init(x: 10, y: 310, width: 80, height: 80))
        imageView.backgroundColor = UIColor.red
        self.view.addSubview(imageView)
        
        let showStar = FiveStars.init(orgin: CGPoint.init(x: 100, y: 300), starWidth: 20, starSpace: 5, totalPoint: 10, darkImage: UIImage.init(named: "darkStar")!, lightImage: UIImage.init(named: "lightStar")!)
        showStar.currentPoint = 6.8
        self.view.addSubview(showStar)
        
        let starLabel = UILabel.init(frame: CGRect.init(x: 100, y: 330, width: 100, height: 20))
        starLabel.text = "电影评分:"+"\(showStar.currentPoint)"
        starLabel.textColor = UIColor.gray
        self.view.addSubview(starLabel)
        
        let desLabel = UILabel.init(frame: CGRect.init(x: 100, y: 350, width: UIScreen.main.bounds.size.width-110, height: 50))
        desLabel.numberOfLines = 0
        desLabel.text = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
        self.view.addSubview(desLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController:FiveStarsDelegate{
    func currentPointChange(fiveStars: FiveStars, currentPoint: CGFloat) {
        self.label?.text = "当前得分:"+"\(currentPoint)"
    }
}

