//
//  JKSegmentControl.swift
//  App
//
//  Created by 蒋晨成 on 2021/3/16.
//

import UICore

protocol JKSegmentControlDelegate: AnyObject {
    func segmentControl(_ segmentControl: JKSegmentControl, selectedIndex: Int)
}

class JKSegmentControl: UIControl {
    
    var delegate: JKSegmentControlDelegate?
    
    private let itemWidth: CGFloat = 70.0

    private var dataSource: [String]
    

    private var _selectedIndex: Int = 0
    public var selectedIndex: Int {
        get {
            _selectedIndex
        }
        set {
            if _selectedIndex != newValue {
                collectionView.selectItem(at: IndexPath(item: newValue, section: 0), animated: true, scrollPosition: .right)
                exchangeCellState(lastIndexPath: IndexPath(item: _selectedIndex, section: 0), currentIndexPath: IndexPath(item: newValue, section: 0))
                _selectedIndex = newValue
                self.sendActions(for: .valueChanged)
            }
            
        }
    }
    
    
    private var isFirstMove = true
    
    init(frame: CGRect = .zero, items: [String] = ["双色球","大乐透"]) {

        self.dataSource = items
        super.init(frame: frame)
        
        setupUI()
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
    
    private lazy var moveBar: UIView = {
        let lazy = UIView()
        lazy.layer.cornerRadius = 2
        lazy.backgroundColor = Color(hex: 0xfd9f28)
        return lazy
    }()
    
    private lazy var bottomLine: UIView = {
        let lazy = UIView()
        lazy.backgroundColor = Color(hex: 0xeeeeee)
        return lazy
    }()
    
}

private extension JKSegmentControl {
    
    func setupUI() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // moveBar
        collectionView.addSubview(moveBar)
    
        self.addSubview(bottomLine)
        bottomLine.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
    }
    
    
    func exchangeCellState(lastIndexPath: IndexPath, currentIndexPath: IndexPath) {
        guard let lastCell = collectionView.cellForItem(at: lastIndexPath) as? JKSegmentCell else{ return }
        lastCell.isSelected = false
        guard let currentCell = collectionView.cellForItem(at: currentIndexPath) as? JKSegmentCell else { return }
        currentCell.isSelected = true
        move(cell: currentCell, isAnimation: true)
    }
    
    
    func move(cell: UICollectionViewCell, isAnimation: Bool = false){
        if isFirstMove {
            moveBar.snp.makeConstraints{
                $0.centerX.equalTo(cell)
                $0.bottom.equalTo(cell).offset(-1)
                $0.width.equalTo(20)
                $0.height.equalTo(4)
            }
            isFirstMove = false
        }else {
            
            self.moveBar.snp.remakeConstraints{
                $0.centerX.equalTo(cell)
                $0.bottom.equalTo(cell).offset(-1)
                $0.width.equalTo(20)
                $0.height.equalTo(4)
            }
            if isAnimation {
                UIView.animate(withDuration: 0.2) { [weak self] in
                    self?.layoutIfNeeded()
                }
            }
            
        }
        
    }
    
}



extension JKSegmentControl: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard dataSource[safe: indexPath.item] != nil else { fatalError() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JKSegmentCell.cellID, for: indexPath)
            as? JKSegmentCell else { fatalError() }
        return cell
    }
    
    
    func collectionView(_: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
  
        guard let content = dataSource[safe: indexPath.item] else { fatalError() }
        guard let cell = cell as? JKSegmentCell else { return }
        cell.config(title: content)
        cell.isSelected = self.selectedIndex == indexPath.item
        if self.selectedIndex == indexPath.item {
            move(cell: cell)
        }
        
    }
    
   
    
    
}

extension JKSegmentControl: UICollectionViewDelegate {
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selectedIndex == indexPath.item {
            return
        }
        exchangeCellState(lastIndexPath: IndexPath(item: selectedIndex, section: 0), currentIndexPath: indexPath)
        _selectedIndex = indexPath.item
        self.sendActions(for: .valueChanged)
    }
}

extension JKSegmentControl: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = self.frame.height

        return CGSize(width: itemWidth, height: height)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        let width: CGFloat = self.frame.width
        var count: CGFloat = CGFloat(self.dataSource.count)
        if count > 4 { count = 4.0 }
        
    
        let padding: CGFloat = (width-count*itemWidth)/(count+1)
        
        return padding
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let width: CGFloat = self.frame.width
        var count: CGFloat = CGFloat(self.dataSource.count)
        if count > 4 { count = 4.0 }
        
        let padding: CGFloat = (width-count*itemWidth)/(count+1)
        
        return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    }
}




class JKSegmentCell: CollectionViewCell {
    
    private var _isSelected: Bool = false
    override var isSelected: Bool {
        get {
            _isSelected
        }
        set {
            _isSelected = newValue
            if newValue {
                titleLabel.textColor = Color(hex: 0x333333)
                titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            }else {
                titleLabel.textColor = Color(hex: 0x666666)
                titleLabel.font = UIFont.systemFont(ofSize: 16)
            }
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let lazy = UILabel(frame: CGRect.zero)
        lazy.textAlignment = .center
        lazy.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        lazy.textColor = Color(hex: 0x666666)
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



