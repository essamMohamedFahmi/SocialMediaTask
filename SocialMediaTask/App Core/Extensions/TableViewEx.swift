import UIKit

protocol IdentifiableCell: class {
    static var CellIdentifier: String { get }
}

extension UITableViewCell: IdentifiableCell {
    static var CellIdentifier: String {
        return "\(self)"
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        return self.next(of: UITableView.self)
    }
    
    var indexPath: IndexPath? {
        return self.tableView?.indexPath(for: self)
    }
}

extension UITableView
{
    func register<T>(cell: T.Type) where T: UITableViewCell
    {
        register(cell.nib, forCellReuseIdentifier: cell.CellIdentifier)
    }
    
    func dequeueReusableCell<T: IdentifiableCell>(with cell: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: cell.CellIdentifier) as? T
    }
    
    func dequeue<Cell: UITableViewCell>() -> Cell
    {
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError("Error in cell")
        }
        
        return cell
    }
    
    ///Get visible cell height
    var visibleCellsHeight: CGFloat
    {
        self.setNeedsLayout()
        self.layoutIfNeeded()
        return visibleCells.reduce(0) { $0 + $1.frame.height }
    }
    
    /// Check if cell at the specific section and row is visible
    /// - Parameters:
    /// - section: an Int reprenseting a UITableView section
    /// - row: and Int representing a UITableView row
    /// - Returns: True if cell at section and row is visible, False otherwise
    func isCellVisible(section:Int, row: Int) -> Bool
    {
        guard let indexes = self.indexPathsForVisibleRows else {
            return false
        }
        return indexes.contains { $0.section == section && $0.row == row }
    }
    
    func removeEmptyCells()
    {
        tableFooterView = UIView()
    }
}
