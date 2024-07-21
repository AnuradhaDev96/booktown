# Booktown

![180](https://github.com/user-attachments/assets/b0247f6f-ab8a-4969-a642-c36ed52b43a7)

Developer - Anuradha Siribaddana
Github - AnuradhaDev96
Flutter SDK version - 3.22.3

# Getting Started

You should have Flutter SDK version 3.22.3.
Recommend fvm (flutter version manager) to install or flutter upgrade.

# Screenshots
Google drive folder with screenshots => [Google Drive](https://drive.google.com/drive/folders/1YEyZ3qL2Cl4fMKzTmdy5uY9NagwCiMqc?usp=sharing)

# Features
## 1. Home page
- Trigger search with keyboard search action and search icon button.
- Show newly released books as default.

## 2. Pagination
- Pagination for default new books is enabled for scrolling.
- Pagination for search results is done while scrolling.
- PageStorage for suitable scrolling views to remember scroll position.

## 3. Programming
- Reactive programming with RxDart => **Package: [rxdart](https://pub.dev/packages/rxdart)**
- Functional programming with Dartz => **Package: [dartz](https://pub.dev/packages/dartz)**
- Pass functions as params => Refer HomeAppBar widget.
- For searching strings with multiple words => Used `Uri.encodeQueryComponent(query)`

## 4. Animations
- Zoom out (ScaleTransition) when launching home page.
- Hero animations when navigating from book list item to book details page.

# Additional Features
1. Optional Haptic feedbacks when displaying snack bars.
2. Interceptors written for dio client
3. When user double taps on book list item, Heart animation displays.
4. Book search history (search history is saved in sqlite db)
5. App icons for both ios and android versions are configured.

# Best Practices
Following resources are only for review purpose.

All the tasks related to development are here.
1. [Task List](https://github.com/AnuradhaDev96/booktown/issues)
2. [Closed Task List](https://github.com/AnuradhaDev96/booktown/issues?q=is%3Aissue+is%3Aclosed)
3. [Branch List](https://github.com/AnuradhaDev96/booktown/branches)
4. Line length for dart is 120 (set in Android Studio)
5. [Pull requests](https://github.com/AnuradhaDev96/booktown/pulls?q=is%3Apr+is%3Aclosed)
