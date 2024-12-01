import MusicKit
import SwiftUI

struct ArtworkImage: View {
  let artwork: Artwork
  let width: CGFloat

  var body: some View {
    AsyncImage(url: artwork.url(width: Int(width), height: Int(width))) { image in
      image
        .resizable()
        .aspectRatio(contentMode: .fit)
    } placeholder: {
      Color.gray
    }
    .frame(width: width, height: width)
  }
}
