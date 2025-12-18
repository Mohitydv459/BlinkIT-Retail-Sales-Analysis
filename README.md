# Blinkit Grocery Sales Analysis & Dashboard

## 📊 Project Overview
This project involves a comprehensive data analysis of Blinkit's grocery sales data to identify key revenue drivers, customer preferences, and operational inefficiencies. The workflow includes data cleaning and exploratory analysis using **Python**, followed by the creation of an interactive **Power BI dashboard** for stakeholder reporting.

## ❓ Business Problem
Blinkit needs to optimize its inventory and sales strategies across various outlet types and locations. However, uncleaned data and a lack of centralized reporting have made it difficult to answer critical business questions:
* Which **outlet types** (Grocery Store vs. Supermarket) generate the most revenue?
* Do customers prefer **Low Fat** or **Regular** products, and how does this vary by item category?
* How does **Outlet Size** impact overall sales performance?
* Is there a correlation between **Customer Ratings** and **Total Sales**?

**Goal:** Transform raw, unstructured data into actionable insights to improve sales forecasting and inventory management.

## 🛠️ Data Processing (Python)
Before analysis, the raw dataset required significant cleaning and transformation. The following steps were executed in the Python Jupyter Notebook (`Blinkit sales Analysis.ipynb`):

1.  **Handling Missing Values:**
    * `Item Weight`: Missing values were imputed using the **mean** weight to maintain data integrity (First check for outliers in 'Item Weight')).
2.  **Data Standardization:**
    * `Item Fat Content`: Inconsistent labels (e.g., "LF", "low fat", "reg") were standardized into two clear categories: **"Low Fat"** and **"Regular"**.
3.  **Feature Engineering:**
    * `Outlet Age`: Created a new column to calculate the age of the outlet (Current Year - Establishment Year) to analyze the impact of store longevity on sales.
4.  **Data Reduction:**
    * Dropped the `Item Visibility` column to focus on core sales drivers.

## 💡 Key Insights & Solutions
Based on the Python analysis and Power BI visualizations, the following insights were generated:

### 1. Sales Performance by Outlet
* **Insight:** **Supermarket Type1** is the dominant revenue generator, significantly outperforming Grocery Stores and Supermarket Type2.
* **Solution:** Focus inventory expansion and marketing efforts on "Supermarket Type1" locations as they yield the highest ROI.

### 2. Product Preference (Fat Content)
* **Insight:** There is a marked preference for **Low Fat** products, which generate higher total sales compared to Regular products.
* **Solution:** Increase the stock of Low Fat variations in high-demand categories (like Snack Foods and Dairy) to prevent stockouts.

### 3. Outlet Size Efficiency
* **Insight:** Surprisingly, **Medium-sized** outlets contribute more to total sales than High-sized outlets.
* **Solution:** Re-evaluate the operational costs of "High" sized outlets. Medium-sized stores appear to be the "sweet spot" for efficiency and revenue.

### 4. Correlation Analysis
* **Insight:** The correlation matrix reveals a weak correlation between `Item Weight` and `Sales`, suggesting that packaging size is less of a deciding factor for customers than product type or visibility.

## 📈 Power BI Dashboard
The final dashboard provides an interactive view of the data, featuring:
* **KPI Cards:** Total Sales, Average Rating, Number of Items Sold.
* **Sales by Item Type:** Identifying top-selling categories (Fruits & Vegetables, Snack Foods).
* **Outlet Distribution:** Sales breakdown by Tier (Location) and Outlet Size.
* **Interactive Filters:** Slicers for `Outlet Type`, `Year`, and `Item Category` to allow deep-dive analysis.

## 💻 Technology Stack
* **Python:** Pandas, NumPy (Data Cleaning & Manipulation)
* **Python:** Matplotlib, Seaborn (Exploratory Data Analysis & Correlation Heatmaps)
* **Power BI:** Dashboarding & Data Visualization
* **Jupyter Notebook:** Environment for coding and testing

## 🚀 Conclusion
This project successfully transformed raw sales data into a strategic asset. By standardizing data and visualizing key metrics, stakeholders can now make data-driven decisions to boost sales in underperforming outlet types and capitalize on the growing demand for Low Fat products.
