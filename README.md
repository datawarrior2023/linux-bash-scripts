# linux-bash-scripts
This project showcases my working knowledge of Linux bash scripting. The scripts included here provide a starting point, and I'm eager to continue developing more complex and efficient command-line tools in the future.

## Adding the backu_dir() Funtion to config
### **Using a Shell Function (Recommended)**

A shell function is more flexible and can handle complex logic, such as inserting a timestamp. You can add the following function to your **`.bashrc`** or **`.zshrc`** file:

```bash
backup_dir() {
    local current_time=$(date "+%Y-%m-%d_%H-%M-%S")
    local target_dir=$1
    local abs_target_dir=$(realpath "$target_dir") # Converts to absolute path
    local backup_name="${abs_target_dir##*/}_backup_${current_time}.tar.gz" # Extracts the base name of the directory
    local backup_path="${HOME}/backups/${backup_name}" # Specifies where to save the backup
    mkdir -p "${HOME}/backups" # Ensures the backup directory exists
    tar -czf "${backup_path}" -C "$(dirname "$abs_target_dir")" "$(basename "$abs_target_dir")" && echo "Backup created at: ${backup_path}"
}

```

To apply the function:

1. Open your shell's configuration file in a text editor. If you're using Bash, this file is typically **`.bashrc`** in your home directory. For Zsh, it's **`.zshrc`**.
    
    ```bash
    nano ~/.bashrc  # or ~/.zshrc for Zsh users
    ```
    
2. Copy and paste the **`backup_dir`** function into the file.
3. Save and close the file. For **`nano`**, you'd press **`Ctrl + O`**, **`Enter`** to save, and then **`Ctrl + X`** to exit.
4. Apply the changes by sourcing the file or opening a new terminal session.
    
    ```bash
    source ~/.bashrc  # or source ~/.zshrc
    ```
    
5. Now, you can use **`backup_dir`** followed by the directory name to create a timestamped backup. For example:
    
    ```bash
    backup_dir /path/to/my_directory
    ```
    

This function grabs the current timestamp, combines it with the name of the directory you want to back up, and then uses **`tar`** to create a gzipped archive of that directory. The resulting backup file's name includes the directory name and the timestamp, making it unique and sortable.

### **Explanation of the `backup_dir` Function:**

- **`local current_time=$(date "+%Y-%m-%d_%H-%M-%S")`**: Generates a timestamp string.
- **`local target_dir=$1`**: Takes the first argument passed to the function as the target directory to back up.
- **`local backup_name="${target_dir}_backup_${current_time}.tar.gz"`**: Constructs the backup file name with the directory name, the word "backup", the current timestamp, and the **`.tar.gz`** extension.
- **`tar -czf "${backup_name}" "${target_dir}"`**: Creates a compressed (gzip) tar archive of the target directory.
- **`&& echo "Backup created: ${backup_name}"`**: If the **`tar`** command succeeds, prints a message indicating the backup file's name.

Using this function, you can quickly back up any directory with a command that's easy to remember, and each backup will be uniquely identified by the timestamp in its filename.

Creating a Shell Function for Directory Backup with Timestamping

# To restore

To restore a backup created by the **`backup_dir`** function, you will need to use the **`tar`** command to extract the contents of the archive. Here's a step-by-step guide on how to do this:

1. **Locate the Backup File:**
First, locate the backup file you created. Based on the **`backup_dir`** function you have, it should be in the **`~/backups/`** directory and have a name like **`Lucky_Duck_Investigations_backup_YYYY-MM-DD_HH-MM-SS.tar.gz`**. You'll need to know the exact filename to restore it.
2. **Choose a Restore Location:**
Decide where you want to restore the contents of the backup. You could restore to the original location (overwriting the existing files) or to a new location to avoid overwriting current files.
3. **Use `tar` to Extract the Archive:**
To restore the backup to the chosen location, use the following **`tar`** command:
    
    ```bash
    bashCopy code
    tar -xzf ~/backups/Lucky_Duck_Investigations_backup_YYYY-MM-DD_HH-MM-SS.tar.gz -C /restore/location
    
    ```
    
    Replace **`Lucky_Duck_Investigations_backup_YYYY-MM-DD_HH-MM-SS.tar.gz`** with your actual backup filename and **`/restore/location`** with the path where you want to restore the files.
    
    If you want to restore to the original location and it's safe to overwrite the files, you could use:
    
    ```bash
    bashCopy code
    tar -xzf ~/backups/Lucky_Duck_Investigations_backup_YYYY-MM-DD_HH-MM-SS.tar.gz -C /home
    
    ```
    
    Here's what the **`tar`** options mean:
    
    - **`x`**: Extract files from an archive.
    - **`z`**: Uncompress the archive (since it was compressed with gzip).
    - **`f`**: Use the following argument as the name of the archive file.
    - **`C`**: Change to this directory before extracting files.
4. **Verify the Restoration:**
After extracting the files, navigate to the restore location and verify that the files have been restored correctly.

Remember that restoring files will overwrite any files in the destination directory with the same name. Always ensure that you're restoring to the correct location and that it's appropriate to overwrite any existing files. If you're uncertain, you can always extract the backup to a temporary directory first to examine the contents.
