# reverb.nvim

reverb.nvim is a Neovim plugin that adds sound effects to specific autocmd events. With this plugin, you can enhance your Neovim experience by associating various sounds with different actions, providing an auditory dimension to your coding environment.

## Dependencies

Sound files are played with `paplay`. If you're on Arch Linux like me, you'll need `alsa-utils`. Otherwise, you can install `pulseaudio-utils` if you're on Ubuntu. Check your package manager if you're not sure.

## Installation

You can install reverb.nvim using your preferred plugin manager. Here's an example using [Lazy](https://github.com/folke/lazy.nvim):

```lua
" Lazy configuration
{
  "whleucka/reverb.nvim",
  event = "BufReadPre",
  opts = {
    sounds = {
      buf_read = nil,
      cursor_moved = nil,
      insert_enter = nil,
      insert_leave = nil,
      exit_pre = nil,
      buf_write = nil,
    },
  },
}
```

## Autocmd Events and Sounds

reverb.nvim is designed to play sounds during specific autocmd events. Here's a list of supported events along with the associated sound effects:

- **BufRead**: Triggered when a buffer is read. Sound: `buf_read`
- **CursorMovedI**: Triggered when the cursor moves in insert mode. Sound: `cursor_moved`
- **InsertEnter**: Triggered upon entering insert mode. Sound: `insert_enter`
- **InsertLeave**: Triggered upon leaving insert mode. Sound: `insert_leave`
- **ExitPre**: Triggered before exiting Neovim. Sound: `exit_pre`
- **BufWrite**: Triggered before writing a buffer to disk, if modified. Sound: `buf_write`

**NOTE**: Contributions are welcome. If you'd like to add something, please feel free to open a PR 😄

## Customization

By default, reverb.nvim does ship with any sounds. However, you can customize the opts to suit your preferences. To do so, configure the plugin's options in your Neovim configuration. Here's an example of customizing the sounds using the Lazy plugin:

```lua
{
  "whleucka/reverb.nvim",
  event = "BufReadPre",
  opts = {
    sounds = {
      buf_read = "~/path/to/custom/buf_read_sound.wav",
      cursor_moved = "~/path/to/custom/cursor_moved_sound.mp3",
      -- Add custom sound paths for other events here
    },
  },
}
```

## Acknowledgments

This plugin was inspired by the desire to add an audible aspect to the coding experience, providing an innovative way to engage with your text editor. Enjoy coding with a new sensory dimension using reverb.nvim!

## License

This project is licensed under the [MIT License](LICENSE).
