<p align="center"><img src="https://raw.githubusercontent.com/cecilusmax33/cecilusmax33/main/assets/logos/exebashagent-logo.png" alt="ExeBashAgent-Console-Framework-v1.0.0 logo" width="220"></p>

# ExeBashAgent$ Console Framework

A full interactive bash console with agent support and custom branding — v1.0.0.

ExeBashAgent wraps a normal bash shell in a branded console (`EBA_$` prompt, ASCII banner) and adds a loadable agent system: drop agent modules into `./agents/`, load one, and talk to it in plain language for desktop window control.

## Features

- **Custom branded console** — ASCII art banner, color-coded output, current agent + version shown at startup
- **Custom prompts** — `EBA_$` in shell mode, `EBA_[agent_name]>` in agent mode
- **Full bash support** — anything the console doesn't recognize is passed straight through to bash
- **Agent modules** — loadable `.sh` modules from `./agents/` (`load <name>`, `sudo run--local`, `sudo kill--shell`)
- **Natural-language window control** — the agent pattern-matches plain requests: open/close/minimize/maximize/list/switch/move/resize windows, take a screenshot (via `wmctrl` / `xdotool` / `gnome-screenshot`)
- **Upgrade system** — shell and agent upgrades from `./upgrades/` (`shell_<version>.sh`, `agent_<version>.sh`)
- **Command history** — logged to `~/.eba_history`; optional config at `~/.eba.conf`

## Requirements

- bash (Linux desktop)
- Optional, for window control: `wmctrl`, `xdotool`
- Optional, for screenshots: `gnome-screenshot` or `scrot`

The console warns at startup if the optional tools are missing; those features are simply limited.

## Usage

```bash
chmod +x ExeBashAgent.sh
./ExeBashAgent.sh
```

The banner appears and the console is ready. Type `help` for commands.

## Console commands

| Command | Action |
| --- | --- |
| `help` | Show help |
| `agents` | List available agent modules |
| `upgrades` | List available upgrades |
| `load <name>` | Load an agent module |
| `sudo run--local` | Start the loaded agent |
| `sudo kill--shell` | Clear the agent and its history |
| `sudo upgrade--shell <version>` | Upgrade the shell |
| `sudo upgrade--agent <version>` | Upgrade the current agent |
| `history` | Show command history |
| `clear` | Redraw the banner |
| `exit` | Exit the console |

In agent mode, try: “Open browser”, “Close window”, “Minimize all windows”, “List windows”, “Take screenshot”.

## Fixes applied to the original export

The original export wouldn't start — two defects, both fixed in this copy (verified with `bash -n` and a smoke run):

1. A block of feature documentation text was pasted into `start_agent()` in the middle of the history line. The prose was removed from the code (it lives in this README's feature list instead) and the history line closed properly.
2. The ASCII banner contains backtick characters inside double-quoted `echo` strings, which bash treats as command substitution. The backticks on the two banner lines are now escaped (`\``) so they print literally — the banner looks identical.

## Safety note

This is a shell: unrecognized input is executed as a bash command, and agent/upgrade modules are `source`d — only load modules and upgrades you trust, same as running any script.
