<!-- ultimo aggiornamento: 2026-03-21 -->

# Obsidian

## Overview

[Obsidian Documentation](https://help.obsidian.md/)

**Obsidian** is a knowledge management and note-taking application built on top of plain Markdown files. It enhances Markdown with features that transform a flat collection of notes into a connected, interactive knowledge base: linking, tagging, visualization, and customization.

## Setup

### Installation

1. Visit [https://obsidian.md](https://obsidian.md)
2. Download the installer for your OS
3. Run the installer, launch Obsidian
4. Select **Open folder as vault** and choose the target folder

### Mandatory Settings (Digital On Vault)

- **Appearance:** Light or Dark mode, font size 14-16px
- **Core plugins required:**
  - **Backlinks** → bidirectional navigation
  - **Graph View** → visual map of connections
  - **Templates** → structured note formats
- **File & link options:**
  - New note location: designated default folder
  - Internal link format: `[[Note Title]]`

### Recommended Community Plugins

#### Advanced Tables
Enhances Markdown table editing with auto-formatting, Excel-like navigation, formulas.
- `Tab` → next cell, `Shift+Tab` → previous, `Enter` → next row
- `Ctrl+Shift+D` → table controls sidebar

#### Table of Contents
Auto-generates TOC from headings.
- `Cmd+Shift+T` → full TOC
- `Cmd+T` → next heading level TOC

#### Text Snippets
Custom snippets that expand into text/templates.
- Recommended hotkey: `Shift+Tab`
- Supports placeholders: `$tb$` (tabstop), `$nl$` (newline), `$end$` (cursor)

**Defined snippets:** `metadata` (YAML template), `code`, `bcode`, `ccode`, `rarrow`, `rrarrow`, `ad`, `ad-def`, `h1`-`h5`, `txt`, `math`, `mmath`

## Configurazioni standard

### Vaults, Notes, and Folders

**Vaults:** root folder containing all notes, attachments, config. Each vault is isolated. Prefer **one main vault** unless there's strong reason for separation.

**Folders:** traditional tree structure. Use for broad categories. Avoid deep nesting. Rely on tags and links for cross-cutting themes.

**Notes:** every note is a `.md` file.
- **Atomic notes** → short, focused, one concept
- **Hub notes** → larger, summarize and link to atomic notes

### Key Features

**Internal Links:** `[[Note Title]]`
- Link to header: `[[Note Title#Header]]`
- Custom text: `[[Target|Display Text]]`

**Backlinks:** automatic bidirectional references. Enable discovering connections and navigating fluidly.

**Tags:** `#keyword` for transversal classification. Unlike links (specific connections), tags provide categories across the vault.

**Graph View:** visual network of connected notes. Useful for exploring relationships, identifying clusters, and finding isolated notes.

### Appearance & Customization

- Base color scheme (light/dark), accent color
- Themes (community marketplace)
- Font customization: interface, text, monospace
- CSS snippets for fine-tuning beyond themes
- Workspace layout: sidebars, tab groups, panes

### Core Plugins

Key built-in plugins: Backlinks, Graph View, Daily Notes, Templates, Page Preview, Command Palette, Sync & File Recovery.

### Community Plugins

1. Enable in Settings → Community Plugins
2. Browse marketplace, Install, Enable
3. Configure in Settings panel
4. Assign hotkeys for new commands

**Security:** install only from official marketplace, keep updated, limit number, review permissions.

## Workflow

### Collaboration Guidelines (Digital On Vault)

- **Folder structure:** folders for each macro-topic with index file inside
- **Naming:** clear, descriptive titles (e.g., `Google Analytics – Events`)
- **Images:** store in `Assets` folder, naming convention: `Topic-description.png`
- **Headers:** hierarchical numbering (1, 1.1, 1.1.1)
- **Internal Links:** connect related notes, create hub notes
- **Tags:** consistent, shared across team (`#todo`, `#meeting`, `#reference`)
- **Best practices:** avoid duplicates, keep notes atomic, regularly refactor hubs

## Errori comuni

- **Missing plugins:** check Settings → Community Plugins
- **Display problems:** reset appearance or toggle light/dark mode
- **Corrupted settings:** rename/delete `.obsidian` folder, restart
- **Workspace cluttered:** Settings → Core Plugins → Workspaces → reload saved workspace
- **Problematic plugins:** disable in Settings → Community Plugins → toggle off or Uninstall
- Git issues documented separately in Git & Version Control
