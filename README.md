# Jolly Podcast

A Flutter podcast application for Africa by Africans, featuring trending episodes, audio playback, and user authentication.

## 📱 Features

- User authentication with phone number and password
- Browse trending podcast episodes
- Audio playback with play/pause, seek, and skip controls
- Pagination for infinite scrolling
- Secure token storage
- Beautiful UI with custom animations and effects

## 🚀 Steps to Run the Project

### Prerequisites
- Flutter SDK (3.9.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- An Android/iOS device or emulator

### Installation

1. **Clone the repository**
   ```bash
   cd /Users/mac/StudioProjects/jolly_podcast
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate environment files** (if using envied for API keys)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Additional Commands

- **Clean build** (if you encounter issues):
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

- **Run on specific device**:
   ```bash
   flutter devices  # List available devices
   flutter run -d <device_id>
   ```

## 🏗️ Project Structure

```
lib/
├── backend/
│   ├── models/          # Data models (trending, login, episodes)
│   ├── auth_provider.dart
│   └── episodes_provider.dart
├── screens/
│   ├── splash/          # Splash screen
│   ├── login/           # Authentication screens
│   └── home/            # Home and player screens
├── services/            # API service layer
│   ├── api_service.dart
│   ├── auth_service.dart
│   └── episodes_service.dart
├── widgets/             # Reusable components
│   ├── episode_card.dart
│   └── circular_action_button.dart
├── utility/             # Utilities (theme, colors, sizes)
└── env/                 # Environment configuration
```

## 🎯 State Management Approach

### **Provider Pattern**

The app uses **Provider** as the state management solution. This choice was made for the following reasons:

1. **Simplicity**: Provider is easy to understand and implement, making the codebase accessible
2. **Performance**: Efficient rebuilds with `Consumer` and selective listening
3. **Separation of Concerns**: Clean separation between UI and business logic
4. **Scalability**: Easy to extend and maintain as the app grows

### Implementation Details

- **AuthProvider**: Manages authentication state, login, logout, and token retrieval
- **EpisodesProvider**: Handles trending episodes data, pagination, and loading states

Both providers follow best practices:
- No UI logic (navigation, dialogs) in providers
- Proper error handling with rethrow for UI layer handling
- Private state variables with public getters
- Loading states for better UX

### Service Layer Architecture

A dedicated service layer separates API calls from state management:
- **ApiService**: Base service with common utilities (headers, token management, error parsing)
- **AuthService**: Authentication API calls
- **EpisodesService**: Episodes-related API calls

This architecture ensures:
- Single Responsibility Principle
- Easy testing and mocking
- Reusable API logic
- Clean provider code

## 📋 Assumptions Made

1. **Authentication**
   - API expects phone number and password in multipart/form-data format
   - Token is stored securely using `flutter_secure_storage`
   - Token refresh is not implemented (assumed token has long expiry)

2. **API Structure**
   - Backend follows REST conventions
   - Trending episodes endpoint supports pagination (page, per_page parameters)
   - Episode audio URLs are direct playback URLs (not requiring additional processing)

3. **User Experience**
   - Splash screen displays for 2.5 seconds (sufficient for branding and token check)
   - Horizontal scrolling for episodes is preferred over vertical
   - 10 episodes per page is optimal for performance and UX

4. **Device Support**
   - App targets modern devices (responsive design using flutter_screenutil)
   - Audio playback uses just_audio (supports most audio formats)
   - No offline mode required initially

5. **Error Handling**
   - Network errors show user-friendly messages
   - Authentication errors redirect to login
   - Failed audio loads show retry option

## 🔧 What Would Be Improved With More Time

### 1. **Feature Enhancements**
   - Search functionality for podcasts and episodes
   - User favorites/bookmarks with local storage
   - Playback history tracking
   - Download episodes for offline listening
   - Background audio playback with notification controls
   - Sleep timer
   - Playback speed controls
   - Categories and genre filtering

### 2. **Technical Improvements**
   - **Testing**: Unit tests for providers, widget tests for UI, integration tests for flows
   - **Error Boundary**: Global error handling with Sentry/Firebase Crashlytics
   - **Caching**: Implement local caching for episodes (Hive/Drift)
   - **Image Caching**: Use cached_network_image for better performance
   - **Dependency Injection**: Use GetIt or Riverpod for better DI
   - **Analytics**: Track user behavior with Firebase Analytics
   - **Performance**: Implement lazy loading, image optimization, code splitting

### 3. **Code Quality**
   - **Localization**: Multi-language support (i18n)
   - **Accessibility**: Screen reader support, better contrast ratios
   - **Documentation**: Comprehensive API documentation, code comments
   - **CI/CD**: Automated builds, tests, and deployments
   - **Code Review**: Setup linting rules, pre-commit hooks

### 4. **UX Improvements**
   - Skeleton loaders instead of circular progress indicators
   - Pull-to-refresh on home page
   - Swipe gestures for player controls
   - Better error states with illustrations
   - Onboarding flow for first-time users
   - Dark mode support
   - Animations and transitions polish

### 5. **Architecture**
   - Migrate to **Riverpod** for more robust state management
   - Implement **BLoC pattern** for complex state logic
   - Add repository pattern for data abstraction
   - Implement proper API response caching strategy
   - Add retry logic with exponential backoff for API calls

### 6. **Security**
   - Implement certificate pinning
   - Add biometric authentication option
   - Encrypt sensitive data in local storage
   - Implement token refresh mechanism
   - Add rate limiting on API calls

## 📦 Dependencies

### Core
- `flutter_screenutil` - Responsive UI design
- `provider` - State management
- `google_fonts` - Custom fonts

### Network & Storage
- `http` - API requests
- `flutter_secure_storage` - Secure token storage
- `envied` - Environment configuration

### Media
- `just_audio` - Audio playback
- `video_player` - Video backgrounds

### UI Components
- `phone_text_field` - Phone input (optional)
- `url_launcher` - External links
- `flutter_email_sender` - Email functionality

## 📄 License

This project is private and not licensed for public use.

## 👨‍💻 Development Notes

- App follows Flutter best practices and clean architecture principles
- Responsive design using percentage-based sizing (pW, pH)
- Custom theme with IAColors for consistent branding
- Proper disposal of resources (controllers, streams, timers)
- Mounted checks before setState to prevent memory leaks

---

**Built with ❤️ for African podcast lovers**
