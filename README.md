# Finance Project Dashboard

An interactive Power BI report for reviewing project expenditure across time, departments, expense categories, projects, and approval levels.

## Dashboard overview

The report contains one page and uses a table named `finance_data_10000_rows`. The current view shows:

- Total spend of about **$22.27M**
- A Year slicer for **2023** and **2024**
- Monthly spend trend
- Spend by department and expense type
- Project-by-expense matrix
- Spend by approver

Open the Power BI report: [finance data.pbix](./finance%20data.pbix).

## Project files

- `finance data.pbix` — Power BI report and embedded model.
- `sql/mysql_analysis.sql` — MySQL 8 schema example and analysis queries.
- `power-query/clean_finance_data.m` — Power Query M example for cleaning and typing the data.
- `dax/measures.dax` — reusable measure suggestions.

The SQL, M, and DAX files are companion learning examples based on the fields visible in the report. Confirm exact names and types in the Power BI model before connecting another data source.

## Open and explore

1. Download the PBIX from this repository and open it in Power BI Desktop.
2. Use the Year slicer to switch between 2023 and 2024.
3. Select a month, department, approver, project, or expense type to cross-filter the other visuals.
4. Review the Data and Model views to inspect the source table and field types.

## Improvement roadmap

- Add a proper calendar dimension and mark it as the date table.
- Replace implicit aggregations with explicit DAX measures.
- Add budget, actual, and variance values for budget monitoring.
- Add validation for missing dates, negative amounts, duplicate transaction IDs, and incomplete categories.
- Label the reporting currency, reporting period, and data refresh date on the page.
- Document whether amounts represent actual, planned, or sample values.

## Data handling

The PBIX embeds a finance dataset. Confirm you have permission to publish and reuse the underlying data, and remove confidential or personal information before redistributing it. The visible report summaries alone do not establish that the source data is public.

## Skills practiced

Power BI report design, slicers and cross-filtering, monthly trend analysis, data modeling, DAX measures, Power Query transformations, MySQL aggregation, and data quality checks.
