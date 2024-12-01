import MusicKit
import SwiftUI

struct AlbumView: View {
  let album: Album

  var body: some View {
    VStack(alignment: .leading) {
      if let artwork = album.artwork {
        ArtworkImage(artwork: artwork, width: 120)
      }

      Text(album.title)
        .font(.headline)
        .lineLimit(2)

      Text(album.artistName)
        .font(.subheadline)
        .foregroundStyle(.secondary)
        .lineLimit(1)
    }
    .frame(width: 120)
  }
}
