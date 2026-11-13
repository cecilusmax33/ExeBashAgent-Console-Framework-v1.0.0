#!/bin/bash

# ExeBashAgent$ Console Framework
# Full bash shell with AI agent support and custom branding

# Configuration
CONFIG_FILE="$HOME/.eba.conf"
HISTORY_FILE="$HOME/.eba_history"
MODULE_DIR="./agents"
UPGRADE_DIR="./upgrades"
CURRENT_AGENT=""
AGENT_HISTORY=""
SHELL_VERSION="1.0.0"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Print ExeBashAgent$ ASCII art banner
print_banner() {
    clear
    echo -e "${CYAN}  ______  ___________  ______  __    __   ______   ______  _____  ___   ${NC}"
    echo -e "${CYAN} /      ||           |/      ||  |  |  | /      | /      ||     |/   \  ${NC}"
    echo -e "${CYAN}|  ,----'\`---|  |----|  ,----'|  |__|  ||  ,----'|  ,----'|   __|\_   \ ${NC}"
    echo -e "${CYAN}|  |         |  |    |  |     |   __   ||  |     |  |     |  |      |  | ${NC}"
    echo -e "${CYAN}|  \`----.    |  |    |  \`----.|  |  |  ||  \`----.|  \`----.|  |      |  | ${NC}"
    echo -e "${CYAN} \______|    |__|     \______||__|  |__| \______| \______||__|      |__| ${NC}"
    echo -e "${YELLOW} _______  _______  _______  _______  _______  _______  _______  _______ ${NC}"
    echo -e "${YELLOW}|   _   ||   _   ||   _   ||   _   ||   _   ||   _   ||   _   ||   _   |${NC}"
    echo -e "${YELLOW}|  |_|  ||  |_|  ||  |_|  ||  |_|  ||  |_|  ||  |_|  ||  |_|  ||  |_|  |${NC}"
    echo -e "${YELLOW}|       ||       ||       ||       ||       ||       ||       ||       |${NC}"
    echo -e "${YELLOW}|       ||       ||       ||       ||       ||       ||       ||       |${NC}"
    echo -e "${YELLOW}|   _   ||   _   ||   _   ||   _   ||   _   ||   _   ||   _   ||   _   |${NC}"
    echo -e "${YELLOW}|__| |__||__| |__||__| |__||__| |__||__| |__||__| |__||__| |__||__| |__|${NC}"
    echo ""
    echo -e "${GREEN}              ExeBashAgent$ Console Framework v$SHELL_VERSION${NC}"
    echo -e "${GREEN}              ===============================${NC}"
    echo -e "${YELLOW}Current agent:  ${CURRENT_AGENT: -None}${NC}"
    echo ""
}

# Initialize framework
init_framework() {
    mkdir -p "$MODULE_DIR" "$UPGRADE_DIR"
    
    # Load configuration if exists
    if [[ -f "$CONFIG_FILE" ]]; then
        source "$CONFIG_FILE"
    fi
    
    # Create history file if it doesn't exist
    touch "$HISTORY_FILE"
}

# Check system compatibility
check_system() {
    if ! command -v wmctrl &> /dev/null; then
        echo -e "${YELLOW}Warning:  wmctrl not found. Window control features will be limited.${NC}"
    fi
    
    if ! command -v xdotool &> /dev/null; then
        echo -e "${YELLOW}Warning:  xdotool not found. Advanced window control will be limited.${NC}"
    fi
}

# Load agent module
load_agent() {
    local agent_name="$1"
    local agent_path="$MODULE_DIR/${agent_name}.sh"
    
    if [[ -f "$agent_path" ]]; then
        source "$agent_path"
        CURRENT_AGENT="$agent_name"
        AGENT_HISTORY=""
        echo -e "${GREEN}Loaded agent:  $agent_name${NC}"
        echo "Type 'sudo run--local' to start the agent"
    else
        echo -e "${RED}Error:  Agent '$agent_name' not found${NC}"
    fi
}

