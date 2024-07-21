# booktown

Flutter SDK version - 3.22.3

Developer - Anuradha Siribaddana
Github - AnuradhaDev96

# Getting Started

You should have Flutter SDK version 3.22.3.
Recommend fvm (flutter version manager) to install or flutter upgrade.

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

# Best Practices
Following resources are only for review purpose.

All the tasks related to development are here.
1. [Task List](https://github.com/AnuradhaDev96/booktown/issues)
2. [Closed Task List](https://github.com/AnuradhaDev96/booktown/issues?q=is%3Aissue+is%3Aclosed)
3. [Branch List](https://github.com/AnuradhaDev96/booktown/branches)
4. Line length for dart is 120 (set in Android Studio)