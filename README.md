# Social World

Social World is an open-source world template designed for creating social spaces within HELIX GAME. It aims to foster interaction and communication among players through a variety of integrated systems such as nametags, proximity chat, VOIP, and emotes.

## Features

- **Nametags**: Displays player names and microphone status, leveraging the Helix VOIP System.

- **Proximity Chat**: A chat system where messages are shown above a player's head in a chat bubble, visible to nearby players.
  - Press **T** to open chat.
  - Type **/t** followed by your message.

- **VOIP**: An enhanced voice chat system allowing players to mute or unmute others.
  - Press **T** to open chat.
  - Type **/m** followed by the player ID you wish to mute or unmute.
  - Configure the talk key in settings/keybinding.


**NOTE - We're on the process of reworking emotes system UI**
- **Emotes**: An emote wheel featuring a variety of emotes for player expression.

## Installation

1. Download the Social World package from this repository.
2. Extract the template into your server Packages folder and rename it to `social-world`.
3. Make sure to add this package as a game-mode to start on your server Config.toml file.
4. Start your server with social-world as a game-mode on your Config.toml file.
![image](https://github.com/helix-game/Social-World/assets/67294331/641e9df8-4fdb-4f37-a431-33625ac82c10)

## Usage

To utilize the features of Social World in your project:

- **Nametags**: Automatically applied to all players.
- **Proximity Chat**: Press **T** and use **/t** command for text messages.
- **VOIP**: Use **/m** command for muting functionality.
- **Emotes**: Access the emote wheel with a designated key (customizable in settings).

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

```markdown
MIT License

Copyright (c) 2024 Hypersonic Laboratories

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
