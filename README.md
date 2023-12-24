# Bash Shell Database Management System (DBMS)

This project is a simple Database Management System (DBMS) implemented in Bash shell scripting. It allows users to perform basic operations on databases and tables, such as creating databases, listing databases, connecting to databases, dropping databases, creating tables, listing tables, dropping tables, inserting records, deleting records, selecting records, and updating records.

## Project Structure

The project consists of the following components:

1. **Main Script (`db_menu.sh`):**

   - The main script that serves as the entry point to the DBMS.
   - Provides a menu-driven interface for performing various database operations.

2. **Database Operations:**

   - `db_create.sh`: Script to create a new database.
   - `db_list.sh`: Script to list existing databases.
   - `db_drop.sh`: Script to drop (delete) an existing database.

3. **Table Operations:**
   - `createTable.sh`: Script to create a new table within a database.
   - `listTable.sh`: Script to list existing tables within a database.
   - `dropTable.sh`: Script to drop (delete) an existing table within a database.
   - `insertTable.sh`: Script to insert records into a table.
   - `deleteTable.sh`: Script to delete records from a table.
   - `selectTable.sh`: Script to select and display records from a table.
   - `updateTable.sh`: Script to update records in a table.

## Running the Project

To run this project, follow these steps:

1. **Download the Project:**

   - Download the project files from the repository. You can do this by cloning the repository or downloading the ZIP file.

2. **Create a Folder Named `DBMS`:**

   - After downloading the project, create a folder named `DBMS` in the directory where you've placed the project files. This folder will be the root directory for the DBMS scripts.

   ```bash
   $ mkdir DBMS
   ```

3. **Move Project Files to `DBMS` Folder:**

   - Move all the project files into the newly created `DBMS` folder.

   ```bash
   $ mv * DBMS/
   ```

4. **Navigate to `DBMS` Folder:**

   - Change your current working directory to the `DBMS` folder.

   ```bash
   $ cd DBMS
   ```

5. **Run the DBMS:**

   - Execute the `db_menu.sh` script to launch the DBMS.

   ```bash
   $ ./db_dir/db_menu.sh
   ```

6. **Follow On-Screen Instructions:**
   - Follow the on-screen menu to choose the desired database and table operations.

Now, the project is set up, and you can interact with the DBMS through the provided scripts.

### Notes:

- Make sure you have the appropriate permissions to execute the scripts. If not, you can use the following command to grant execute permissions:

  ```bash
  $ find ~/DBMS -type f -name "*.sh" -exec chmod +x {} +
  ```

By organizing the project files into the `DBMS` folder, you create a clean structure for the project, making it easy to manage and run the scripts.

## Notes

- Database and table names cannot be empty or contain special characters.
- Primary keys are supported, and they must be unique within a table.

## Contributing

- Feel free to contribute to the project by submitting bug reports, feature requests, or code improvements through GitHub.
