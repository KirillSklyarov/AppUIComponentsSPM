import UIKit

// Этот класс таблицы позволяет не выставлять высоту, она высчитывается автоматом
open class AppTableView: UITableView {
    open override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: contentSize.width, height: contentSize.height)
    }

    open override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    open override func reloadData() {
        super.reloadData()
        invalidateIntrinsicContentSize()
    }
}

// Мы определили метод, который будет убирать сепаратор у последней ячейки
extension AppTableView: UITableViewDelegate {
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastCellRow = tableView.numberOfRows(inSection: indexPath.section) - 1
        if indexPath.row == lastCellRow {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        } else {
            cell.separatorInset = .zero
        }
    }
}
