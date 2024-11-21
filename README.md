<h1> SQL and R Integration for Inventory Analysis </h1>

<h2> Description </h2>

This project focuses on analyzing R-rated movie stock in a DVD rental database using SQL and R. It retrieves data about movie categories and store inventory, compares stock between stores, and visualizes the results. The project also evaluates the performance of the SQL queries to identify and optimize any costly operations. The goal is to use data analysis to gain insights into the inventory and improve efficiency.


---

## Language and Tools Used
- **Programming Language**: R
- **Database**: PostgreSQL
- **Visualization**: ggplot2 (R package)

---

## Libraries
- **RPostgres**: For connecting and interacting with the PostgreSQL database.
- **ggplot2**: For creating visualizations such as bar charts and line graphs.

---

## Environment
- **RStudio**: IDE used for writing and executing the R code.
- **PostgreSQL Database**: Hosted database accessed using environment variables for secure connections.
- **.Renviron File**: Used to store database credentials securely.

---

## Main Functions Used
1. **Database Connection**:
   - `dbConnect()`: Establishes a connection to the PostgreSQL database.
   - `dbDisconnect()`: Closes the connection.

2. **Exploring the Database**:
   - `dbListTables(con)`: Lists all the tables in the database.
   - `dbListFields(con, "table_name")`: Lists all columns in a specific table.

3. **Querying Data**:
   - `dbGetQuery(con, "SQL_QUERY")`: Executes SQL queries and retrieves data into R.

4. **Validating Connection**:
   - `dbIsValid(con)`: Checks if the database connection is active.

5. **Visualization**:
   - `geom_bar()`: Creates bar charts.
   - `geom_line()`: Creates line graphs.
   - `labs()`: Adds labels and titles to the visualizations.

---

## Types of Tasks
1. **Data Extraction**:
   - Retrieve and filter data using SQL queries.
   - Use Common Table Expressions (CTEs) for structured queries.

2. **Data Exploration**:
   - List tables and columns to understand the database structure.
   - Preview and summarize specific tables (e.g., `payment`, `rental`).

3. **Data Analysis**:
   - Calculate daily income from movie rentals.
   - Count the inventory of R-rated movies by category and store.

4. **Visualization**:
   - Generate line graphs to visualize daily revenue.
   - Create bar charts to compare movie inventory across stores and categories.

5. **Performance Evaluation**:
   - Use `EXPLAIN ANALYSE` to analyze the query execution plan and identify costly steps.

---

## How to Use
1. Clone the repository and set up the PostgreSQL database connection.
2. Use the `.Renviron` file to store database credentials securely.
3. Run the R script in RStudio to execute the SQL queries and generate visualizations.
4. Review the bar chart and line graph for insights into the DVD rental data.
5. Check the query execution plan to understand and optimize performance.

---

## Key Deliverables
- Data visualizations (line graph and bar chart).
- SQL execution plan analysis for optimization.
- Insights into the inventory of R-rated movies across stores.

