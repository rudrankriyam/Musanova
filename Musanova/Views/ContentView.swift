import MusicKit
import SwiftUI

/// The main content view displaying music milestones for a specific year
struct ContentView: View {
  @StateObject private var viewModel = MilestonesViewModel()

  var body: some View {
    NavigationStack {
      Group {
        if viewModel.milestones.isEmpty {
          ProgressView()
        } else {
          MilestoneListView(milestones: viewModel.milestones)
        }
      }
      .navigationTitle("Milestones for 2024")
    }
    .task {
      await viewModel.fetchMilestones(forYear: 2024)
    }
    .alert("Error", isPresented: .constant(viewModel.error != nil)) {
      Button("OK") {}
    } message: {
      Text(viewModel.error?.localizedDescription ?? "")
    }
  }
}

/// A view that displays a list of music milestones
struct MilestoneListView: View {
  let milestones: MusicSummaryMilestones

  var body: some View {
    ScrollView {
      LazyVStack(spacing: 20) {
        ForEach(milestones) { milestone in
          MilestoneSection(milestone: milestone)
        }
      }
      .padding()
    }
  }
}

/// A section displaying a single milestone with its associated top items
struct MilestoneSection: View {
  let milestone: MusicSummaryMilestone

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      MilestoneHeaderView(milestone: milestone)

      if !milestone.topAlbums.isEmpty {
        MilestoneTopAlbumsView(topAlbums: milestone.topAlbums)
      }

      if !milestone.topArtists.isEmpty {
        MilestoneTopArtistsView(topArtists: milestone.topArtists)
      }

      if !milestone.topSongs.isEmpty {
        MilestoneTopSongsView(topSongs: milestone.topSongs)
      }
    }
    .accessibilityElement(children: .contain)
    .accessibilityLabel("Milestone section")
  }
}
