import UIKit

public enum AppSegmentControlType {
    case address
    case size
    case dough
}

public final class AppSegmentControl: UIView {

    // MARK: - Properties
    var segmentView: AppSegmentControlView?

    public var onSegmentValueChanged: ((Int) -> Void)?

    // MARK: - Init
    public init(type: AppSegmentControlType) {
        super.init(frame: .zero)
        configure(type: type)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public methods
public extension AppSegmentControl {
    func setDefaultSelectedSegment(_ index: Int) {
        segmentView?.setDefaultSelectedSegment(index)
    }
}

// Настраиваем сегмент вью
private extension AppSegmentControl {
    func configure(type: AppSegmentControlType) {
        switch type {
        case .address:
            segmentView = AppSegmentControlView(items: ["Доставка", "В пиццерии"], defaultSelection: 0)
            segmentView?.setSegmentColor(AppColors.buttonOrange)
            segmentView?.backgroundColor = AppColors.backgroundBlack
        case .size:
            segmentView = AppSegmentControlView(items: AppConstants.sizeCases, defaultSelection: 1)
        case .dough:
            segmentView = AppSegmentControlView(items: AppConstants.doughCases, defaultSelection: 0)
        }

        guard let segmentView else { print("segmentView is nil"); return }
        setupLayout(segmentView)

        segmentView.onSegmentControllerValueChanged = { [weak self] value in
            self?.onSegmentValueChanged?(value)
        }
    }
}

// MARK: - Setup Layout
extension AppSegmentControl {
    func setupLayout(_ segmentView: AppSegmentControlView) {
        addSubviews(segmentView)
        segmentView.setConstraints()
    }
}
