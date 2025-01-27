import UIKit

class TimeCapsuleCollectionViewController: UICollectionViewController {

    // Data arrays
    var topCapsules: [TimeCapsule] = []
    var inProgressCapsules: [TimeCapsule] = []
    var timeCapsules: [TimeCapsule] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Time Capsule"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAddButton)
        )
        // Register NIBs
        collectionView.register(UINib(nibName: "TopCapsuleCell", bundle: nil), forCellWithReuseIdentifier: "TopCell")
        collectionView.register(UINib(nibName: "InProgressCell", bundle: nil), forCellWithReuseIdentifier: "InProgressCell")
        collectionView.register(UINib(nibName: "TimeCapsuleCell", bundle: nil), forCellWithReuseIdentifier: "TaskCell")
        collectionView.register(SupplementaryHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")

        // Set layout
        collectionView.collectionViewLayout = createCompositionalLayout()

        loadDummyData()
    }
    @objc func didTapAddButton() {
        // Load the storyboard
        let storyboard = UIStoryboard(name: "TimeCapsule", bundle: nil)

        // Instantiate the view controller using its storyboard ID
        guard let createVC = storyboard.instantiateViewController(withIdentifier: "CreateTimeCapsule") as? CreateTimeCapsuleTableViewController else {
            print("Could not find view controller with ID 'CreateTimeCapsule'")
            return
        }
        // Present the view controller
        present(createVC, animated: true, completion: nil)
    }
    // MARK: - Dummy Data
    func loadDummyData() {
        // Add dummy subtasks to the time capsules
        topCapsules = [
            TimeCapsule(capsuleId: UUID(), capsuleName: "Finish Project", deadline: Date().addingTimeInterval(60 * 60 * 24 * 3), priority: .high, description: "Complete Synkr project", completionPercentage: 0.9, timeCapsuleCategory: .work, subtasks: [
                Subtask(subtaskName: "Design the UI", description: "Create wireframes for the main screens", startDate: Date(), endDate: Date().addingTimeInterval(60 * 60 * 24), isCompleted: false),
                Subtask(subtaskName: "Implement Core Features", description: "Develop core functionality for Synkr", startDate: Date().addingTimeInterval(60 * 60), endDate: Date().addingTimeInterval(60 * 60 * 48), isCompleted: false),
                Subtask(subtaskName: "Test the App", description: "Run automated tests to check app functionality", startDate: Date().addingTimeInterval(60 * 60 * 24 * 2), endDate: Date().addingTimeInterval(60 * 60 * 24 * 3), isCompleted: false)
            ])
        ]
        
        inProgressCapsules = [
            TimeCapsule(capsuleId: UUID(), capsuleName: "Morning Run", deadline: Date().addingTimeInterval(60 * 60 * 24), priority: .medium, description: "Run 5 km", completionPercentage: 0.5, timeCapsuleCategory: .sports, subtasks: [
                Subtask(subtaskName: "Warm-Up", description: "Do 5 minutes of stretching", startDate: Date(), endDate: Date().addingTimeInterval(60 * 10), isCompleted: true),
                Subtask(subtaskName: "Run 5 km", description: "Complete the 5 km run", startDate: Date().addingTimeInterval(60 * 10), endDate: Date().addingTimeInterval(60 * 40), isCompleted: false)
            ]),
            TimeCapsule(capsuleId: UUID(), capsuleName: "Prepare Presentation", deadline: Date().addingTimeInterval(60 * 60 * 48), priority: .high, description: "Presentation for project review", completionPercentage: 0.3, timeCapsuleCategory: .work, subtasks: [
                Subtask(subtaskName: "Create Slides", description: "Design the first 5 slides", startDate: Date(), endDate: Date().addingTimeInterval(60 * 60 * 12), isCompleted: false),
                Subtask(subtaskName: "Add Content", description: "Write down key points for the presentation", startDate: Date().addingTimeInterval(60 * 60 * 12), endDate: Date().addingTimeInterval(60 * 60 * 24), isCompleted: false)
            ])
        ]

        timeCapsules = [
            TimeCapsule(capsuleId: UUID(), capsuleName: "Read a Book", deadline: Date().addingTimeInterval(60 * 60 * 24 * 7), priority: .low, description: "Finish reading Atomic Habits", completionPercentage: 1.0, timeCapsuleCategory: .study, subtasks: [
                Subtask(subtaskName: "Read Chapters 1-3", description: "Complete the first three chapters", startDate: Date(), endDate: Date().addingTimeInterval(60 * 60 * 24 * 3), isCompleted: true),
                Subtask(subtaskName: "Take Notes", description: "Write key takeaways from the chapters", startDate: Date().addingTimeInterval(60 * 60 * 24 * 3), endDate: Date().addingTimeInterval(60 * 60 * 24 * 4), isCompleted: false)
            ]),
            TimeCapsule(capsuleId: UUID(), capsuleName: "Buy Groceries", deadline: Date().addingTimeInterval(60 * 60 * 8), priority: .medium, description: "Get weekly groceries", completionPercentage: 1.0, timeCapsuleCategory: .work, subtasks: [
                Subtask(subtaskName: "Make Grocery List", description: "Prepare a shopping list", startDate: Date(), endDate: Date().addingTimeInterval(60 * 30), isCompleted: true),
                Subtask(subtaskName: "Go to the Store", description: "Visit the nearby grocery store", startDate: Date().addingTimeInterval(60 * 30), endDate: Date().addingTimeInterval(60 * 60 * 2), isCompleted: false)
            ]),
            TimeCapsule(capsuleId: UUID(), capsuleName: "Complete Workout", deadline: Date().addingTimeInterval(60 * 60 * 24 * 2), priority: .high, description: "Full body workout", completionPercentage: 0.6, timeCapsuleCategory: .sports, subtasks: [
                Subtask(subtaskName: "Warm-Up", description: "5-minute warm-up exercise", startDate: Date(), endDate: Date().addingTimeInterval(60 * 10), isCompleted: true),
                Subtask(subtaskName: "Full Body Routine", description: "Complete the workout routine", startDate: Date().addingTimeInterval(60 * 10), endDate: Date().addingTimeInterval(60 * 30), isCompleted: false)
            ])
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
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Debugging: Print out the section and row values
        print("Section: \(indexPath.section), Row: \(indexPath.row)")

        // Get the selected time capsule based on the section and row
        let selectedCapsule: TimeCapsule
        switch indexPath.section {
        case 0:
            guard indexPath.row < topCapsules.count else { return }  // Prevent out-of-bounds error
            selectedCapsule = topCapsules[indexPath.row]
        case 1:
            guard indexPath.row < inProgressCapsules.count else { return }  // Prevent out-of-bounds error
            selectedCapsule = inProgressCapsules[indexPath.row]
        case 2:
            guard indexPath.row < timeCapsules.count else { return }  // Prevent out-of-bounds error
            selectedCapsule = timeCapsules[indexPath.row]
        default:
            return
        }

        // Instantiate the SubtasksCollectionViewController from the storyboard
        let storyboard = UIStoryboard(name: "Subtask", bundle: nil)
        guard let subtasksVC = storyboard.instantiateViewController(withIdentifier: "SubtasksCollectionViewController") as? SubtasksCollectionViewController else {
            return
        }

        // Pass the selected time capsule's subtasks to the SubtasksCollectionViewController
        subtasksVC.subtasks = selectedCapsule.subtasks

        // Use a navigation controller to push the SubtasksCollectionViewController
        navigationController?.pushViewController(subtasksVC, animated: true)
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






