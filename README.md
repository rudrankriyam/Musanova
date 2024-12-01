# Musanova

Musanova is an iOS app that displays your Apple Music milestones and listening history for a specific year.

## Features

- View music milestones for the current year
- Display top albums, artists, and songs

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 6.0+
- Valid Apple Music subscription
- Apple Developer account

## Installation

1. Clone the repository:

```bash
git clone https://github.com/rudrankriyam/Musanova.git
cd Musanova
```

2. Create a `.env` file in the project root with your API keys:

```
FIRECRAWL_API_KEY=your_firecrawl_api_key
```

3. Open `Musanova.xcodeproj` in Xcode:

```bash
open Musanova.xcodeproj
```

4. Configure signing & capabilities:

   - Select the Musanova target
   - Under Signing & Capabilities, select your team
   - Update the bundle identifier if needed

5. Build and run the project (⌘R)

## Configuration

### Environment Variables

Required environment variables:

- `FIRECRAWL_API_KEY`: API key for the Firecrawl service

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support, please open an issue in the GitHub repository or contact the maintainers.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Acknowledgments

- [MusanovaKit](https://github.com/rryam/MusanovaKit)
- [AgniKit](https://github.com/rryam/AgniKit)
- [MusicKit](https://developer.apple.com/documentation/musickit)
