#!/usr/bin/env bash

# Set color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Test command-line tools installations via apt, brew, and other methods
echo -e "${CYAN}Testing command-line tool installations...${NC}"
if command -v fd &> /dev/null; then echo -e "${GREEN}fd-find installed${NC}"; else echo -e "${RED}fd-find NOT installed${NC}"; exit 1; fi
if command -v fasd &> /dev/null; then echo -e "${GREEN}fasd installed${NC}"; else echo -e "${RED}fasd NOT installed${NC}"; exit 1; fi
if command -v pipx &> /dev/null; then echo -e "${GREEN}pipx installed${NC}"; else echo -e "${RED}pipx NOT installed${NC}"; exit 1; fi

# Test Homebrew installations
echo -e "${CYAN}Testing Homebrew installations...${NC}"
if brew list tldr &> /dev/null; then echo -e "${GREEN}tldr installed via brew${NC}"; else echo -e "${RED}tldr NOT installed via brew${NC}"; exit 1; fi
if brew list gh &> /dev/null; then echo -e "${GREEN}gh installed via brew${NC}"; else echo -e "${RED}gh NOT installed via brew${NC}"; exit 1; fi

# Alternatively, check if 'gh' command is available in the system
if command -v gh &> /dev/null; then echo -e "${GREEN}gh command available${NC}"; else echo -e "${RED}gh command NOT available${NC}"; exit 1; fi

# Test additional shell-based installations (Homebrew, Miniconda, Conda, Oh My Bash)
echo -e "${CYAN}Testing additional shell-based installations...${NC}"
if command -v brew &> /dev/null; then echo -e "${GREEN}Homebrew installed${NC}"; else echo -e "${RED}Homebrew NOT installed${NC}"; exit 1; fi
if [ -d "$HOME/miniconda3" ]; then echo -e "${GREEN}Miniconda installed${NC}"; else echo -e "${RED}Miniconda NOT installed${NC}"; exit 1; fi
if command -v conda &> /dev/null; then echo -e "${GREEN}Conda installed and available${NC}"; else echo -e "${RED}Conda NOT installed or not in PATH${NC}"; exit 1; fi
if [ -d "$HOME/.oh-my-bash" ]; then echo -e "${GREEN}Oh My Bash installed${NC}"; else echo -e "${RED}Oh My Bash NOT installed${NC}"; exit 1; fi

# Test pipx installations using the requirements file
echo -e "${CYAN}Testing pipx installations...${NC}"
pipx_requirements="requirements-pipx.txt"
while IFS= read -r package; do
    [[ "$package" =~ ^#.*$ ]] && continue
    [ -z "$package" ] && continue
    package_name=$(echo "$package" | cut -d'=' -f1)
    if pipx list | grep "$package_name" &> /dev/null; then echo -e "${GREEN}$package_name installed via pipx${NC}"; else echo -e "${RED}$package_name NOT installed via pipx${NC}"; exit 1; fi
done < "$pipx_requirements"

# Verify dotfiles symlinks to confirm they are correctly linked
echo -e "${CYAN}Verifying dotfiles symlinks...${NC}"
if [ -L "$HOME/.vimrc" ]; then echo -e "${GREEN}.vimrc linked${NC}"; else echo -e "${RED}.vimrc NOT linked${NC}"; exit 1; fi
if [ -L "$HOME/.bashrc" ]; then echo -e "${GREEN}.bashrc linked${NC}"; else echo -e "${RED}.bashrc NOT linked${NC}"; exit 1; fi
if [ -L "$HOME/.aliases" ]; then echo -e "${GREEN}.aliases linked${NC}"; else echo -e "${RED}.aliases NOT linked${NC}"; exit 1; fi

# Test contents of dotfiles for expected configurations
echo -e "${CYAN}Testing dotfiles contents...${NC}"

# Test ~/.aliases for correct alias definitions
echo -e "${CYAN}Testing ~/.aliases...${NC}"
if grep -q "alias update='sudo apt update && sudo apt upgrade -y'" ~/.aliases; then echo -e "${GREEN}Alias update found${NC}"; else echo -e "${RED}Alias update NOT found${NC}"; exit 1; fi
if grep -q "alias cls='clear && ls'" ~/.aliases; then echo -e "${GREEN}Alias cls found${NC}"; else echo -e "${RED}Alias cls NOT found${NC}"; exit 1; fi
if grep -q "alias v='f -e vim'" ~/.aliases; then echo -e "${GREEN}Alias v found${NC}"; else echo -e "${RED}Alias v NOT found${NC}"; exit 1; fi


# Test ~/.vimrc for correct Vim settings
echo -e "${CYAN}Testing ~/.vimrc...${NC}"
if grep -q "syntax on" ~/.vimrc; then echo -e "${GREEN}Syntax highlighting enabled${NC}"; else echo -e "${RED}Syntax highlighting NOT enabled${NC}"; exit 1; fi
if grep -q "set number" ~/.vimrc; then echo -e "${GREEN}Line numbers enabled${NC}"; else echo -e "${RED}Line numbers NOT enabled${NC}"; exit 1; fi

# Test ~/.bashrc for sourcing aliases and Oh My Bash initialization
echo -e "${CYAN}Testing ~/.bashrc...${NC}"
if grep -q ". ~/.aliases" ~/.bashrc; then echo -e "${GREEN}Aliases sourced in bashrc${NC}"; else echo -e "${RED}Aliases NOT sourced in bashrc${NC}"; exit 1; fi
if grep -q "oh-my-bash.sh" ~/.bashrc; then echo -e "${GREEN}Oh My Bash initialized in bashrc${NC}"; else echo -e "${RED}Oh My Bash NOT initialized in bashrc${NC}"; exit 1; fi

