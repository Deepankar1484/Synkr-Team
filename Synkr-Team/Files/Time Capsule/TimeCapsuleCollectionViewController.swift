import UIKit

class TimeCapsuleCollectionViewController: UICollectionViewController {

    // Data arrays
    var topCapsules: [TimeCapsule] = []
    var inProgressCapsules: [TimeCapsule] = []
    var timeCapsules: [TimeCapsule] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Time Capsule"
        // Register NIBs
        collectionView.register(UINib(nibName: "TopCapsuleCell", bundle: nil), forCellWithReuseIdentifier: "TopCell")
        collectionView.register(UINib(nibName: "InProgressCell", bundle: nil), forCellWithReuseIdentifier: "InProgressCell")
        collectionView.register(UINib(nibName: "TimeCapsuleCell", bundle: nil), forCellWithReuseIdentifier: "TaskCell")
        collectionView.register(SupplementaryHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")

        // Set layout
        collectionView.collectionViewLayout = createCompositionalLayout()

        loadDummyData()
    }

    // MARK: - Dummy Data
    func loadDummyData() {
        topCapsules = [
            TimeCapsule(capsuleId: UUID(), capsuleName: "Finish Project", deadline: Date().addingTimeInterval(60 * 60 * 24 * 3), priority: .high, description: "Complete Synkr project", completionPercentage: 0.9, timeCapsuleCategory: .work, subtasks: [])
        ]

        inProgressCapsules = [
            TimeCapsule(capsuleId: UUID(), capsuleName: "Morning Run", deadline: Date().addingTimeInterval(60 * 60 * 24), priority: .medium, description: "Run 5 km", completionPercentage: 0.5, timeCapsuleCategory: .sports, subtasks: []),
            TimeCapsule(capsuleId: UUID(), capsuleName: "Prepare Presentation", deadline: Date().addingTimeInterval(60 * 60 * 48), priority: .high, description: "Presentation for project review", completionPercentage: 0.3, timeCapsuleCategory: .work, subtasks: []),
            
            TimeCapsule(capsuleId: UUID(), capsuleName: "Morning Run", deadline: Date().addingTimeInterval(60 * 60 * 24), priority: .medium, description: "Run 5 km", completionPercentage: 0.5, timeCapsuleCategory: .sports, subtasks: []),
            TimeCapsule(capsuleId: UUID(), capsuleName: "Prepare Presentation", deadline: Date().addingTimeInterval(60 * 60 * 48), priority: .high, description: "Presentation for project review", completionPercentage: 0.3, timeCapsuleCategory: .work, subtasks: [])
        ]

        timeCapsules = [
            TimeCapsule(capsuleId: UUID(), capsuleName: "Read a Book", deadline: Date().addingTimeInterval(60 * 60 * 24 * 7), priority: .low, description: "Finish reading Atomic Habits", completionPercentage: 1.0, timeCapsuleCategory: .study, subtasks: []),
            TimeCapsule(capsuleId: UUID(), capsuleName: "Buy Groceries", deadline: Date().addingTimeInterval(60 * 60 * 8), priority: .medium, description: "Get weekly groceries", completionPercentage: 1.0, timeCapsuleCategory: .work, subtasks: []),
            TimeCapsule(capsuleId: UUID(), capsuleName: "Complete Workout", deadline: Date().addingTimeInterval(60 * 60 * 24 * 2), priority: .high, description: "Full body workout", completionPercentage: 0.6, timeCapsuleCategory: .sports, subtasks: []),
            TimeCapsule(capsuleId: UUID(), capsuleName: "Read a Book", deadline: Date().addingTimeInterval(60 * 60 * 24 * 7), priority: .low, description: "Finish reading Atomic Habits", completionPercentage: 0.2, timeCapsuleCategory: .study, subtasks: []),
            TimeCapsule(capsuleId: UUID(), capsuleName: "Buy Groceries", deadline: Date().addingTimeInterval(60 * 60 * 8), priority: .medium, description: "Get weekly groceries", completionPercentage: 1.0, timeCapsuleCategory: .work, subtasks: []),
            TimeCapsule(capsuleId: UUID(), capsuleName: "Complete Workout", deadline: Date().addingTimeInterval(60 * 60 * 24 * 2), priority: .high, description: "Full body workout", completionPercentage: 0.6, timeCapsuleCategory: .sports, subtasks: [])
        ]

        collectionView.reloadData()
    }

    // MARK: - Compositional Layout
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            switch sectionIndex {
            case 0:
                return self.createTopCapsuleSection()
            case 1:
                return self.createInProgressSection()
            case 2:
                return self.createTimeCapsuleSection()
            default:
                return nil
            }
        }
    }

    private func createTopCapsuleSection() -> NSCollectionLayoutSection {
        // Define the item size with a wider width
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.97),  // Increased width for a wider item
            heightDimension: .fractionalHeight(0.7)  // Adjust height for better aspect ratio
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // Apply some spacing between items
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        // Define the group size with a larger height for a more spacious look
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),  // Full width for the group (for full width)
            heightDimension: .absolute(200)  // Increased height for better item visibility
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        // Create the section with the group and add beautiful visual features
        let section = NSCollectionLayoutSection(group: group)

        // Apply rounded corners to items and add shadow for a card-like effect
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        // Optional: Add a header view to give more context
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(30)  // Height of header
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        return section
    }


    private func createInProgressSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.90),  // Increase width to 48%
            heightDimension: .absolute(160)         // Adjust height for better visibility
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)  // Adjust gap

        // Group size that accommodates two items on the screen
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),  // Full width for the section
            heightDimension: .absolute(160)         // Height should match the item height
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])

        // Section with continuous scrolling behavior
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10)
        section.interGroupSpacing = 2  // Reduce gap between items

        // Optional: Add header for the section
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0), // Full width
            heightDimension: .absolute(20)         // Adjusted header height
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        return section
    }



    private func createTimeCapsuleSection() -> NSCollectionLayoutSection {
        // Adjusted item size
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),  // Full width for the section
            heightDimension: .absolute(120)         // Adjust height for better visibility
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)  // Adjusted gap

        // Group size for single column
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),  // Full width
            heightDimension: .absolute(120)         // Adjusted group height
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        // Section configuration
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)  // Adjusted padding

        // Optional header configuration
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(30)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        return section
    }


    // MARK: - UICollectionView Data Source
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3 // TopCapsule, InProgress, TimeCapsule
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return topCapsules.count
        case 1: return inProgressCapsules.count
        case 2: return timeCapsules.count
        default: return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCell", for: indexPath) as? TopCapsuleCell else { return UICollectionViewCell() }
            let capsule = topCapsules[indexPath.row]
            cell.configureCell(with: capsule)
            return cell

        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InProgressCell", for: indexPath) as? InProgressCell else { return UICollectionViewCell() }
            let capsule = inProgressCapsules[indexPath.row]
            cell.configureCell(with: capsule)
            return cell

        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskCell", for: indexPath) as? TimeCapsuleCell else { return UICollectionViewCell() }
            let capsule = timeCapsules[indexPath.row]
            cell.configureCell(with: capsule)
            return cell

        default:
            return UICollectionViewCell()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as? SupplementaryHeaderView else {
            return UICollectionReusableView()
        }

        switch indexPath.section {
        case 1:
            header.titleLabel.text = "Ongoing Capsules"
        case 2:
            header.titleLabel.text = "All Capsules"
        default:
            header.titleLabel.text = ""
        }

        return header
    }
}

class SupplementaryHeaderView: UICollectionReusableView {
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHeader()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureHeader() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
