import MusanovaKit
import SwiftUI

struct MilestoneView: View {
  let milestone: MusicSummaryMilestone

  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(milestone.value)
          .font(.title)
          .bold()

        Text("Listen time: \(milestone.listenTimeInMinutes)")
        Text("Date reached: \(milestone.dateReached.formatDate() ?? "")")
      }

      Spacer()
    }
  }
}