# Process agent input with natural language processing
process_agent_input() {
    local input="$1"
    echo "Processing:  $input"
    
    # Natural language processing for window control
    case "$input" in
        *"open"*"browser"*|*"launch"*"browser"*)
            echo "Opening web browser..."
            if command -v x-www-browser &> /dev/null; then
                x-www-browser &
            elif command -v firefox &> /dev/null; then
                firefox &
            elif command -v google-chrome &> /dev/null; then
                google-chrome &
            else
                echo "No browser found"
            fi
            ;;
            
        *"close"*"window"*|*"close"*"application"*)
            echo "Closing active window..."
            if command -v xdotool &> /dev/null; then
                xdotool key alt+F4
            else
                echo "xdotool required for this action"
            fi
            ;;
            
        *"minimize"*"window"*|*"minimize"*"all"*)
            echo "Minimizing windows..."
            if command -v wmctrl &> /dev/null; then
                wmctrl -k on
            else
                echo "wmctrl required for this action"
            fi
            ;;
            
        *"maximize"*"window"*)
            echo "Maximizing active window..."
            if command -v xdotool &> /dev/null; then
                xdotool key alt+F10
            else
                echo "xdotool required for this action"
            fi
            ;;
            
        *"list"*"windows"*|*"show"*"windows"*)
            echo "Listing open windows: "
            if command -v wmctrl &> /dev/null; then
                wmctrl -l
            else
                echo "wmctrl required for this action"
            fi
            ;;
            
        *"switch"*"window"*|*"next"*"window"*)
            echo "Switching to next window..."
            if command -v xdotool &> /dev/null; then
                xdotool key alt+Tab
            else
                echo "xdotool required for this action"
            fi
            ;;
            
        *"move"*"window"*)
            echo "Moving window (requires coordinates)..."
            if command -v wmctrl &> /dev/null; then
                local win_id=$(xdotool getactivewindow 2>/dev/null)
                if [[ -n "$win_id" ]]; then
                    wmctrl -i -r $win_id -e 0, 100, 100, -1, -1
                else
                    echo "Could not get active window"
                fi
            else
                echo "wmctrl/xdotool required for this action"
            fi
            ;;
            
        *"resize"*"window"*)
            echo "Resizing window (requires dimensions)..."
            if command -v wmctrl &> /dev/null; then
                local win_id=$(xdotool getactivewindow 2>/dev/null)
                if [[ -n "$win_id" ]]; then
                    wmctrl -i -r $win_id -e 0, -1, -1, 800, 600
                else
                    echo "Could not get active window"
                fi
            else
                echo "wmctrl/xdotool required for this action"
            fi
            ;;
            
        *"screenshot"*|*"capture"*"screen"*)
            echo "Taking screenshot..."
            if command -v gnome-screenshot &> /dev/null; then
                gnome-screenshot &
            elif command -v scrot &> /dev/null; then
                scrot &
            else
                echo "Screenshot tool not found"
            fi
            ;;
            
        *)
            # Default agent response
            echo "I understand you want to:  $input"
            echo "Supported actions: "
            echo "  - Open browser"
            echo "  - Close window"
            echo "  - Minimize windows"
            echo "  - Maximize window"
            echo "  - List windows"
            echo "  - Switch window"
            echo "  - Move window"
            echo "  - Resize window"
            echo "  - Take screenshot"
            ;;
    esac
}

