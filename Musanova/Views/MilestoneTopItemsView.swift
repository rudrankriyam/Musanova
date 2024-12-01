import MusanovaKit
import SwiftUI

struct MilestoneTopItemsView<Item, V: View>: View where Item: Identifiable, Item: MusicItem {
  let header: String
  let data: MusicItemCollection<Item>
  let content: (Item) -> V

  var body: some View {
    ScrollView(.horizontal) {
      Text(header)
        .font(.title2)
        .bold()
        .frame(maxWidth: .infinity, alignment: .leading)

      LazyHStack {
        ForEach(data) { item in
          content(item)
        }
      }
      .padding(.top)
    }
  }
}
