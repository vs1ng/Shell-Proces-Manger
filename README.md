# Process Manager

A simple and efficient process manager implemented in a shell script. This tool allows users to run commands in the background, manage running processes, and maintain a history of executed commands. It provides a user-friendly menu interface for easy navigation and operation.

## Features

- **Run Commands in Background**: Execute shell commands in the background and continue using the terminal.
- **List Running Processes**: View all currently running processes on the system.
- **Kill Processes**: Terminate any running process by its PID.
- **Save Commands**: Save frequently used commands to a file for later execution.
- **Load Commands**: Load and execute commands from a saved file.
- **Check Status**: Check the status of background processes.
- **View Command History**: View a history of all commands that have been executed.
- **Clear Command History**: Clear the command history file.
- **Pause and Resume Processes**: Pause and resume background processes as needed.
- **Search for Processes**: Search for specific processes by name.
- **Display Resource Usage**: Show CPU and memory usage for running processes.
- **Graceful Exit**: Ensure all background processes are terminated when exiting the program.

## Prerequisites

- A Unix-like operating system (Linux, macOS, etc.)
- Bash shell
- Basic command-line knowledge

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/process-manager.git
   cd process-manager
   ```

2. **Make the Script Executable**:
   ```bash
   chmod +x process_manager.sh
   ```

## Usage

1. **Run the Process Manager**:
   ```bash
   ./process_manager.sh
   ```

2. **Follow the On-Screen Menu**: The script will display a menu with options. Enter the number corresponding to the desired action.

3. **Available Options**:
   - **Run a command in the background**: Enter a command to execute it in the background.
   - **List running processes**: View all active processes.
   - **Kill a process**: Terminate a process by entering its PID.
   - **Save command to file**: Save a command for later use.
   - **Load commands from file**: Execute commands from a saved file.
   - **Check status of background processes**: See which background processes are still running.
   - **View command history**: Display a history of executed commands.
   - **Clear command history**: Remove all entries from the command history.
   - **Pause a process**: Temporarily stop a running process.
   - **Resume a process**: Continue a paused process.
   - **Search for a process**: Find a process by name.
   - **Display resource usage**: Show CPU and memory usage for running processes.
   - **Exit**: Close the process manager.

## Example

To run a command in the background, select option 1 and enter the command. For example:
```bash
sleep 60
```
This command will run for 60 seconds in the background.
