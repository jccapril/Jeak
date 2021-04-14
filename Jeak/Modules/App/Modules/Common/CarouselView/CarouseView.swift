//
//  CarouseView.swift
//  App
//
//  Created by Flutter on 2021/4/13.
//

import UIKit
import UICore

protocol CarouseViewDelegate: NSObjectProtocol {
    
    func carouseView(_ carouseView: CarouseView, didSelectItemAtIndex index:Int)
    
    func carouseView(_ carouseView: CarouseView, toCurrentPageIndex index:Int)
    
}

class CarouseView: UIView {
    
    /**是否无限循环，默认yes  如果设置成NO，则需要自己设置collectionView的pagingEnabled属性*/
    var infiniteLoop: Bool = true
    //*是否自动滑动，默认yes,如果infiniteLoop = NO，则autoScroll=NO；不能设置成YES；
//    var autoScroll: Bool = true
    /**是否缩放，默认不缩放*/
    var isZoom: Bool = false {
        didSet {
            self.flowLayout.isZoom = isZoom
        }
    }
    /**自动滚动间隔时间，默认2s*/
//    var autoScrollTimeInterval: Float = 2.0
    //cell宽度
    var itemWidth: CGFloat = 0.0 {
        didSet {
            self.flowLayout.itemSize = CGSize(width: itemWidth, height: self.bounds.size.height)
        }
    }
    //cell间距
    var itemSpace: CGFloat = 0.0 {
        didSet {
            self.flowLayout.minimumLineSpacing = itemSpace;
        }
    }
    /**imagView圆角，默认为0*/
    var imgCornerRadius: CGFloat = 0.0
    /** 轮播图片的ContentMode，默认为 UIViewContentModeScaleToFill */
    var bannerImageViewContentMode: UIView.ContentMode = .scaleToFill
    //代理方法
    weak var  delegate: CarouseViewDelegate?

    private var backgroundImageView: UIImageView?
    private var types: [JKLotteryType] = [.ssq,.dlt] {
        didSet {
            self.pageControl.numberOfPages = types.count
            self.totalItems = self.infiniteLoop ? types.count*100 : types.count
            if types.count > 0 {
                self.collectionView.isScrollEnabled = true
            } else {
                self.collectionView.isScrollEnabled = false
            }
            self.collectionView.reloadData()
        }
    }
    private var totalItems: Int = 0
//    private var timer: Timer?
    private var currentpage: Int = 0
    private var _oldPoint: CGFloat = 0.0
    private var _dragDirection: Int = 0
    
    
    private lazy var flowLayout: CarouseViewFlowLayout = {
        let lazy = CarouseViewFlowLayout()
        lazy.isZoom = self.isZoom
        lazy.scrollDirection = .horizontal
        return lazy
    }()
    
    private enum Reusable {
        static let cell = ReusableCell<CarouseViewCell>()
    }
    private lazy var collectionView: UICollectionView = {
        UICollectionView(frame: self.bounds, collectionViewLayout: self.flowLayout)
            .leaf
            .backgroundColor(.clear)
            .delegate(self)
            .dataSource(self)
            .scrollsToTop(false)
            .showsVerticalScrollIndicator(false)
            .showsHorizontalScrollIndicator(false)
            .register(Reusable.cell)
            .instance
    }()
    
    lazy var pageControl:UIPageControl = {
        let lazy = UIPageControl()
        lazy.currentPageIndicatorTintColor = .white
        lazy.pageIndicatorTintColor = .lightGray
        return lazy
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Convenience

extension CarouseView {
    convenience init(frame:CGRect, shouldInfiniteLoop isInfiniteLoop:Bool, types:[JKLotteryType]) {
        self.init(frame:frame)
        self.setupOptions(isInfiniteLoop:isInfiniteLoop, types:types)
        self.setupUI()
    }
}


// MARK: - Override

extension CarouseView {
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        self.collectionView.frame = self.bounds
        self.pageControl.frame = CGRect(x: 0, y: self.bounds.size.height - 30, width: self.bounds.size.width, height: 30)
        self.flowLayout.itemSize = CGSize(width: self.itemWidth, height: self.bounds.size.height)
        self.flowLayout.minimumLineSpacing = self.itemSpace
  
        var targetIndex = 0
        if self.collectionView.contentOffset.x == 0 && self.totalItems > 0 {
            if self.infiniteLoop {
                targetIndex = self.totalItems/2
            }else {
                targetIndex = 0
            }
        }
        currentpage = targetIndex % self.types.count
        self.collectionView.scrollToItem(at: IndexPath(row: targetIndex, section: 0), at: .centeredHorizontally, animated: false)
        _oldPoint = self.collectionView.contentOffset.x
        self.collectionView.isUserInteractionEnabled = true

    }
}

// MARK: - Method
private extension CarouseView {

