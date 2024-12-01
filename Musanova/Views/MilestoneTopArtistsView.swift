import MusanovaKit
import SwiftUI

struct MilestoneTopArtistsView: View {
  var topArtists: Artists

  var body: some View {
    MilestoneTopItemsView(header: "Top Artists", data: topArtists) { artist in
      VStack {
        AsyncImage(url: artist.artwork?.url(width: 150, height: 150))
          .cornerRadius(16)
          .frame(width: 150, height: 150)

        Text(artist.name)
          .bold()
      }
      .frame(width: 150)
    }
  }
}
