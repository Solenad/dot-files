# Roe's Neovim Setup
My local **Neovim setup** powered by **Lazy.nvim**. 

This configuration focuses on:
* Fast startup
* Clean UI
* LSP support
* Git integration
* AI assistance
* Modern colorschemes

---

# Features

### Plugin Manager

* **Lazy.nvim** for fast and lazy-loaded plugin management.

### Language Server Protocol (LSP)

* Managed using **lsp-zero**
* Default LSP keymaps automatically attached to buffers.
* Primarily utilizes `Mason` for LSPs

### AI Coding Assistant

* **CodeCompanion** configured with OpenAI.
* Uses the `OPENAI_API_KEY` environment variable.

### Git Integration

* **LazyGit integration**
* Launch using:

```
<leader>lg
```

### File Explorer

* **nvim-tree** for project navigation.

### Notifications

* **nvim-notify** for modern UI notifications.

### Scrollbar

* **satellite.nvim** provides a visual scrollbar with:
* cursor position
* diagnostics
* git changes
* search matches
* marks

---

# UI / Appearance

### Colorschemes

Two themes are configured:

* **Catppuccin (Mocha)**
* **Kanagawa**

Kanagawa is currently the active theme.

### Icons

Uses **nvim-web-devicons** for file icons with custom overrides.

### Cursor

Cursor highlighting and cursorline are disabled for a cleaner editing experience.

### Indentation

```
expandtab = true
tabstop = 2
shiftwidth = 2
softtabstop = 2
```

---

# Plugins

Main plugins used:

* lazy.nvim
* lsp-zero
* nvim-tree
* catppuccin
* kanagawa
* nvim-notify
* satellite.nvim
* nvim-web-devicons
* lazygit.nvim
* codecompanion
* livepreview

---

# Installation

Clone the repository:

```
git clone https://github.com/YOUR_USERNAME/nvim-config ~/.config/nvim
```

Start Neovim:

```
nvim
```

Lazy.nvim will automatically install all plugins.

---

# Environment Variables

To enable AI features:

```
export OPENAI_API_KEY=your_api_key_here
```

or on Windows (PowerShell):

```
$env:OPENAI_API_KEY="your_api_key_here"
```

---

# Keybindings

| Key          | Action       |
| ------------ | ------------ |
| `<leader>lg` | Open LazyGit |

LSP keybindings are automatically applied by **lsp-zero**.

---

# Directory Structure

```
nvim/
├── init.lua
├── lazy_setup.lua
├── polish.lua
├── plugins-config/
│   └── nvim-tree.lua
```

---

# Requirements

* Neovim **0.9+**
* Git
* Node.js (for some LSP servers)
* LazyGit (optional but recommended)

---

# Screenshot

You may add screenshots of your Neovim setup here.

Example:

```
![Neovim Screenshot](images/screenshot.png)
```

---

# Customization

You can easily:

* add plugins in `lazy_setup.lua`
* modify theme settings in `init.lua`
* adjust UI elements or keymaps.

---

# License

MIT