# Show available agents
show_agents() {
    echo "Available agents: "
    if [[ -d "$MODULE_DIR" && -n "$(ls -A "$MODULE_DIR")" ]]; then
        for agent in "$MODULE_DIR"/*.sh; do
            if [[ -f "$agent" ]]; then
                basename "$agent" .sh
            fi
        done
    else
        echo "No agents found"
    fi
}

# Show available upgrades
show_upgrades() {
    echo "Available upgrades: "
    echo "Shell upgrades: "
    if [[ -d "$UPGRADE_DIR" && -n "$(ls -A "$UPGRADE_DIR"/shell_*.sh 2>/dev/null)" ]]; then
        for upgrade in "$UPGRADE_DIR"/shell_*.sh; do
            if [[ -f "$upgrade" ]]; then
                basename "$upgrade" .sh | sed 's/shell_//'
            fi
        done
    else
        echo "  No shell upgrades available"
    fi
    
    echo "Agent upgrades: "
    if [[ -d "$UPGRADE_DIR" && -n "$(ls -A "$UPGRADE_DIR"/agent_*.sh 2>/dev/null)" ]]; then
        for upgrade in "$UPGRADE_DIR"/agent_*.sh; do
            if [[ -f "$upgrade" ]]; then
                basename "$upgrade" .sh | sed 's/agent_//'
            fi
        done
    else
        echo "  No agent upgrades available"
    fi
}

# Upgrade shell
upgrade_shell() {
    local version="$1"
    local upgrade_path="$UPGRADE_DIR/shell_${version}.sh"
    
    if [[ -f "$upgrade_path" ]]; then
        echo -e "${YELLOW}Upgrading shell to version $version...${NC}"
        source "$upgrade_path"
        SHELL_VERSION="$version"
        print_banner
        echo -e "${GREEN}Shell upgraded successfully to version $version${NC}"
    else
        echo -e "${RED}Error:  Shell upgrade '$version' not found${NC}"
        show_upgrades
    fi
}

# Upgrade agent
upgrade_agent() {
    local version="$1"
    local upgrade_path="$UPGRADE_DIR/agent_${version}.sh"
    
    if [[ -z "$CURRENT_AGENT" ]]; then
        echo -e "${RED}Error:  No agent loaded. Load an agent first${NC}"
        return
    fi
    
    if [[ -f "$upgrade_path" ]]; then
        echo -e "${YELLOW}Upgrading agent to version $version...${NC}"
        source "$upgrade_path"
        echo -e "${GREEN}Agent upgraded successfully to version $version${NC}"
    else
        echo -e "${RED}Error:  Agent upgrade '$version' not found${NC}"
        show_upgrades
    fi
}

# Show help information
show_help() {
    echo "ExeBashAgent$ Console Commands: "
    echo "  help                    - Show this help"
    echo "  agents                  - List available agents"
    echo "  upgrades                - List available upgrades"
    echo "  load             - Load an agent module"
    echo "  sudo run--local         - Start the loaded agent"
    echo "  sudo kill--shell        - Clear agent and its history"
    echo "  sudo upgrade--shell  - Upgrade shell to version"
    echo "  sudo upgrade--agent  - Upgrade current agent"
    echo "  history                 - Show command history"
    echo "  clear                   - Clear the screen"
    echo "  exit                    - Exit the console"
    echo ""
    echo "All standard bash commands are also supported"
    echo "Agent understands natural language for window control"
}

# Show command history
show_history() {
    if [[ -f "$HISTORY_FILE" ]]; then
        cat "$HISTORY_FILE"
    else
        echo "No history available"
    fi
}

# Clear agent and its history
clear_agent() {
    CURRENT_AGENT=""
    AGENT_HISTORY=""
    print_banner
    echo -e "${GREEN}Agent cleared successfully${NC}"
}

# Start agent session
start_agent() {
    if [[ -z "$CURRENT_AGENT" ]]; then
        echo -e "${RED}Error:  No agent loaded. Use 'load ' first${NC}"
        return
    fi
    
    echo -e "${GREEN}Starting agent:  $CURRENT_AGENT${NC}"
    echo "Type 'sudo kill--shell' to exit agent mode"
    echo "Natural language examples: "
    echo "  'Open browser',  'Close window',  'List windows'"
    echo "  'Minimize all windows',  'Take screenshot'"
    
    # Agent interaction loop
    while true; do
        echo -ne "${PURPLE}EBA_[$CURRENT_AGENT]> ${NC}"
        read -r agent_input
        
        # Check for exit command
        if [[ "$agent_input" == "sudo kill--shell" ]]; then
            clear_agent
            break
        fi
        
        # Save to agent history
        AGENT_HISTORY+="$(date '+%H: %M: %S') > $agent_input\n"
        
        # Process with agent
        process_agent_input "$agent_input"
    done
}

# Main command processor
process_command() {
    local input="$1"
    
    # Save to history
    echo "$(date '+%Y-%m-%d %H: %M: %S') $input" >> "$HISTORY_FILE"
    
    # Parse command
    local cmd=$(echo "$input" | awk '{print $1}')
    local args=$(echo "$input" | cut -d' ' -f2-)
    
    case "$input" in
        help)
            show_help
            ;;
        agents)
            show_agents
            ;;
        upgrades)
            show_upgrades
            ;;
        "load "*)
            if [[ -n "$args" ]]; then
                load_agent "$args"
            else
                echo "Usage:  load "
            fi
            ;;
        "sudo run--local")
            start_agent
            ;;
        "sudo kill--shell")
            clear_agent
            ;;
        "sudo upgrade--shell "*)
            if [[ -n "$args" ]]; then
                upgrade_shell "$args"
            else
                echo "Usage:  sudo upgrade--shell "
            fi
            ;;
        "sudo upgrade--agent "*)
            if [[ -n "$args" ]]; then
                upgrade_agent "$args"
            else
                echo "Usage:  sudo upgrade--agent "
            fi
            ;;
        history)
            show_history
            ;;
        clear)
            print_banner
            ;;
        exit)
            echo "Goodbye!"
            exit 0
            ;;
        "")
            # Empty command,  do nothing
            ;;
        *)
            # Execute as regular bash command
            eval "$input"
            ;;
    esac
}

# Main loop
main() {
    init_framework
    check_system
    print_banner
    
    # Show initial prompt
    echo -e "${YELLOW}ExeBashAgent$ ready. Type 'help' for commands${NC}"
    
    while true; do
        # Show prompt with agent status
        if [[ -n "$CURRENT_AGENT" ]]; then
            echo -ne "${YELLOW}EBA_[$CURRENT_AGENT]> ${NC}"
        else
            echo -ne "${YELLOW}EBA_$ ${NC}"
        fi
        
        # Read input
        read -r input
        
        # Process command
        process_command "$input"
    done
}

# Start the framework
main
