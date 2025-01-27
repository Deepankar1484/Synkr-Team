import UIKit

class CircularProgressBar: UIView {

    // MARK: - Properties
    private var progressLayer = CAShapeLayer()
    private var backgroundLayer = CAShapeLayer()
    private var progressLabel = UILabel()

    var progressColor: UIColor = .systemBlue {
        didSet { progressLayer.strokeColor = progressColor.cgColor }
    }
    var trackColor: UIColor = .lightGray {
        didSet { backgroundLayer.strokeColor = trackColor.cgColor }
    }
    var textColor: UIColor = .black {
        didSet { progressLabel.textColor = textColor }
    }

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Setup View
    private func setupView() {
        // Set the background color
        backgroundColor = UIColor(red: 0.9, green: 0.85, blue: 1.0, alpha: 1.0) // Light purple background

        // Setup background layer with no fill (transparent)
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = trackColor.cgColor
        backgroundLayer.lineWidth = 10
        backgroundLayer.lineCap = .round
        layer.addSublayer(backgroundLayer)

        // Setup progress layer
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 10
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)

        // Setup progress label
        progressLabel.textAlignment = .center
        progressLabel.textColor = textColor
        progressLabel.font = UIFont.boldSystemFont(ofSize: 18)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressLabel)

        // Center the label in the view
        NSLayoutConstraint.activate([
            progressLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    // MARK: - Circular Path
    private func circularPath() -> UIBezierPath {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = min(bounds.width, bounds.height) / 2 - 5 // Decreased padding for a tighter ring
        return UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Update path when layout changes
        backgroundLayer.path = circularPath().cgPath
        progressLayer.path = circularPath().cgPath
        
        // Adjust font size dynamically based on the size of the view
        adjustFontSize()
    }

    // MARK: - Adjust Font Size Dynamically
    private func adjustFontSize() {
        // Calculate the new font size based on the size of the view (min of width or height)
        let minSize = min(bounds.width, bounds.height)
        let fontSize = minSize / 4  // You can tweak the divisor for different scaling behavior
        progressLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
    }

    // MARK: - Set Progress
    func setProgress(to progress: CGFloat, animated: Bool = true) {
        let clampedProgress = max(0, min(progress, 1)) // Clamp between 0 and 1
        progressLabel.text = "\(Int(clampedProgress * 100))%" // Update label

        if animated {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = progressLayer.strokeEnd
            animation.toValue = clampedProgress
            animation.duration = 0.5
            progressLayer.add(animation, forKey: "progressAnim")
        }

        progressLayer.strokeEnd = clampedProgress
    }
}
