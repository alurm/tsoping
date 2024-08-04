# Send a link to a Telegram chat when Tsoding uploads 

## Building

To build with Nix, run `nix build`. `result/bin/tsoping` will contain the script.

Dependencies can be seen in the flake.nix file.

## Running

`tsoping run`

This program expects two files to be present in the current directory:

- `data/chat.id` -- the id of the chat where to send the link. The bot has to be added to this chat.

- `data/telegram.secret` -- the bot's secret token provided by BotFather.

The following command line may be helpful to discover the id of the chat to which the bot has been added:

`curl "https://api.telegram.org/bot$(cat secret)/getUpdates" | jq`

## Modes

The program has a couple of different modes, which may be helpful for debugging. They are indicated by the first argument to the program.

- `fetch`: fetches the feed, converts it to JSON and saves it to `data/videos.json`.

- `set-start-time`: sets `data/last.time` with the current system time. You may want to set the time manually.

- `set-chat-id`: saves the chat id given as an argument to `data/chat.id` (this is just an echo at the time of writing).

- `links`: does all of the above if needed, but also filters out only new videos and saves them to `links.txt`.

- `send-to-telegram`: sends one link to the Telegram chat and updates the time in `data/last.time`.

- Run: sends all not yet sent links since the recorded time to the Telegram chat.

## License

MIT.
