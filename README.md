# Vote

This is a convenience app that aims to simplify the voting phase of the board game **Avalon**.

## How to Use

1. `Setup Phase`. Select the number of players via `+` and `-` and press `START`;
2. `Voting Phase`. Pass the phone sequentially to each player, allowing them to vote for either `ACCEPT` or `DECLINE`. Tap `UNDO` to retract the last vote;
3. `Verdict Phase`. After all the players voted, the verdict appears. The upper text would be either **green** or **red** depending on the prevailing vote. Tap `RESTART` to begin from the step `1`;

## Features

- The device vibrates on `ACCEPT`, `DECLINE` and `UNDO` buttons to indicate for others that the player performed an action and reduce the chance of falsification.
- The options - `ACCEPT` and `DECLINE` have a `50%` chance to swap locations with each other after each vote. This is aimed to reduce the chance of spying how each player votes by determining the side of the screen they tap. Still the `ACCEPT` is always **green** and `DECLINE` is always **red**.
- The verdict shows the number of prevailing options (either `ACCEPT` or `DECLINE`) as a big upper text of color **green** or **red** respectively. Below, the number of opposite votes is displayed as a smaller gray text.
- The number of players on `Setup Phase` after tapping `RESTART` starts from the previously selected number.
