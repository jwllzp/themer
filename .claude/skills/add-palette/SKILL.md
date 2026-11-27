---
name: add-palette
description: Add a new base24 color palette to themer from a prompt — a mood/description, a list of colors, an image, or an existing theme (Neovim/VS Code/Xcode/iTerm/base16 file or URL). Use when the user asks to add, port, create, or tweak a themer palette.
---

# Add a themer palette

Produce one file, `lua/themer/palettes/<name>.lua`, in base24 format. Never touch highlight files: they map slots to groups for *every* palette, so a palette only has to put the right kind of color in each slot.

## 1. Gather the source colors
- **Existing theme** (file, URL, or a well-known name): extract its real colors. Prefer the source file over memory. Xcode `.xccolortheme` stores `r g b a` floats: hex = round(v × 255). VS Code: `colors` + `tokenColors`. iTerm/terminal: ANSI 0–15. base16/base24 YAML: copy slots directly.
- **Description only** ("calm forest", "neon synthwave"): design a palette. Pick background and foreground first, then 8 accents with consistent lightness and distinct hues.
- Pick `name` as lowercase snake_case. If the user didn't give one, derive it from the source and say which name you chose.

## 2. Map to base24 slots
| slots | role | rules |
|---|---|---|
| base00 | background | |
| base01 | lighter bg (cursor line, status bars) | close to base00 |
| base02 | selection / surface | clearly visible on base00 |
| base03 | comments, line numbers | readable on base00 but muted |
| base04 | dark foreground (subtle text, doc keywords) | |
| base05 | default foreground | main text; ≥ 7:1 contrast on base00 |
| base06 | light foreground | |
| base07 | brightest foreground | |
| base08 red · base09 orange · base0A yellow · base0B green · base0C cyan · base0D blue · base0E magenta · base0F brown | accents | |
| base10, base11 | darker backgrounds (floats, sidebars) | darker than base00, base11 darkest (lighter for light themes) |
| base12 red · base13 yellow · base14 green · base15 cyan · base16 blue · base17 magenta | bright accents | brighter/more saturated companion of the matching normal accent |

Rules:
- 00→07 must form a monotonic ramp (dark→light for `variant = "dark"`, reversed for `"light"`).
- Every accent and base03+ must be readable on base00, base01 and base10.
- Keep hue semantics: put a source's "keyword" color in base0E only if it is magenta-ish. When the source's roles disagree with slot hues, keep the **hue** (the highlight variants choose roles).
- Fill slots the source lacks by shifting a neighbour's lightness, not by inventing a new hue.
- Use `#RRGGBB` uppercase.

## 3. Write the file
Match `lua/themer/palettes/xcode_dark.lua` exactly in shape:
```lua
-- <Name>: <one-line origin/description>.
return {
	name = "<name>",            -- must equal the filename
	author = "<source author or 'themer'>",
	variant = "dark",           -- or "light"
	base00 = "#RRGGBB", -- <what this color is used for in the source, if known>
	-- … base01 … base17, all 24 slots
}
```

## 4. Validate
Run from the repo root and fix anything that fails:
```sh
nvim --headless -u NONE -i NONE --cmd "set rtp^=." -l tests/run.lua
```
The suite checks all 24 slots, and loads the palette under every highlight variant.

## 5. Report
Reply with a short table: slot, hex, where it came from (source key or "derived from X"), and the `setup({ palette_variant = "<name>" })` line to try it.

## Worked example: xcode_dark (from an Xcode theme)
Source floats → hex, then by hue: `xcode.syntax.keyword` 0.988 0.374 0.638 → `#FC5FA3` (magenta) → base0E; `string` `#FC6A5D` (red) → base08; `number` `#D0BF69` → base0A; `preprocessor` `#FD8F3F` → base09; `identifier.function` `#67B7A4` (teal-green) → base0B; `declaration.other` `#41A1C0` → base0C; `url` `#5482FF` → base0D; `attribute` `#BF8555` → base0F; `identifier.type` `#9EF1DD` → base15; `declaration.type` `#5DD8FF` → base16; `identifier.*.system` `#D0A8FF` → base17; error/warning markers `#F74A4A`/`#EFB759` → base12/base13; background `#1F1F24` → base00, current line → base01, selection → base02, comment → base03; base10/base11 derived by darkening base00.
