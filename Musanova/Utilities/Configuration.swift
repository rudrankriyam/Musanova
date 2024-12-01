import Foundation

/// Manages app configuration and environment variables
enum Configuration {
  /// Dictionary to store environment variables
  private static var environmentVariables: [String: String] = {
    loadEnvironmentVariables()
  }()

  /// Loads environment variables from .env file
  private static func loadEnvironmentVariables() -> [String: String] {
    var variables: [String: String] = [:]

    guard let projectDir = Bundle.main.path(forResource: "", ofType: "") else {
      print("Could not find project directory")
      return variables
    }

    let envPath = projectDir + "/.env"

    do {
      let contents = try String(contentsOfFile: envPath, encoding: .utf8)
      let lines = contents.components(separatedBy: .newlines)

      for line in lines {
        let parts = line.components(separatedBy: "=")
        if parts.count == 2 {
          let key = parts[0].trimmingCharacters(in: .whitespaces)
          let value = parts[1].trimmingCharacters(in: .whitespaces)
          variables[key] = value
        }
      }
    } catch {
      print("Error loading .env file: \(error)")
    }

    return variables
  }

  /// Loads an environment variable
  /// - Parameter key: The key of the environment variable
  /// - Returns: The value of the environment variable
  /// - Throws: Fatal error if the environment variable is not found
  static func value(for key: String) -> String {
    if let envValue = ProcessInfo.processInfo.environment[key] {
      return envValue
    }

    if let fileValue = environmentVariables[key] {
      return fileValue
    }

    fatalError("Missing environment variable: \(key)")
  }

  /// The API key for Firecrawl service
  static let firecrawlApiKey = value(for: "FIRECRAWL_API_KEY")
}
