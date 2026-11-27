# Themer
The last theme plugin you should need.

# Context
Nvim themes are a common plugin but essentially they all contain the same elements:
- A color palette.
- A mapping from colors to highlight groups.
- A config that handles transparency, formatting, overrides, and variants.

I personally hop around themes due to the color palette and find it hard to stay with a new one because I'm already used to the specific structure of the highlight groups of another one. For me the later one has an optimal configuration and I'd wish I could just plug and play different palettes into it.

# Idea
This plugin should have the usual config for any theme
```lua
require("themer").setup({
	transparent = true,
  -- specify color palette to use.
	palette_variant = "neon",
  -- which mapping from colors to highilight groups to use. Some can be simple and minimal, others could be all over the place. All palettes will be base24.
  highlights_variant = "",
	styles = {
    -- formatting styles usual text objects.
		comments = { italic = false, },
		keywords = { bold = true },
		functions = { bold = true, italic = false },
		variables = {},
		strings = { italic = false },
	},

	integrations = {
    -- enable disable highlight groups defined by extenral plugins all true 
    telescope = true
  },
```
No option to add custom highlights, these will be opinnionated and fixed in code.
Palettes.

## Requirements
- Palettes should be base24.
- For startup efficiency the colorschemes should be cached.
- Should be able to add new color palettes with a simple prompt, an agentic skill should translate the palette into base24.
- Use a simple file structure for each component:
```
src/
├── palettes/
│   ├── <variant_1>.lua
│   ├── <variant_2>.lua
│   ...
├── highlights/
│   ├── <variant_1>/
│   │   ├── semantic_tokens.lua
│   │   ├── editor.lua
│   │   ├── lsp.lua
│   │   ├── plugins/
│   │   ├── syntax.lua
│   │   └── treesitter.lua
│   ├── <variant_2>/
│   ...
├── config.lua -- default config
├── init.lua -- loads default config, applies and caches palette & highlights if new, loads cached highlights.
└── utils.lua -- any helper functions that'll make the init simpler and lean.
```
