#!/bin/bash

# Advanced Payload Obfuscation Framework - Interactive Menu
# Colors for better UI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

clear
echo -e "${CYAN}🎯 Advanced Payload Obfuscation Framework${NC}"
echo -e "${CYAN}===========================================${NC}"
echo ""

# Function to show menu
show_menu() {
    echo -e "${YELLOW}Select an option:${NC}"
    echo -e "${GREEN}1)${NC} Process payload from file"
    echo -e "${GREEN}2)${NC} Enter payload directly"
    echo -e "${GREEN}3)${NC} View sample payloads"
    echo -e "${GREEN}4)${NC} Exit"
    echo ""
    echo -ne "${BLUE}Enter your choice [1-4]: ${NC}"
}

# Function to select obfuscation chain
select_chain() {
    echo ""
    echo -e "${YELLOW}Select obfuscation chain:${NC}"
    echo -e "${GREEN}1)${NC} Basic (unicode + base64)"
    echo -e "${GREEN}2)${NC} Stealth (unicode + base64 + xor + junk)"
    echo -e "${GREEN}3)${NC} Full (all layers + OS bypass)"
    echo ""
    echo -ne "${BLUE}Enter chain [1-3]: ${NC}"
    read chain_choice
    
    case $chain_choice in
        1) echo "basic" ;;
        2) echo "stealth" ;;
        3) echo "full" ;;
        *) echo "stealth" ;;
    esac
}

# Function to select target OS
select_target() {
    echo ""
    echo -e "${YELLOW}Select target OS:${NC}"
    echo -e "${GREEN}1)${NC} Windows"
    echo -e "${GREEN}2)${NC} Linux"
    echo -e "${GREEN}3)${NC} Both"
    echo ""
    echo -ne "${BLUE}Enter target [1-3]: ${NC}"
    read target_choice
    
    case $target_choice in
        1) echo "windows" ;;
        2) echo "linux" ;;
        3) echo "both" ;;
        *) echo "both" ;;
    esac
}

# Function to get number of variants
get_variants() {
    echo ""
    echo -ne "${BLUE}Number of variants to generate [1-10]: ${NC}"
    read variants
    if [[ ! $variants =~ ^[0-9]+$ ]] || [ $variants -lt 1 ] || [ $variants -gt 10 ]; then
        variants=3
    fi
    echo $variants
}

# Function to save encoded payload
save_encoded() {
    local payload="$1"
    echo ""
    echo -e "${YELLOW}💾 Save encoded payload?${NC}"
    echo -e "${GREEN}1)${NC} Yes, save to file"
    echo -e "${GREEN}2)${NC} No, just display"
    echo ""
    echo -ne "${BLUE}Enter choice [1-2]: ${NC}"
    read save_choice
    
    if [ "$save_choice" = "1" ]; then
        echo ""
        echo -ne "${BLUE}Enter filename (e.g., encoded_payload.txt): ${NC}"
        read filename
        if [ -z "$filename" ]; then
            filename="encoded_payload_$(date +%Y%m%d_%H%M%S).txt"
        fi
        
        echo "$payload" > "$filename"
        echo -e "${GREEN}✅ Payload saved to: $filename${NC}"
        echo -e "${CYAN}📁 File location: $(pwd)/$filename${NC}"
    fi
}

# Main menu loop
while true; do
    show_menu
    read choice
    
    case $choice in
        1)
            echo ""
            echo -e "${YELLOW}📁 Available payload files:${NC}"
            if [ -d "sample_payloads" ]; then
                ls -la sample_payloads/
                echo ""
                echo -ne "${BLUE}Enter filename (e.g., basic.txt): ${NC}"
                read filename
                
                if [ -f "sample_payloads/$filename" ]; then
                    chain=$(select_chain)
                    target=$(select_target)
                    variants=$(get_variants)
                    
                    echo ""
                    echo -e "${PURPLE}🚀 Processing payload...${NC}"
                    echo ""
                    
                    # Run the framework with verbose output
                    result=$(python3 main.py --file "sample_payloads/$filename" --chain "$chain" --target "$target" --variants "$variants" --verbose 2>&1)
                    echo "$result"
                    
                    # Extract the best payload for saving
                    best_payload=$(echo "$result" | grep -A1 "Ready for deployment:" | tail -1)
                    if [ ! -z "$best_payload" ]; then
                        save_encoded "$best_payload"
                    fi
                else
                    echo -e "${RED}❌ File not found: sample_payloads/$filename${NC}"
                fi
            else
                echo -e "${RED}❌ sample_payloads directory not found${NC}"
            fi
            ;;
        2)
            echo ""
            echo -ne "${BLUE}Enter payload to obfuscate: ${NC}"
            read payload
            
            if [ ! -z "$payload" ]; then
                chain=$(select_chain)
                target=$(select_target)
                variants=$(get_variants)
                
                echo ""
                echo -e "${PURPLE}🚀 Processing payload...${NC}"
                echo ""
                
                # Run the framework with verbose output
                result=$(python3 main.py --payload "$payload" --chain "$chain" --target "$target" --variants "$variants" --verbose 2>&1)
                echo "$result"
                
                # Extract the best payload for saving
                best_payload=$(echo "$result" | grep -A1 "Ready for deployment:" | tail -1)
                if [ ! -z "$best_payload" ]; then
                    save_encoded "$best_payload"
                fi
            else
                echo -e "${RED}❌ No payload entered${NC}"
            fi
            ;;
        3)
            echo ""
            echo -e "${YELLOW}📋 Sample payloads:${NC}"
            if [ -d "sample_payloads" ]; then
                for file in sample_payloads/*; do
                    if [ -f "$file" ]; then
                        echo -e "${GREEN}$(basename "$file"):${NC} $(cat "$file")"
                    fi
                done
            else
                echo -e "${RED}❌ sample_payloads directory not found${NC}"
            fi
            ;;
        4)
            echo ""
            echo -e "${GREEN}👋 Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Invalid option. Please try again.${NC}"
            ;;
    esac
    
    echo ""
    echo -e "${CYAN}Press Enter to continue...${NC}"
    read
    clear
    echo -e "${CYAN}🎯 Advanced Payload Obfuscation Framework${NC}"
    echo -e "${CYAN}===========================================${NC}"
    echo ""
done