//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

class TestCardView : UIView {
    var imageView: UIImageView
    var titleLabel: UILabel

    override init(frame: CGRect) {
        imageView = UIImageView(frame: .zero)
        titleLabel = UILabel(frame: .zero)

        super.init(frame: frame)

        backgroundColor = UIColor.darkGray

        imageView.backgroundColor = UIColor.red
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 2.0
        imageView.image = UIImage(named: "image.jpg")
        addSubview(imageView)

        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.systemFont(ofSize: 14.0)
        titleLabel.textColor = UIColor.black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = backgroundColor
        titleLabel.text = "This is a really really long title where we don't know quite how long it may be, but it could be really really long."
        addSubview(titleLabel)

        let views: [String: Any] = ["image": imageView, "title": titleLabel]
        let metrics = ["margin": 8.0, "imageMarginRight": 12.0]

        var tmpConstraints = [NSLayoutConstraint]()
        tmpConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:[image]-(imageMarginRight)-[title]-(margin)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        tmpConstraints.append(NSLayoutConstraint(item: titleLabel, attribute: .firstBaseline, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 23.0))
        tmpConstraints.append(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 1.0, constant: 0.0))
        tmpConstraints.append(NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 8.0))
        tmpConstraints.append(NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 8.0))

        let multiplier: CGFloat = (96.0 - 80.0) / (375.0 - 320.0)
        let constant: CGFloat = 80.0 - (multiplier * 320.0)

        let scaledWidthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: multiplier, constant: constant)
        let minWidthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80.0)
        let maxWidthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 96.0)

        minWidthConstraint.priority = UILayoutPriorityDefaultHigh
        maxWidthConstraint.priority = UILayoutPriorityDefaultHigh
        scaledWidthConstraint.priority = UILayoutPriorityDefaultLow

        tmpConstraints.append(minWidthConstraint)
        tmpConstraints.append(maxWidthConstraint)
        tmpConstraints.append(scaledWidthConstraint)

        NSLayoutConstraint.activate(tmpConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        print("self.frame.size=\(self.frame.size) imageView.frame.size = \(imageView.frame.size)")
    }
}

let resizeView = ContainerView(frame: CGRect(x: 0.0, y: 0.0, width: 1024.0, height: 1024.0))
resizeView.containerViewMinimumSize = CGSize(width: 320.0, height: 320.0)
resizeView.containerViewMaximumSize = CGSize(width: 414.0, height: 414.0)
resizeView.containerViewInitialSize = CGSize(width: 375.0, height: 375.0)


let cardView = TestCardView(frame: .zero)
cardView.translatesAutoresizingMaskIntoConstraints = false

resizeView.containerView.addSubview(cardView)

let views = ["card": cardView]

resizeView.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[card]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))

cardView.addConstraint(NSLayoutConstraint(item: cardView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 112.0))
resizeView.containerView.addConstraint(NSLayoutConstraint(item: cardView, attribute: .centerY, relatedBy: .equal, toItem: resizeView.containerView, attribute: .centerY, multiplier: 1.0, constant: 0.0))

PlaygroundPage.current.liveView = resizeView
PlaygroundPage.current.needsIndefiniteExecution = true

