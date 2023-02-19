# TV Maze App

App that displays shows using [Tv Maze API](https://www.tvmaze.com/api)

## Getting Started
This app was developed using Flutter, you can setup your environment using [this link](https://docs.flutter.dev/get-started/install).

To run the app in development mode, run the following commands:
```bash
flutter pub run build_runner build
flutter run
```

`flutter pub run build_runner build` is used to generate files required to run or test the app (Json Serializers, Mocks, etc).

## Features

### Mandatory
- [x] List all of the series contained in the API used by the paging scheme provided by the API.
- [x] Allow users to search series by name.
- [x] The listing and search views must show at least the name and poster image of the
series.
- [x] After clicking on a series, the application should show the details of the series.
- [x] After clicking on an episode, the application should show the episode’s information.

### Bonus (Optional)
- [x] Allow the user to save a series as a favorite.
- [x] Allow the user to delete a series from the favorites list.
- [x] Unit Tests.