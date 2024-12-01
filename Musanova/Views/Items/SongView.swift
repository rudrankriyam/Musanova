import MusicKit
import SwiftUI

struct SongView: View {
  let song: Song

  var body: some View {
    VStack(alignment: .leading) {
      if let artwork = song.artwork {
        ArtworkImage(artwork: artwork, width: 120)
      }

      Text(song.title)
        .font(.headline)
        .lineLimit(2)

      Text(song.artistName)
        .font(.subheadline)
        .foregroundStyle(.secondary)
        .lineLimit(1)
    }
    .frame(width: 120)
  }
}
