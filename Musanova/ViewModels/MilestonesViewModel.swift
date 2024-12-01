import MusicKit
import SwiftUI

/// A view model that manages music milestone data and authorization.
@MainActor
final class MilestonesViewModel: ObservableObject {
  /// Published array of music milestones
  @Published private(set) var milestones: MusicSummaryMilestones = []

  /// Published error state
  @Published private(set) var error: MilestoneError?

  /// Fetches music milestones for the specified year
  /// - Parameter year: The year for which to fetch milestones
  func fetchMilestones(forYear year: Int) async {
    do {
      let status = await MusicAuthorization.request()
      guard status == .authorized else {
        throw MilestoneError.unauthorized
        return
      }

      milestones = try await MSummaries.milestones(
        forYear: year,
        musicItemTypes: [.topArtists, .topSongs, .topAlbums],
        developerToken: Configuration.developerToken
      )
    } catch {
      self.error = MilestoneError(error)
    }
  }
}

/// Custom error types for milestone operations
enum MilestoneError: LocalizedError {
  case unauthorized
  case fetchFailed(Error)

  init(_ error: Error) {
    self = .fetchFailed(error)
  }

  var errorDescription: String? {
    switch self {
    case .unauthorized:
      return "Music access not authorized"
    case .fetchFailed(let error):
      return "Failed to fetch milestones: \(error.localizedDescription)"
    }
  }
}
