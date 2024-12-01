import Foundation
import os.log

/// An actor that handles scraping Apple Music data and authentication tokens
actor AppleMusicScraper {
  private let apiKey: String
  private let firecrawlURL = URL(string: "https://api.firecrawl.dev/v1/scrape")!

  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier ?? "AppleMusicScraper",
    category: "AppleMusicScraper"
  )

  /// Initialize with Firecrawl API key
  /// - Parameter apiKey: The API key for Firecrawl service
  init(apiKey: String) {
    self.apiKey = apiKey
    logger.info("Initialized AppleMusicScraper with API key: \(apiKey.prefix(8))...")
  }

  /// Represents authentication credentials
  struct Credentials {
    let token: String
    let url: String
  }

  /// Fetches authentication credentials from a given Apple Music URL
  /// - Parameter url: The Apple Music URL to scrape
  /// - Returns: Credentials containing the authentication token
  func getCreds(url: String) async throws -> Credentials {
    logger.debug("Starting credential retrieval for URL: \(url)")
    let startTime = Date()

    let payload: [String: Any] = [
      "url": url,
      "formats": ["html"],
      "waitFor": 1000,
    ]

    var request = URLRequest(url: firecrawlURL)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    request.httpBody = try JSONSerialization.data(withJSONObject: payload)

    logger.debug("Sending request to Firecrawl API")
    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse else {
      logger.error("Invalid HTTP response type")
      throw ScraperError.networkError("Invalid response type")
    }

    logger.debug("Received response with status code: \(httpResponse.statusCode)")

    guard httpResponse.statusCode == 200 else {
      logger.error("HTTP error: \(httpResponse.statusCode)")
      throw ScraperError.networkError("Invalid response from Firecrawl API")
    }

    let firecrawlResponse = try JSONDecoder().decode(FirecrawlResponse.self, from: data)
    let htmlContent = firecrawlResponse.data.html

    logger.debug("Successfully decoded Firecrawl response, HTML length: \(htmlContent.count)")

    let tokenPattern = try NSRegularExpression(
      pattern: "devToken=([^&\"]+)",
      options: []
    )

    let range = NSRange(htmlContent.startIndex..<htmlContent.endIndex, in: htmlContent)
    let matches = tokenPattern.matches(in: htmlContent, options: [], range: range)

    let tokens = matches.compactMap { match -> String? in
      guard let tokenRange = Range(match.range(at: 1), in: htmlContent) else { return nil }
      return String(htmlContent[tokenRange])
    }

    logger.debug("Found \(tokens.count) potential tokens")

    if let longestToken = tokens.max(by: { $0.count < $1.count }),
      longestToken.count > 250
    {
      let elapsed = Date().timeIntervalSince(startTime)
      logger.info("Successfully retrieved credentials in \(String(format: "%.2f", elapsed))s")
      logger.debug("Token (first 50 chars): \(longestToken.prefix(50))...")
      return Credentials(token: longestToken, url: url)
    }

    logger.error("No valid authentication token found")
    throw ScraperError.authenticationError("Could not find authentication token")
  }
}

/// Errors that can occur during scraping operations
enum ScraperError: Error {
  case invalidURL
  case networkError(String)
  case authenticationError(String)
  case decodingError(String)
}

/// Response structure from the Firecrawl API
struct FirecrawlResponse: Codable {
  let success: Bool
  let data: FirecrawlData

  struct FirecrawlData: Codable {
    let html: String
  }
}
