<!-- ultimo aggiornamento: 2026-03-21 -->

# Bash and Terminal

## Overview

Essential knowledge for **working efficiently with the terminal** — running quick commands, automating tasks, and building complex workflows.

### UNIX Terminal

The **UNIX terminal** is a text-based interface that lets you interact directly with the operating system. It works by interpreting input through a shell program (Bash, Zsh, or Fish), which parses commands, executes them, and displays output.

### Zsh

**Zsh** (Z Shell) extends Bash with advanced tab completion, spelling correction, better globbing, and rich customization. Integrates well with **Oh My Zsh** for themes, plugins, and aliases.

### Bash vs Zsh

Bash is the default on many Linux servers — stable, widely supported, ideal for scripts and cross-platform compatibility. Zsh is default on macOS — offers all Bash features plus advanced autocompletion and customization. Bash is simpler and more universal; Zsh is more powerful but not always installed by default on remote systems.

## Configurazioni standard

### Aliases and Snippets

**Aliases** replace long commands with short keywords. **Snippet functions** combine multiple commands with logic.

**Setup aliases** in `~/.bashrc` (Bash) or `~/.zshrc` (Zsh):
```bash
alias short_command='full command here'
```

Reload:
```bash
source ~/.bashrc   # for Bash
source ~/.zshrc    # for Zsh
```

**Snippet functions** in the same files:
```bash
my_function() {
    [...]
}
alias mf='my_function'
```

### Bash Functions

#### Syntax

Two valid ways:
```bash
# Parentheses syntax (most common)
my_function() {
    echo "Hello from my_function"
}

# function keyword syntax
function my_function {
    echo "Hello from my_function"
}
```

**Naming:** lowercase with underscores (`backup_files`, `deploy_app`). Avoid overriding built-in commands.

#### Arguments

- `$1` → First argument
- `$2` → Second argument
- `$@` → All arguments as a list
- `$#` → Number of arguments passed
- `$0` → Script/function name

```bash
greet_user() {
    echo "Hello, $1!"
}
greet_user "Alice"
```

Always **quote arguments** (`"$1"`, `"$@"`) to handle spaces and special characters.

#### Variables (Local vs Global)

By default, variables in functions are **global**. Use `local` to scope them:
```bash
my_function() {
    local temp="I exist only here"
    global_var="I persist after the function"
}
```

#### Returning Values

Bash functions can:
1. Return an **exit status** (0-255) with `return`
2. **Output data** with `echo`/`printf`, captured by caller

```bash
# Exit status
check_file() {
    [[ -f "$1" ]] && return 0 || return 1
}

# Output capture
get_date() {
    date "+%Y-%m-%d"
}
today=$(get_date)
```

#### Composition

Functions can call other functions and use pipelines:
```bash
greet_and_time() {
    say_hello "$1"
    echo "Current time: $(date "+%H:%M:%S")"
}
```

## Note e benchmark

**Best Practices for Functions:**
- Use clear, descriptive names
- Keep functions focused on a single responsibility
- Comment complex logic
- Use `local` for variables
- Quote arguments
- Check inputs and handle missing values
- Test before adding to config files
