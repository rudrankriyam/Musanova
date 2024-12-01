import MusanovaKit
import SwiftUI

struct MilestoneTopAlbumsView: View {
  var topAlbums: Albums

  var body: some View {
    MilestoneTopItemsView(header: "Top Albums", data: topAlbums) { album in
      VStack {
        AsyncImage(url: album.artwork?.url(width: 150, height: 150))
          .cornerRadius(16)
          .frame(width: 150, height: 150)

        Text(album.title)
          .bold()

        Text(album.artistName)
          .font(.caption)
      }
      .frame(width: 150)
    }
  }
}
