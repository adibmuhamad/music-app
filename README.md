# MUSIC APP

Neumorphic Music App which looks bit dense but is a pretty simple and modern using Flutter!

Illustration [Dribbble](https://dribbble.com/shots/15776206-NEUROMORPHIC-MUSIC-APP)

## Features

1. Play/pause/next/previous songs
2. Play music on background

## Supported Device

- Android device with minimum API 23 **(Android 6.0)**

## Build App requirements

- Recommended using Flutter 2.2.1 in this [Stable channel](https://github.com/flutter/flutter.git)
- Using Dart v2.13.1

## Instructions

1. Clone from this repository
   - Copy repository url
   - Open your fav code editor _(Recommended using Android Studio)_
   - New -> Project from Version Control..
   - Paste the url, click OK
2. Run "flutter pub get" in the project directory or click the highlighted instruction in Android Studio
3. Prepare the Android Virtual Device or real device
4. Run main.dart

## Code Design & Structure

This project directory consist of 5 directories:
1 **Pages**: consists page that shown to the user
   - `player_page`: provide the player screen for the components and declare the basic functional
2. **Utils**: consists tools that support the component's function
   - `music_util`: function to support formating millis to duration format (xx:xx)
3. **Widgets**: consists widgets that build the screen and do it's function
   - `circular_soft_button`: widget that provide custom neumorphic button
   - `song_card`: widget that provide play card

## Credit

- Flaticon
