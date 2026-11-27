# themer

The last theme plugin you should need.

Neovim themes all ship the same three things: a palette, a mapping from colors to highlight groups, and a config. themer keeps them apart, so you can keep the highlight structure you're used to and swap in any palette.

- **Palettes** are [base24](https://github.com/tinted-theming/base24) (`lua/themer/palettes/*.lua`).
- **Highlight variants** map base24 slots to highlight groups (`lua/themer/highlights/<variant>/`).
- **Compiled cache**: highlights are compiled to LuaJIT bytecode under `stdpath("cache")/themer`, so after the first start a load is mostly one `dofile`.

## Install

```lua
-- lazy.nvim
{
	"jwllzp/themer",
	lazy = false,
	priority = 1000,
	config = function()
		require("themer").setup({ highlights_variant = "semantic" })
		vim.cmd.colorscheme("themer")
	end,
}
```

```lua
-- vim.pack (built in, Neovim 0.12+)
vim.pack.add({ "https://github.com/jwllzp/themer" })

require("themer").setup({ highlights_variant = "semantic" })
vim.cmd.colorscheme("themer")
```

Call `setup()` before `colorscheme`; options set afterwards are not applied until the scheme is loaded again.

## Configuration

These are the defaults:

```lua
require("themer").setup({
	transparent = false,
	palette_variant = "xcode_dark",
	highlights_variant = "default", -- "minimal" | "default" | "semantic"
	styles = { -- any nvim_set_hl attributes
		comments = {},
		keywords = { bold = true },
		functions = {},
		variables = {},
		strings = {},
	},
	integrations = {
		telescope = true,
		gitsigns = true,
		rainbow_delimiters = true,
		oil = true,
	},
})
```

You can't add custom highlights. The variants are deliberately opinionated.

### Highlight variants

| variant | style |
|---|---|
| `minimal` | Like Neovim's built-in default scheme: mostly foreground, with color for strings, functions and specials only. |
| `default` | Catppuccin-style coverage and accent choices. |
| `semantic` | Xcode semantics: definitions vs. uses, project vs. system (stdlib) symbols, bold keywords. Best with an LSP that sends semantic tokens. |

### Palettes

| palette | origin |
|---|---|
| `xcode_dark` | Translated from an Xcode dark theme |

## Commands

- `:ThemerCompile` rebuilds the cache and reapplies the scheme.
- `:ThemerClearCache` deletes the cache.

The cache is rebuilt on its own whenever your config or any file in `lua/themer/` changes.

## Adding a palette

Create `lua/themer/palettes/<name>.lua` with `name`, `variant` (`"dark"`/`"light"`) and the 24 slots `base00`–`base17`; `xcode_dark.lua` is a working example. With Claude Code, the bundled `add-palette` skill (`.claude/skills/add-palette`) does this from a prompt, for example "add a palette from this VS Code theme" or "make a muted forest palette".

## Development

```sh
nvim --headless -u NONE -i NONE --cmd "set rtp^=." -l tests/run.lua
```
