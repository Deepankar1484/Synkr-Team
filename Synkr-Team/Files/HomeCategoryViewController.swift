//
//  HomeCategoryViewController.swift
//  Synkr-Team
//
//  Created by Deepankar Garg on 17/01/25.
//

import UIKit

class HomeCategoryViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    
    var loggedUser: User?{
        didSet {
            if isViewLoaded {
                updateUI()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        collectionView.register(CategoryCollectionViewCell.nib(), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        // Set the compositional layout
        collectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            // You can use the `sectionIndex` if you plan to have multiple sections in the future
            return self.createTaskSection()
        }
    }

    private func createTaskSection() -> NSCollectionLayoutSection {
        // Define the item size
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0), // Full width
            heightDimension: .absolute(100)       // Fixed height
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        // Define the group size
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100) // Group height adjusts based on content
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        // Define the section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        // Optional: Add orthogonal scrolling behavior if needed
        section.orthogonalScrollingBehavior = .none // No horizontal scrolling; tasks are vertical


        return section
    }

    private func updateUI() {
        // Use the LoggedUser property to update the UI
        if let loggedUser = loggedUser {
            print("LoggedUser: \(loggedUser.name)")
        }
    }
}

extension HomeCategoryViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("You tapped me!")
    }
}

extension HomeCategoryViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        let category = Category.allCases[indexPath.item]
        cell.configure(with: category)
        
        return cell
    }
}

extension HomeCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width // Adjust padding
        return CGSize(width: width, height: 100) // Set the height based on your design
    }
}
