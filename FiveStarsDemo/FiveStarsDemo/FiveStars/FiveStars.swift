//
//  FiveStars.swift
//  FiveStarsDemo
//
//  Created by Public on 2018/8/30.
//  Copyright © 2018年 Public. All rights reserved.
//

import UIKit

protocol FiveStarsDelegate:NSObjectProtocol {
    func currentPointChange(fiveStars:FiveStars,currentPoint:CGFloat)
}

class FiveStars: UIView {
    
    weak var delegate:FiveStarsDelegate?
    
    ///是否可以点击,默认为否
    var isTouched : Bool = false{
        didSet{
            self.touchView?.isHidden = !isTouched
        }
    }
    ///当前分数,默认为0
    var currentPoint : CGFloat = 0{
        didSet{
            self.lightStar(point: currentPoint)
            if self.isTouched {
                self.delegate?.currentPointChange(fiveStars: self, currentPoint: currentPoint)
            }
        }
    }
    
    ///总分数
    private var totalPoint : CGFloat = 10
    ///每个星星的间距
    private var starSpcae : CGFloat = 0
    ///星星为正方形，宽度和高度为主视图的高度
    private var starWidth : CGFloat = 0
    private var darkStarImage : UIImage?
    private var lightStarImage : UIImage?
    private var lightStarView : UIView?
    private var touchView : UIView?
    private var positionPoint : CGPoint?
    
    ///必须使用此初始化方法
    init(orgin: CGPoint,starWidth:CGFloat,starSpace:CGFloat,totalPoint:CGFloat,darkImage:UIImage,lightImage:UIImage) {
        //计算总宽度
        super.init(frame: CGRect.init(x: orgin.x, y: orgin.y, width: (starWidth+starSpace)*5, height: starWidth))
        self.starWidth = starWidth
        self.starSpcae = starSpace
        self.totalPoint = totalPoint
        self.darkStarImage = darkImage
        self.lightStarImage = lightImage
        self.initUI()
        self.initData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initData(){
        self.isTouched = false
        self.currentPoint = 0
    }
    
    private func initUI() {
        for i in 0...4 {
            let darkStar = UIImageView()
            darkStar.image = self.darkStarImage
            darkStar.frame = CGRect.init(x: (self.starWidth+self.starSpcae)*CGFloat(i)+self.starSpcae/2, y: 0, width: self.starWidth, height: self.starWidth)
            self.addSubview(darkStar)
        }
        
        self.lightStarView = UIView()
        self.lightStarView?.frame = self.bounds
        self.lightStarView?.layer.masksToBounds = true
        self.addSubview(self.lightStarView!)
        
        for j in 0...4 {
            let lightStar = UIImageView()
            lightStar.image = self.lightStarImage
            lightStar.frame = CGRect.init(x: (self.starWidth+self.starSpcae)*CGFloat(j)+self.starSpcae/2, y: 0, width: self.starWidth, height: self.starWidth)
            self.lightStarView?.addSubview(lightStar)
        }
        
        self.touchView = UIView()
        self.touchView?.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0)
        self.touchView?.frame = self.bounds
        self.addSubview(self.touchView!)
        
        //添加点击手势
        let tapG = UITapGestureRecognizer.init(target: self, action: #selector(handleTap(_:)))
        self.touchView?.addGestureRecognizer(tapG)
        
        let panG = UIPanGestureRecognizer.init(target: self, action: #selector(handlePan(_:)))
        self.touchView?.addGestureRecognizer(panG)
    }
    
    @objc private func handlePan(_ panRecognizer:UITapGestureRecognizer){
        let location = panRecognizer.location(in: self.touchView)
        //星星只取半星和全星，所以将totalPoint分成10份，取10份的整数,四舍五入
        let point = lroundf(Float(location.x/self.bounds.size.width*10))
        let newPoint = CGFloat(point)*self.totalPoint/10
        if newPoint>=0 && newPoint<=self.totalPoint {
            self.currentPoint = newPoint
        }
    }
    
    @objc private func handleTap(_ tapRecognizer:UITapGestureRecognizer){
        let location = tapRecognizer.location(in: self.touchView)
        let point = lroundf(Float(location.x/self.bounds.size.width*10))
        let newPoint = CGFloat(point)*self.totalPoint/10
        if newPoint>=0 && newPoint<=self.totalPoint {
            self.currentPoint = newPoint
        }
    }
    
    private func lightStar(point:CGFloat) {
        var newFrame = self.lightStarView?.frame
        //星星只取半星和全星，所以显示区域分成10份，取10份的整数,四舍五入
        let newPoint = lroundf(Float(point/self.totalPoint*10))
        let percent = CGFloat(newPoint)/10
        newFrame?.size.width = self.bounds.size.width*percent
        self.lightStarView?.frame = newFrame!
    }
    
}
