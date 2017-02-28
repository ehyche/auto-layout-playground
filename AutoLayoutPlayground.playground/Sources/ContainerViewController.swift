
import UIKit
import PlaygroundSupport

public class ContainerViewController: UIViewController {


    public var containerView: UIView = UIView(frame: .zero)

    private var sliderX: UISlider = UISlider(frame: .zero)
    private var sliderY: UISlider = UISlider(frame: .zero)
    private var widthNameLabel: UILabel = UILabel(frame: .zero)
    private var widthValueLabel: UILabel = UILabel(frame: .zero)
    private var heightNameLabel: UILabel = UILabel(frame: .zero)
    private var heightValueLabel: UILabel = UILabel(frame: .zero)
    private let fontSize: CGFloat = 18.0
    private let containerViewInitialSize: CGSize = CGSize(width: 375.0, height: 375.0)
    private let containerViewMinimumSize: CGSize = CGSize(width: 1.0, height: 1.0)
    private let containerViewMaximumSize: CGSize = CGSize(width: 512.0, height: 512.0)
    private var containerWidthConstraint = NSLayoutConstraint()
    private var containerHeightConstraint = NSLayoutConstraint()

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.lightGray
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = 2.0
        view.addSubview(containerView)

        sliderX.translatesAutoresizingMaskIntoConstraints = false
        sliderX.minimumValue = Float(containerViewMinimumSize.width)
        sliderX.maximumValue = Float(containerViewMaximumSize.width)
        sliderX.value = Float(containerViewInitialSize.width)
        sliderX.addTarget(self, action: #selector(self.sliderXChanged), for: [.valueChanged])
        view.addSubview(sliderX)

        sliderY.translatesAutoresizingMaskIntoConstraints = false
        sliderY.minimumValue = Float(containerViewMinimumSize.height)
        sliderY.maximumValue = Float(containerViewMaximumSize.height)
        sliderY.value = Float(containerViewInitialSize.height)
        sliderY.addTarget(self, action: #selector(self.sliderYChanged), for: [.valueChanged])
        view.addSubview(sliderY)

        widthNameLabel.textColor = UIColor.black
        widthNameLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        widthNameLabel.text = "Width"
        widthNameLabel.translatesAutoresizingMaskIntoConstraints = false
        widthNameLabel.backgroundColor = view.backgroundColor
        view.addSubview(widthNameLabel)

        widthValueLabel.textColor = UIColor.black
        widthValueLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        widthValueLabel.translatesAutoresizingMaskIntoConstraints = false
        widthValueLabel.textAlignment = .right
        widthValueLabel.text = "\(sliderX.value)"
        widthValueLabel.backgroundColor = view.backgroundColor
        view.addSubview(widthValueLabel)

        heightNameLabel.textColor = UIColor.black
        heightNameLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        heightNameLabel.text = "Height"
        heightNameLabel.translatesAutoresizingMaskIntoConstraints = false
        heightNameLabel.backgroundColor = view.backgroundColor
        view.addSubview(heightNameLabel)

        heightValueLabel.textColor = UIColor.black
        heightValueLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        heightValueLabel.translatesAutoresizingMaskIntoConstraints = false
        heightValueLabel.textAlignment = .right
        heightValueLabel.text = "\(sliderY.value)"
        heightValueLabel.backgroundColor = view.backgroundColor
        view.addSubview(heightValueLabel)

        // Set up contraints
        let views = ["container": containerView, "sliderX": sliderX, "sliderY": sliderY,
                     "widthName": widthNameLabel, "widthValue": widthValueLabel,
                     "heightName": heightNameLabel, "heightValue": heightValueLabel]
        let metrics = ["margin": 40.0, "marginBottom": 20.0, "sliderGap": 10.0]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(margin)-[widthName]-(sliderGap)-[sliderX]-(sliderGap)-[widthValue]-(margin)-|",
                                                           options: [.alignAllCenterY],
                                                           metrics: metrics,
                                                           views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(margin)-[heightName(==widthName)]-(sliderGap)-[sliderY]-(sliderGap)-[heightValue(==widthValue)]-(margin)-|",
                                                           options: [.alignAllCenterY],
                                                           metrics: metrics,
                                                           views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[sliderX]-(marginBottom)-[sliderY]-(margin)-|",
                                                           options: NSLayoutFormatOptions(rawValue: 0),
                                                           metrics: metrics,
                                                           views: views))

        view.addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0))

        view.addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: containerView, attribute: .width, multiplier: 1.0, constant: 16.0))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 8.0))
        view.addConstraint(NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: widthNameLabel, attribute: .top, multiplier: 1.0, constant: 0.0))


        containerWidthConstraint = NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: containerViewInitialSize.width)
        containerHeightConstraint = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: containerViewInitialSize.height)

        view.addConstraint(containerWidthConstraint)
        view.addConstraint(containerHeightConstraint)
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

    @objc public func sliderXChanged() {
        updateWidth()
    }

    @objc public func sliderYChanged() {
        updateHeight()
    }

    public func updateWidth() {
        containerWidthConstraint.constant = CGFloat(sliderX.value)
        widthValueLabel.text = String(format: "%.1f", sliderX.value)
    }

    public func updateHeight() {
        containerHeightConstraint.constant = CGFloat(sliderY.value)
        heightValueLabel.text = String(format: "%.1f", sliderY.value)
    }

    public func containerViewSizeChanged(to newSize: CGSize, from oldSize: CGSize) {

        // Compute scale values in range [0.0,1.0]
        let currentScaleX = sliderX.value / sliderX.maximumValue
        let currentScaleY = sliderY.value / sliderY.maximumValue
        // Now assign new maximums
        sliderX.maximumValue = Float(newSize.width)
        sliderY.maximumValue = Float(newSize.height)
        // Recompute the values based on the next maximum
        sliderX.value = currentScaleX * sliderX.maximumValue
        sliderY.value = currentScaleY * sliderY.maximumValue

        updateWidth()
        updateHeight()
    }

}

