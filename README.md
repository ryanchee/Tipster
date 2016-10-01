# Tipster

# Pre-work - Tipster

Tipster is a tip calculator application for iOS.

Submitted by: Ryan Chee

Time spent: 10 hours

## User Stories

The following **required** functionality is complete:

* [X] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [X] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [X] UI animations
* [X] Remembering the bill amount across app restarts (if < 1mins)
* [X] Using locale-specific currency and currency thousands separators.
* [X] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [X] Added option to randomly select a tip percetage by phone shake.
- [X] Check against non numeric characters entered.
- [X] Added app logo image on boot.
- [X] Remembering tip percentage options accross app restarts.

## Video Walkthrough

**Walkthrough of required and optional user stories:**
- Displays UIAnimation, "shake" for random tip, persistent data, keyboard as first responder.

<img alt="Tipster Tip Calculator" src="https://i.imgur.com/9lfzuFr.gif" style="max-width: 100%; min-height: 595px;" original-title="">

**Walkthrough of locale specific currency:**
- Displays the locale-specific currency and currency thousands separators changing based off the location.

<img alt="Locale Currency Gif" src="https://i.imgur.com/3ULkgYR.gif" style="max-width: 100%; min-height: 589px;" original-title="">

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.
**Please run on iphone 5 or 5s.**
Small bugs here and there...
- 1. I am on Xcode 7.2 (Swift 2.2.x) so some syntax confusion with NSNotification.
- 2. Typing non numeric characters.
- 3. Keeping the UI updated with every computation in background (Pickerview when selecting a segment, Segmented Control on random tip).
- 4. Trying to register the app for notification of close/open in order to check NSDates

## License

    Copyright [2016] [Ryan Chee]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
