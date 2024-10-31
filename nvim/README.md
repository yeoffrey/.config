# 💤 YeoffVim Configuration

This is my NeoVim configuration, based on the starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the LazyVim [documentation](https://lazyvim.github.io/installation) to make modifications. Below is all the changes I've made.

## Notifications

File: `lua/plugins/ui.lua`

All notifications have been shortened to 3 seconds.

## Theme

File: `lua/plugins/colors.lua`

The colour scheme is set to [Catppuccin](https://github.com/catppuccin/nvim) and set to the `Mocha` flavour.

## Terminal

File: `lua/config/keymaps.lua`

The floating terminal, accessed by `<leader>ft` is a rounded border instead of the default `none`

## Extras

File: `lua/config/lazy.lua`

See the [LazyVim Extras](https://www.lazyvim.org/extras). You can set these using the command `:LazyExtras` for an easy way to install these, but I recommend instead declaratively setting these in `lua/config/lazy.lua` for easy reproducibility. You can find the code easily accessible on each extra page. For example, see the [Rust Extra](https://www.lazyvim.org/extras/lang/rust).
