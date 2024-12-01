import Foundation

extension String {
  func formatDate() -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"

    if let date = inputFormatter.date(from: self) {
      let outputFormatter = DateFormatter()
      outputFormatter.dateFormat = "d MMM yyyy"

      let day = Calendar.current.component(.day, from: date)
      let numberSuffix: String
      switch day {
      case 01, 21, 31: numberSuffix = "st"
      case 02, 22: numberSuffix = "nd"
      case 03, 23: numberSuffix = "rd"
      default: numberSuffix = "th"
      }

      outputFormatter.setLocalizedDateFormatFromTemplate("d'\(numberSuffix)' MMM yyyy")
      return outputFormatter.string(from: date)
    } else {
      return nil
    }
  }
}
