# Install and load necessary packages
library(RPostgres)
library(ggplot2)

# Establish a connection to the PostgreSQL database
con <- dbConnect(
  Postgres(),
  dbname = "Jeff",
  host = Sys.getenv("PG_HOST"),
  port = Sys.getenv("PG_PORT"),
  user = Sys.getenv("PG_USR"),
  password = Sys.getenv("PG_PASS")
)

# Validate the connection
dbIsValid(con)

# List tables and fields
dbListTables(con)
dbListFields(con, "rental")
dbGetQuery(con, "SELECT * FROM rental LIMIT 10")
query <- "SELECT COUNT(*) FROM rental"
dbGetQuery(con, query)

# Calculating and displaying daily income from movie rentals
dbGetQuery(con, "SELECT * FROM payment LIMIT 5")
dbListFields(con, "payment")

query1 <- "
  SELECT 
    DATE(payment_date) AS rental_date, 
    SUM(amount) AS total_income
  FROM payment
  GROUP BY rental_date
  ORDER BY rental_date
"

daily_income <- dbGetQuery(con, query1)

# Plotting daily income
ggplot(daily_income, aes(x = rental_date, y = total_income)) +
  geom_line(color = "red") +
  labs(title = "Total Daily Income from Rentals", x = "Month", y = "Daily Revenue") +
  theme_minimal()

# Fetching store and address information
dbGetQuery(con, "SELECT * FROM address LIMIT 5")
dbGetQuery(con, "SELECT * FROM store LIMIT 5")

store_addresses <- dbGetQuery(con,
                              "SELECT * 
FROM address
WHERE address_id IN (SELECT address_id FROM store);
")

# R-Rated Movie Stock Analysis by Store and Category
query2 <- "
WITH movie_stock AS (
  SELECT 
  s.store_id AS store_id,                -- Alias for store ID
  a.address AS store_address,            -- Alias for store address
  c.name AS category,                    -- Alias for movie category
  COUNT(i.inventory_id) AS total_dvds    -- Aggregating function to count DVDs
  FROM store s
  JOIN address a ON s.address_id = a.address_id     -- Join 1: Link store to address
  JOIN inventory i ON s.store_id = i.store_id       -- Join 2: Link store to inventory
  JOIN film f ON i.film_id = f.film_id              -- Join 3: Link inventory to films
  JOIN film_category fc ON f.film_id = fc.film_id   -- Join 4: Link films to film_category
  JOIN category c ON fc.category_id = c.category_id -- Join 5: Link film_category to category
  WHERE f.rating = 'R'                              -- WHERE clause to filter R-rated movies
  GROUP BY s.store_id, a.address, c.name            -- Group by store, address, and category
)
SELECT * FROM movie_stock
ORDER BY store_address, category;
"

movie_stock <- dbGetQuery(con, query2)

# Plot results
ggplot(movie_stock, aes(x = category, y = total_dvds, fill = store_address)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  labs(title = "R-Rated Movie Stock by Store and Category", 
       x = "Movie Category", 
       y = "Total DVDs", 
       fill = "Stores") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Query execution plan
query3 <- "
EXPLAIN ANALYSE
WITH movie_stock AS (
  SELECT 
    s.store_id AS store_id,                -- Alias for store ID
    a.address AS store_address,            -- Alias for store address
    c.name AS category,                    -- Alias for movie category
    COUNT(i.inventory_id) AS total_dvds    -- Aggregating function to count DVDs
  FROM store s
  JOIN address a ON s.address_id = a.address_id     -- Join 1: Link store to address
  JOIN inventory i ON s.store_id = i.store_id       -- Join 2: Link store to inventory
  JOIN film f ON i.film_id = f.film_id              -- Join 3: Link inventory to films
  JOIN film_category fc ON f.film_id = fc.film_id   -- Join 4: Link films to film_category
  JOIN category c ON fc.category_id = c.category_id -- Join 5: Link film_category to category
  WHERE f.rating = 'R'                              -- WHERE clause to filter R-rated movies
  GROUP BY s.store_id, a.address, c.name            -- Group by store, address, and category
)
SELECT * FROM movie_stock
ORDER BY store_address, category;
"

query_plan <- dbGetQuery(con, query3)
print(query_plan)

# Disconnect from the database
dbDisconnect(con)
