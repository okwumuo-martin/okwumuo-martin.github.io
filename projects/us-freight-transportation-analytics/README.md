# U.S. Freight Transportation Analytics

## Project Overview

This project analyzes U.S. freight transportation activity using data from the Freight Analysis Framework (FAF6) provided by the U.S. Department of Transportation, Bureau of Transportation Statistics (BTS).

The analysis examines freight movement across U.S. states and territories, transportation modes, commodity groups, freight volume, and economic value.

The project combines R for data cleaning, transformation, analysis, and exploratory data analysis with Tableau for interactive business intelligence and visualization.

The objective is to transform a large, complex transportation dataset into actionable insights that can support logistics planning, supply chain analysis, transportation strategy, and data-driven decision-making.

---

## Business Questions

The analysis was designed to answer questions such as:

- Which states handle the largest volumes of freight?
- Which states account for the greatest freight economic value?
- Which transportation modes dominate U.S. freight movement?
- Which commodities contribute the most freight volume?
- Which commodities contribute the greatest economic value?
- Which commodities have high economic value relative to their physical weight?
- How does freight volume differ from freight economic value?
- Which states have the highest freight value density?
- What transportation and logistics patterns can be identified from the data?

---

## Dataset

### Source

Freight Analysis Framework (FAF6)  
U.S. Department of Transportation  
Bureau of Transportation Statistics

The analysis uses the 2022 FAF6 freight-flow data.

### Dataset Size

- 599,529 freight-flow records
- 11 variables
- 51 state-level geographies
- 42 commodity categories

### Main Variables

| Variable | Description |
|---|---|
| `fr_orig` | FAF origin zone |
| `dms_origst` | Origin state |
| `dms_destst` | Destination state |
| `fr_dest` | FAF destination zone |
| `fr_inmode` | Incoming transportation mode |
| `dms_mode` | Domestic transportation mode |
| `fr_outmode` | Outgoing transportation mode |
| `sctg2` | Commodity classification |
| `trade_type` | Trade type |
| `tons_2022` | Freight volume |
| `value_2022` | Freight economic value |

### Measurement Units

The FAF6 dataset reports:

- Tons: Thousand short tons
- Value: Million dollars in 2022 constant dollars
- Ton-miles: Million ton-miles where applicable

---

# Tools & Technologies

### Programming & Analysis

- R
- RStudio
- tidyverse
- dplyr
- tidyr
- ggplot2
- data.table

### Business Intelligence & Visualization

- Tableau Public
- R Markdown
- Data Visualization
- Exploratory Data Analysis
- KPI Analysis

### Version Control

- Git
- GitHub

---

# Project Workflow

The project followed the following analytical workflow:

```text
Raw FAF6 Data
      ↓
Data Inspection
      ↓
Data Cleaning
      ↓
Reference Table Integration
      ↓
Data Transformation
      ↓
Exploratory Data Analysis
      ↓
Geographic Analysis
      ↓
Commodity Analysis
      ↓
Transportation Mode Analysis
      ↓
Freight Value Analysis
      ↓
Business Insights
      ↓
Tableau Dashboard
      ↓
Recommendations
