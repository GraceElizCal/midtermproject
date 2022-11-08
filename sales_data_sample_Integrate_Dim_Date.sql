# ===================================================================================
# How to Integrate a Dimension table. In other words, how to look-up Foreign Key
# values FROM a dimension table and add them to new Fact table columns.
#
# First, go to Edit -> Preferences -> SQL Editor and disable 'Safe Edits'.
# Close SQL Workbench and Reconnect to the Server Instance.
# ===================================================================================

USE sales_data_sample_dw;

# ==============================================================
# Step 1: Add New Column(s)
# ==============================================================
ALTER TABLE sales_data_sample_dw.fact_sales
ADD COLUMN date_key int NOT NULL AFTER date;

# ==============================================================
# Step 2: Update New Column(s) with value from Dimension table
#         WHERE Business Keys in both tables match.
# ==============================================================
UPDATE sales_data_sample_dw.fact_sales AS fs
JOIN sales_data_sample_dw.dim_date AS dd
ON DATE(fs.date) = dd.full_date
SET fs.date_key = dd.date_key;



# ==============================================================
# Step 3: Validate that newly updated columns contain valid data
# ==============================================================
SELECT date
	, date_key
    
FROM sales_data_sample_dw.fact_sales
LIMIT 10;

# =============================================================
# Step 4: If values are correct then drop old column(s)
# =============================================================
ALTER TABLE sales_data_sample_dw.fact_sales
DROP COLUMN date;


# =============================================================
# Step 5: Validate Finished Fact Table.
# =============================================================
SELECT * FROM sales_data_sample_dw.fact_sales
LIMIT 10;

