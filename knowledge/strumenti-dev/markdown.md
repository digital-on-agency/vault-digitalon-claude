<!-- ultimo aggiornamento: 2026-03-21 -->

# Markdown

## Overview

**Markdown** is a lightweight markup language designed to format plain text using simple, human-readable syntax. It allows you to create rich text documents (headings, lists, links, images, and more) without complex editors.

Markdown is:
- **Simple** → easy to learn and read, even without rendering
- **Portable** → works across different platforms and tools
- **Compatible** → supported by GitHub, static site generators, Obsidian, and most documentation systems

Used for: documentation (README, wikis), note-taking, publishing (blogs, static websites), collaboration (GitHub).

## Configurazioni standard

### Basic Syntax

**Headings:** `#` to `######`

**Paragraphs:** blank line between blocks. Force line breaks with two spaces at end.

**Bold & Italic:** `*italic*`, `**bold**`, `***bold+italic***`

**Blockquotes:** `> text`

**Lists:** `-`, `*`, `+` for unordered; `1.` for ordered

**Links:** `[text](url)`

**Images:** `![alt](url)`

**Code:**
- Inline: `` `code` ``
- Blocks: triple backticks with optional language

### Extended Syntax

**Tables:**
```
| Column 1 | Column 2 |
|----------|----------|
| Value A  | Value B  |
```

**Task Lists:** `- [ ] task` / `- [x] done`

**Horizontal Rule:** `---`

**Escaping:** `\*not italic\*`

## Note e benchmark

- Keep raw text readable without rendering
- Use headings consistently (don't skip levels)
- Prefer semantic formatting
- Always specify language in code blocks
- Limit line length (70-100 chars) for better diffs
- Stay consistent across the team
- Use preview mode to verify formatting
