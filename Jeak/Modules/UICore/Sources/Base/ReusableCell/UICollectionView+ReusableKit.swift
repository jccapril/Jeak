//
//  UICollectionView+ReusableKit.swift
//  UICore
//
//  Created by Flutter on 2021/3/19.
//

#if os(iOS)
import UIKit
import RxSwift
import RxCocoa

/// An enumeration that represents UICollectionView supplementary view kind.
public enum SupplementaryViewKind: String {
  case header, footer

  public init?(rawValue: String) {
    switch rawValue {
    case UICollectionView.elementKindSectionHeader: self = .header
    case UICollectionView.elementKindSectionFooter: self = .footer
    default: return nil
    }
  }

  public var rawValue: String {
    switch self {
    case .header: return UICollectionView.elementKindSectionHeader
    case .footer: return UICollectionView.elementKindSectionFooter
    }
  }
}

extension UICollectionViewCell: CellType {
}

extension UIView: ViewType {
}

extension UICollectionView {

  // MARK: Cell
  /// Registers a generic cell for use in creating new collection view cells.
  public func register<Cell>(_ cell: ReusableCell<Cell>) {
    if let nib = cell.nib {
      self.register(nib, forCellWithReuseIdentifier: cell.identifier)
    } else {
      self.register(Cell.self, forCellWithReuseIdentifier: cell.identifier)
    }
  }


  /// Returns a generic reusable cell located by its identifier.
  public func dequeue<Cell>(_ cell: ReusableCell<Cell>, for indexPath: IndexPath) -> Cell {
    return self.dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as! Cell
  }

  // MARK: Supplementary View
  /// Registers a generic view for use in creating new supplementary views for the collection view.
  public func register<View>(_ view: ReusableView<View>, kind: SupplementaryViewKind) {
    self.register(view, kind: kind.rawValue)
  }

  /// Registers a generic view for use in creating new supplementary views for the collection view.
  public func register<View>(_ view: ReusableView<View>, kind: String) {
    if let nib = view.nib {
      self.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: view.identifier)
    } else {
      self.register(View.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: view.identifier)
    }
  }

  /// Returns a generic reusable supplementary view located by its identifier and kind.
  public func dequeue<View>(_ view: ReusableView<View>, kind: String, for indexPath: IndexPath) -> View {
    return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: view.identifier, for: indexPath) as! View
  }

  /// Returns a generic reusable supplementary view located by its identifier and kind.
  public func dequeue<View>(_ view: ReusableView<View>, kind: SupplementaryViewKind, for indexPath: IndexPath) -> View {
    return self.dequeue(view, kind: kind.rawValue, for: indexPath)
  }
}


extension Reactive where Base: UICollectionView {
    public func items<S: Sequence, Cell: UICollectionViewCell, O: ObservableType>(
      _ reusableCell: ReusableCell<Cell>
    ) -> (_ source: O)
      -> (_ configureCell: @escaping (Int, S.Iterator.Element, Cell) -> Void)
      -> Disposable
      where O.Element == S {
      return { source in
        return { configureCell in
          return self.items(cellIdentifier: reusableCell.identifier, cellType: Cell.self)(source)(configureCell)
        }
      }
    }
}


extension LeafBox where T: UICollectionView {
    
    public func register<Cell>(_ cell: ReusableCell<Cell>) -> LeafBox<T>{
        value.register(cell)
        return value.leaf
    }
    
    public func register<View>(_ view: ReusableView<View>, kind: SupplementaryViewKind) -> LeafBox<T> {
        value.register(view, kind: kind)
        return value.leaf
    }
    
}


#endif
