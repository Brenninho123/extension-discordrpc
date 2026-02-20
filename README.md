# Extension Discord RPC

A simple Discord Rich Presence extension for projects that want to integrate custom status, details, and images into Discord.

## 📌 About

**Extension Discord RPC** allows you to connect your application to Discord and display custom Rich Presence information such as:

- Game name
- Custom details
- State text
- Large and small images
- Timestamps
- Buttons with links

This extension is lightweight and easy to integrate into your project.

---

## 🚀 Features

- Easy Discord RPC integration
- Customizable presence (details, state, images)
- Support for timestamps
- Buttons with external links
- Lightweight and simple implementation

---

## 📦 Installation

1. Clone the repository:

```bash
git clone https://github.com/Brenninho123/extension-discordrpc.git
```

2. Add the extension files to your project.
3. Make sure Discord is running.
4. Configure your **Application ID** from the [Discord Developer Portal](https://discord.com/developers/applications).

---

## ⚙️ Configuration

Replace the `CLIENT_ID` in the code with your own Discord Application ID:

```js
const CLIENT_ID = "YOUR_DISCORD_APPLICATION_ID";
```

You can customize:

- `details`
- `state`
- `largeImageKey`
- `smallImageKey`
- `startTimestamp`
- `buttons`

---

## 🧪 Example

```js
rpc.setActivity({
  details: "Playing My Game",
  state: "In Main Menu",
  startTimestamp: Date.now(),
  largeImageKey: "logo",
  largeImageText: "My Cool Game",
  buttons: [
    { label: "Download", url: "https://example.com" }
  ]
});
```

---

## 📜 License

This project is licensed under the Apache 2.0 License.

---

## 💡 Credits

Made by **Brenninho123**

If you like this project, consider giving it a ⭐ on GitHub!