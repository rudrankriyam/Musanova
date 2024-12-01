import Foundation

extension DateFormatter {
  /// Shared date formatter for milestone dates
  static let milestoneFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()

  /// Shared display date formatter
  static let displayFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.setLocalizedDateFormatFromTemplate("d MMM yyyy")
    return formatter
  }()
}
