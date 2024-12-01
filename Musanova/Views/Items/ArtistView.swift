import MusicKit
import SwiftUI

struct ArtistView: View {
  let artist: Artist

  var body: some View {
    VStack {
      if let artwork = artist.artwork {
        ArtworkImage(artwork: artwork, width: 120)
          .clipShape(Circle())
      }

      Text(artist.name)
        .font(.headline)
        .lineLimit(2)
        .multilineTextAlignment(.center)
    }
    .frame(width: 120)
  }
}
