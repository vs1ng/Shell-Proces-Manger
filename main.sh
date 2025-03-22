#!/bin/bash

# File to store commands for later execution
COMMAND_FILE="commands.txt"
COMMAND_HISTORY="command_history.txt"
PID_FILE="pids.txt"

# Function to display the menu
show_menu() {
    echo "====================="
    echo " Process Manager Menu "
    echo "====================="
    echo "1. Run a command in the background"
    echo "2. List running processes"
    echo "3. Kill a process"
    echo "4. Save command to file"
    echo "5. Load commands from file"
    echo "6. Check status of background processes"
    echo "7. View command history"
    echo "8. Clear command history"
    echo "9. Pause a process"
    echo "10. Resume a process"
    echo "11. Search for a process"
    echo "12. Display resource usage"
    echo "13. Exit"
    echo "====================="
}

# Function to run a command in the background
run_command() {
    read -p "Enter the command to run in the background: " cmd
    if [ -z "$cmd" ]; then
        echo "No command entered."
        return
    fi
    # Run the command in the background and save its PID
    eval "$cmd &"
    echo "Command '$cmd' is running in the background with PID $!"
    echo "$!" >> "$PID_FILE"  # Save the PID to a file
    echo "$cmd" >> "$COMMAND_HISTORY"  # Save command to history
}

# Function to list running processes
list_processes() {
    echo "====================="
    echo " Running Processes "
    echo "====================="
    ps -ef
}

# Function to kill a process
kill_process() {
    read -p "Enter the PID of the process to kill: " pid
    if kill "$pid" 2>/dev/null; then
        echo "Process $pid has been killed."
        # Remove the PID from the list
        sed -i "/^$pid$/d" "$PID_FILE"
    else
        echo "Failed to kill process $pid. It may not exist."
    fi
}

# Function to save a command to a file
save_command() {
    read -p "Enter the command to save: " cmd
    if [ -z "$cmd" ]; then
        echo "No command entered."
        return
    fi
    echo "$cmd" >> "$COMMAND_FILE"
    echo "Command saved to $COMMAND_FILE."
}

# Function to load commands from a file and run them
load_commands() {
    if [ ! -f "$COMMAND_FILE" ]; then
        echo "Command file $COMMAND_FILE does not exist."
        return
    fi
    while IFS= read -r cmd; do
        echo "Running command: $cmd"
        eval "$cmd &"
        echo "$!" >> "$PID_FILE"  # Save the PID to a file
    done < "$COMMAND_FILE"
    echo "All commands from $COMMAND_FILE have been executed."
}

# Function to check the status of background processes
check_status() {
    echo "====================="
    echo " Background Processes "
    echo "====================="
    if [ ! -f "$PID_FILE" ]; then
        echo "No background processes found."
        return
    fi
    while IFS= read -r pid; do
        if ps -p "$pid" > /dev/null; then
            echo "Process $pid is running."
        else
            echo "Process $pid is not running."
        fi
    done < "$PID_FILE"
}

# Function to view command history
view_command_history() {
    if [ ! -f "$COMMAND_HISTORY" ]; then
        echo "No command history found."
        return
    fi
    echo "====================="
    echo " Command History "
    echo "====================="
    cat "$COMMAND_HISTORY"
}

# Function to clear command history
clear_command_history() {
    > "$COMMAND_HISTORY"
    echo "Command history cleared."
}

# Function to pause a process
# Function to pause a process
pause_process() {
    read -p "Enter the PID of the process to pause: " pid
    if kill -STOP "$pid" 2>/dev/null; then
        echo "Process $pid has been paused."
    else
        echo "Failed to pause process $pid. It may not exist."
    fi
}

# Function to resume a process
resume_process() {
    read -p "Enter the PID of the process to resume: " pid
    if kill -CONT "$pid" 2>/dev/null; then
        echo "Process $pid has been resumed."
    else
        echo "Failed to resume process $pid. It may not exist."
    fi
}

# Function to search for a process by name
search_process() {
    read -p "Enter the name of the process to search for: " process_name
    echo "Searching for processes matching '$process_name'..."
    ps -ef | grep "$process_name" | grep -v grep
}

# Function to display resource usage of running processes
display_resource_usage() {
    echo "====================="
    echo " Resource Usage "
    echo "====================="
    echo "PID   USER     %CPU %MEM COMMAND"
    ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 10
}

# Function to handle graceful exit
graceful_exit() {
    echo "Exiting Process Manager..."
    if [ -f "$PID_FILE" ]; then
        while IFS= read -r pid; do
            if ps -p "$pid" > /dev/null; then
                kill "$pid"
                echo "Killed background process $pid."
            fi
        done < "$PID_FILE"
    fi
    exit 0
}

# Main loop
while true; do
    show_menu
    read -p "Select an option (1-13): " option
    case $option in
        1) run_command ;;
        2) list_processes ;;
        3) kill_process ;;
        4) save_command ;;
        5) load_commands ;;
        6) check_status ;;
        7) view_command_history ;;
        8) clear_command_history ;;
        9) pause_process ;;
        10) resume_process ;;
        11) search_process ;;
        12) display_resource_usage ;;
        13) graceful_exit ;;
        *) 
            echo "Invalid option. Please try again." ;;
    esac
done
