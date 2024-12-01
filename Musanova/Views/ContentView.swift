import MusanovaKit
import MusicKit
import SwiftUI

/// The main content view displaying music milestones for a specific year
struct ContentView: View {
  @StateObject private var viewModel = MilestonesViewModel()
  private let scraper = AppleMusicScraper(apiKey: Configuration.firecrawlApiKey)

  var body: some View {
    NavigationStack {
      ScrollView {
        ForEach(viewModel.milestones) { milestone in
          VStack {
            MilestoneView(milestone: milestone)

            MilestoneTopAlbumsView(topAlbums: milestone.topAlbums)

            MilestoneTopArtistsView(topArtists: milestone.topArtists)
          }
          .padding(.bottom)
        }
        .padding()
      }
      .navigationTitle("Milestones for 2024")
    }
    .task {
      do {
        let creds = try await scraper.getCreds(
          url: "https://music.apple.com/us/playlist/a-list-pop/pl.5ee8333dbe944d9f9151e97d92d1ead9")
        await viewModel.fetchMilestones(forYear: 2024, token: creds.token)
      } catch {
        viewModel.error = error
      }
    }
    .alert("Error", isPresented: .constant(viewModel.error != nil)) {
      Button("OK") {}
    } message: {
      Text(viewModel.error?.localizedDescription ?? "")
    }
  }
}

#Preview {
  ContentView()
}
