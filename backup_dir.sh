# This function was added to provide an efficient way to back up directories. It creates a
# gzipped tarball of the specified directory, appending a timestamp to the filename for
# version control. This ensures each backup is unique and sortable. It's a convenient tool
# for data protection and recovery.
backup_dir() {
    local current_time=$(date "+%Y-%m-%d_%H-%M-%S")  # Get the current time in a sortable format: Year-Month-Day_Hours-Minutes-Seconds
    local target_dir=$1  # The first argument to the function: the directory to be backed up
    local abs_target_dir=$(realpath "$target_dir")  # Convert the target directory to an absolute path
    local backup_name="${abs_target_dir##*/}_backup_${current_time}.tar.gz"  # Create the backup filename using the directory name and current time
    local backup_path="${HOME}/backups/${backup_name}"  # Set the full path where the backup will be saved
    mkdir -p "${HOME}/backups"  # Ensure the backup directory exists by creating it if it doesn't
    tar -czf "${backup_path}" -C "$(dirname "$abs_target_dir")" "$(basename "$abs_target_dir")" && echo "Backup created at: ${backup_path}"  # Create the tarball, change to the parent directory, backup the target directory, and echo the backup path
}
