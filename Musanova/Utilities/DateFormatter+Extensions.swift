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

extension String {
  /// Formats a date string with ordinal numbers (1st, 2nd, etc.)
  func formatDate() -> String? {
    guard let date = DateFormatter.milestoneFormatter.date(from: self) else {
      return nil
    }

    let day = Calendar.current.component(.day, from: date)
    let numberSuffix = day.ordinalSuffix

    DateFormatter.displayFormatter.setLocalizedDateFormatFromTemplate("d'\(numberSuffix)' MMM yyyy")
    return DateFormatter.displayFormatter.string(from: date)
  }
}

extension Int {
  /// Returns the ordinal suffix for a number (st, nd, rd, th)
  var ordinalSuffix: String {
    switch self {
    case 1, 21, 31: return "st"
    case 2, 22: return "nd"
    case 3, 23: return "rd"
    default: return "th"
    }
  }
}
