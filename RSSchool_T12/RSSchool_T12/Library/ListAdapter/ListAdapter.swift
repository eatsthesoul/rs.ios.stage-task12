//
//  ListAdapter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 25.01.22.
//

import UIKit

public class ListAdapter<Cell: UICollectionViewCell>: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout where Cell: ConfigurableCell {
    
    typealias Model = Cell.T
    
    // MARK: - Output
    
    public var onSelectItem: ((Int) -> Void)?
    
    // MARK: - Private properties
    
    private weak var collectionView: UICollectionView?
    private var items: [Model]?
    
    // MARK: - Public properties
    
    public var selectedCellIndex: Int?
    
    public var itemSize: CGSize?
    public var selectedItemSize: CGSize?
    public var insetForSections: UIEdgeInsets?
    
    // MARK: - Public methods
    
    func setup(collectionView: UICollectionView) {
        self.collectionView = collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: String(describing: Cell.self), bundle: nil),
                                forCellWithReuseIdentifier: String(describing: Cell.self)
        )
    }
    
    func configure(with items: [Model]) {
        self.items = items
        collectionView?.reloadData()
    }
    
    // MARK: - Private methods
    
    //it calls sizeForItemAt method and updates items size animatable
    private func animateItemSizeChangeFor(collectionView: UICollectionView, withDuration duration: Double) {
        UIView.animate(withDuration: duration) {
            collectionView.performBatchUpdates {}
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: Cell.self), for: indexPath) as? Cell
        
        guard let item = items?[indexPath.row] else { return UICollectionViewCell() }
        cell?.configure(with: item)

        return cell ?? UICollectionViewCell()
    }
    
    // MARK: - UICollectionViewDelegate
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        onSelectItem?(indexPath.row)
        
        selectedCellIndex = indexPath.row
        animateItemSizeChangeFor(collectionView: collectionView, withDuration: 0.3)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //return selected item size if indexes match and size was setted
        if selectedCellIndex == indexPath.row, let selectedItemSize = selectedItemSize {
            return selectedItemSize
        }
        return itemSize ?? .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        guard let insetForSections = insetForSections else { return UIEdgeInsets.zero }
        return insetForSections
    }
}