    func setupOptions(isInfiniteLoop:Bool, types:[JKLotteryType]){
        self.infiniteLoop = isInfiniteLoop
//        self.autoScroll = isInfiniteLoop
        self.types = types
        self.itemWidth = self.bounds.size.width
    }
    
    func setupUI() {
        self.collectionView.leaf.add(to: self)
        self.pageControl.leaf.add(to: self)
    }
    
    
    func currentIndex()->Int{
        if self.collectionView.frame.size.width == 0 || self.collectionView.frame.size.height == 0 { return 0 }
        var index = 0
        if self.flowLayout.scrollDirection == .horizontal {
            index = Int((self.collectionView.contentOffset.x + (self.itemWidth + self.itemSpace) * 0.5)/(self.itemWidth + self.itemSpace))
        }else {
            index = Int((self.collectionView.contentOffset.y + self.flowLayout.itemSize.height * 0.5)/self.flowLayout.itemSize.height);
        }
        return max(0,index);
    }
    
}

// MARK:  - Delegate
// MARK: - UIScrollViewDelegate

extension CarouseView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.collectionView.isUserInteractionEnabled = false
        if self.types.count == 0 { return }
        let currentPage = self.currentIndex() % self.types.count;
        self.pageControl.currentPage = currentpage;
        if currentpage != currentPage  {
            currentpage = currentPage
            self.delegate?.carouseView(self, toCurrentPageIndex: currentpage)
        }
        
    }
    
    // 开始拖动时记录一下当前位置
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        _oldPoint = scrollView.contentOffset.x
    }
    
    //手离开屏幕的时候
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !self.infiniteLoop { return } //如果不是无限轮播，则返回
        let currentPoint = scrollView.contentOffset.x
        let moveWidth = currentPoint - _oldPoint
        let shouldPage: Int = Int(moveWidth/(self.itemWidth/2))
        
        if velocity.x > 0 || shouldPage > 0 {
            _dragDirection = 1
        }else if  velocity.x < 0 || shouldPage < 0{
            _dragDirection = -1
        }else{
            _dragDirection = 0
        }
        self.collectionView.isUserInteractionEnabled = false
        let currentIndex: Int = Int((_oldPoint + (self.itemWidth + self.itemSpace)/2) / (self.itemSpace + self.itemWidth))
//        print("scrollViewWillEndDragging indexpath:\(currentIndex+_dragDirection)")
        self.collectionView.scrollToItem(at: IndexPath(row: currentIndex + _dragDirection, section: 0), at: .centeredHorizontally, animated: true)

    }
    
    //开始减速的时候
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if !self.infiniteLoop  { return }//如果不是无限轮播，则返回
        //松开手指滑动开始减速的时候，设置滑动动画
        let currentIndex: Int = Int((_oldPoint + (self.itemWidth + self.itemSpace)/2) / (self.itemSpace + self.itemWidth))
//        print("scrollViewWillBeginDecelerating indexpath:\(currentIndex+_dragDirection)")
        self.collectionView.scrollToItem(at: IndexPath(row: currentIndex + _dragDirection, section: 0), at: .centeredHorizontally, animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.collectionView.isUserInteractionEnabled = true
    }
}

// MARK: - UICollectionViewDelegate

extension CarouseView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("carouseViewDidSelectItemAt:\(indexPath.row % self.types.count)")
        self.delegate?.carouseView(self, didSelectItemAtIndex: indexPath.row % self.types.count)
    }
    
}

 // MARK: - UICollectionViewDataSource

 extension CarouseView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.totalItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CarouseViewCell = collectionView.dequeue(Reusable.cell, for: indexPath)
        cell.imageView.contentMode = self.bannerImageViewContentMode;
        cell.imgCornerRadius = self.imgCornerRadius;
        
        cell.imageView.image = UIImage.init(color: Theme.themeColor)
        
        return cell
    }


}
