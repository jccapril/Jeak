//
//  JKSegmentControl.swift
//  App
//
//  Created by 蒋晨成 on 2021/3/16.
//

import UICore

class JKSegmentControl: UIView {

    private var dataSource: [String]
    
    init(frame: CGRect = .zero, items: [String] = ["双色球","大乐透"]) {
    
        
        self.dataSource = items
        
        super.init(frame: frame)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
    
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(JKSegmentCell.self, forCellWithReuseIdentifier: JKSegmentCell.cellID)
        return collectionView
    }()
    
   
    
}

private extension JKSegmentControl {
    
    func setup() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}



extension JKSegmentControl: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard dataSource[safe: indexPath.row] != nil else { fatalError() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JKSegmentCell.cellID, for: indexPath)
            as? JKSegmentCell else { fatalError() }
        return cell
    }
    
    
    func collectionView(_: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let content = dataSource[safe: indexPath.row] else { fatalError() }
        guard let cell = cell as? JKSegmentCell else { return }
        cell.config(title: content)
    }
    
    
    
    
}

extension JKSegmentControl: UICollectionViewDelegate {
    

    
}

extension JKSegmentControl: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        var width = self.frame.width
        let height = self.frame.height
//        let base: CGFloat = self.dataSource.count <= 3 ? CGFloat(self.dataSource.count) : 3.0
//        width = width/base
        
        return CGSize(width: 60, height: height)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        let itemWidth: CGFloat = 60.0
        let width: CGFloat = self.frame.width
        var count: CGFloat = CGFloat(self.dataSource.count)
        if count > 4 {
            count = 4.0
        }
    
        let padding: CGFloat = (width-count*itemWidth)/(count+1)
        
        return padding
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let itemWidth: CGFloat = 60.0
        let width: CGFloat = self.frame.width
        var count: CGFloat = CGFloat(self.dataSource.count)
        if count > 4 {
            count = 4.0
        }
        
        let padding: CGFloat = (width-count*itemWidth)/(count+1)
        
        return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    }
}




class JKSegmentCell: CollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let lazy = UILabel(frame: CGRect.zero)
        lazy.textAlignment = .center
        return lazy
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func setup(){
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    
    func config(title: String) {
        titleLabel.text = title
    }
    
    
}
