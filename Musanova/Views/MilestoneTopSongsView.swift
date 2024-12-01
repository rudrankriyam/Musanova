import MusanovaKit
import SwiftUI

struct MilestoneTopSongsView: View {
  var topSongs: Songs

  var body: some View {
    MilestoneTopItemsView(header: "Top Songs", data: topSongs) { song in
      VStack {
        AsyncImage(url: song.artwork?.url(width: 150, height: 150))
          .cornerRadius(16)
          .frame(width: 150, height: 150)

        Text(song.title)
          .bold()

        Text(song.artistName)
          .font(.caption)
      }
      .frame(width: 150)
    }
  }
}
