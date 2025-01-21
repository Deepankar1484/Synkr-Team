import UIKit

enum AwardsSection: Int, CaseIterable {
    case streaks, recentAwards, earnedAwards, lockedAwards
}

// Dummy data for awards
class AwardsCollectionViewController: UICollectionViewController {
    
    // Dummy data for testing
    let streakData = (currentStreak: "6 Days", maxStreak: "6 Days")
    
    let recentAward = Award(
        awardId: UUID(),
        awardName: "Weekly Warrior Trophy",
        dateEarned: Date(),
        description: "Awards for completing all weekly tasks",
        awardCount: 0
    )
    
    let earnedAwards: [Award] = [
        Award(awardId: UUID(), awardName: "Achievement Unlocked", dateEarned: Date(), description: "", awardCount: 0),
        Award(awardId: UUID(), awardName: "Milestone Reached", dateEarned: Date(), description: "", awardCount: 0),
        Award(awardId: UUID(), awardName: "Achievement Unlocked", dateEarned: Date(), description: "", awardCount: 0),
        Award(awardId: UUID(), awardName: "Milestone Reached", dateEarned: Date(), description: "", awardCount: 0)
    ]
    
    let lockedAwards: [Award] = [
        Award(awardId: UUID(), awardName: "Yearly Trophy", dateEarned: Date(), description: "Complete this year's task to earn this trophy", awardCount: 0, progress: 0.5),
        Award(awardId: UUID(), awardName: "Elite Trophy", dateEarned: Date(), description: "Complete elite tasks to unlock", awardCount: 0, progress: 0.3),
        Award(awardId: UUID(), awardName: "Yearly Trophy", dateEarned: Date(), description: "Complete this year's task to earn this trophy", awardCount: 0, progress: 0.5),
        Award(awardId: UUID(), awardName: "Elite Trophy", dateEarned: Date(), description: "Complete elite tasks to unlock", awardCount: 0, progress: 0.3)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let storyboard = UIStoryboard(name: "Awards", bundle: nil) // Replace "Main" with your storyboard name
//        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "awards") as? AwardsCollectionViewController else {
//            return
//        }
        // Push or present the detail view controller
        navigationItem.title = "Awards"
        // Register custom XIBs and headers
        collectionView.register(UINib(nibName: "StreakCell", bundle: nil), forCellWithReuseIdentifier: "StreakCell")
        collectionView.register(UINib(nibName: "RecentAwardCell", bundle: nil), forCellWithReuseIdentifier: "RecentAwardCell")
        collectionView.register(UINib(nibName: "EarnedAwardCell", bundle: nil), forCellWithReuseIdentifier: "EarnedAwardCell")
        collectionView.register(UINib(nibName: "LockedAwardCell", bundle: nil), forCellWithReuseIdentifier: "LockedAwardCell")
        collectionView.register(UINib(nibName: "SectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeaderView")
        
        collectionView.register(
            CollectionReusableView.self,
                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                   withReuseIdentifier: CollectionReusableView.reuseIdentifier
               )
        
        // Use compositional layout
        collectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    // Compositional Layout Setup
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            switch AwardsSection(rawValue: sectionIndex)! {
            case .streaks:
                return self.createStreakSection()
            case .recentAwards:
                return self.createRecentAwardSection()
            case .earnedAwards:
                return self.createEarnedAwardsSection()
            case .lockedAwards:
                return self.createLockedAwardsSection()
            }
        }
        return layout
    }
    
    func createStreakSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 10, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    func createRecentAwardSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    func createEarnedAwardsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(150)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    func createLockedAwardsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    // Number of sections
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return AwardsSection.allCases.count
    }
    
    // Number of items in section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch AwardsSection(rawValue: section)! {
        case .streaks:
            return 1
        case .recentAwards:
            return 1
        case .earnedAwards:
            return earnedAwards.count
        case .lockedAwards:
            return lockedAwards.count
        }
    }
    
    // Cell for item at index path
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch AwardsSection(rawValue: indexPath.section)! {
        case .streaks:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StreakCell", for: indexPath) as! StreakCell
            cell.currentStreakLabel.text = streakData.currentStreak
            cell.maxStreakLabel.text = streakData.maxStreak
            return cell
            
        case .recentAwards:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentAwardCell", for: indexPath) as! RecentAwardCell
            cell.imageView.image = UIImage(systemName: "trophy")
            cell.trophyName.text = recentAward.awardName
            cell.awardDescription.text = recentAward.description
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            cell.dateEarned.text = dateFormatter.string(from: recentAward.dateEarned)
            return cell
            
        case .earnedAwards:
            let award = earnedAwards[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EarnedAwardCell", for: indexPath) as! EarnedAwardCell
            cell.image.image = UIImage(systemName: "star")
            cell.awardTitle.text = award.awardName
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            cell.dateEarned.text = dateFormatter.string(from: award.dateEarned)
            return cell
            
        case .lockedAwards:
            let award = lockedAwards[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LockedAwardCell", for: indexPath) as! LockedAwardCell
            cell.imageView.image = UIImage(systemName: "lock")
            cell.awardTitle.text = award.awardName
            cell.awardDescription.text = award.description
            cell.progressBar.progress = award.progress ?? 0.0
            cell.percentage.text = "\(Int((award.progress ?? 0.0) * 100))%"
            return cell
        }
    }
    
    // Header View
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: CollectionReusableView.reuseIdentifier,
            for: indexPath
        ) as! CollectionReusableView
        
        switch AwardsSection(rawValue: indexPath.section)! {
        case .streaks:
            headerView.titleLabel.text = "Current Streak"
        case .recentAwards:
            headerView.titleLabel.text = "Recent Award"
        case .earnedAwards:
            headerView.titleLabel.text = "Earned Awards"
        case .lockedAwards:
            headerView.titleLabel.text = "Locked Awards"
        }
        
        return headerView
    }

}
