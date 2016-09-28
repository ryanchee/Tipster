# Tipster

# Pre-work - Tipster

Tipster is a tip calculator application for iOS.

Submitted by: Ryan Chee

Time spent: 7 hours spent in total

## User Stories

The following **required** functionality is complete:

* [X] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [X] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [ ] UI animations
* [X] Remembering the bill amount across app restarts (if < 1mins)
* [ ] Using locale-specific currency and currency thousands separators.
* [X] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [X] Added option to randomly select a tip percetage by tap or phone shake.
- [X] Check against non numeric characters entered.
- [X] Added app logo image on boot.
- [X] Remembering tip percentage options accross app restarts.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img alt="Tip Calculator for CodePath" src="//i.imgur.com/YqazRs0.gif" style="max-width: 100%; min-height: 586px;" original-title="">

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.
Small bugs here and there...
1. I am on Xcode 7.2 (Swift 2.2.x) so some syntax confusion with NSNotification.
2. Typing non numeric characters.
3. Keeping the UI updated with every computation in background
        (Pickerview when selecting a segment, Segmented Control on random tip).
4. Trying to register the app for notification of close/open in order to check NSDates
5. Passing data in segue and back.

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
