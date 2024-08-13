# Olist E-commerce Sales Analysis
An in-depth analysis of Olist's online sales with PostgreSQL, Excel, Python, and Tableau. A presentation sample with recommendations geared towards Sales and Marketing teams.

## Contents
1. [What is Olist?](#what-is-olist?)
2. [Data Structure](#data-structure)
3. [Insights for North Star Metrics](#insights-summary)
4. [Recommendations](#recommendations)
5. [Tableau Dashboard](#dashboard)
6. [Presentation](#presentation-sample)
7. [Citations](#data-source)

## What is Olist?
Olist is a Brazilian online platform that connects micro and small businesses to retailers and marketplaces like Walmart, B2W, Cnova, and more for selling their products. The company enables sellers to manage listings, inventory, orders, shipments and messages at a certain price per month. The shareholders in Olist include 500 Startups, RedPoint Ventures and individual investors such Flavio Dias, CEO of the Original Bank. After 8 funding rounds, Olist has become a Unicorn.

Olist serves in the B2B, SaaS space in the Retail market segments.

## Data Structure
The data contains orders by over 90,000 customers and from over 3,000 sellers, from late 2016 to 2018. A schema is provided below:

![Database Schema](database/schema.png)

## Insights Summary
We focused on the following KPIs:
1. **Sales Growth Rate**: the percentage change in the total sales over 2017 and 2018. We further partition by product category and region.
2. **Average Sales Value**: the average value of the purchases made by a customer. We further partition by product category, location, and payment type.
3. ****

#### Sales Growth Rate
- Overall sales increased **22.26%** from 2017 to 2018.
- Across product categories, **Construction Materials** and **Food and Drinks** experienced the most growth, with **267%** and **126%** respectively. The only categories that experienced a negative growth were the **Entertainment** and **Fashion** categories, with a **3.82%** and **11.75% decrease** respectively.
- The state **Roraima (RR)** experienced the most growth of **247%**, more than **5X** the second-highest sales growth state. There were five states with decrease in total sales value, and the state that experienced the most decrease was **Acre (AC)**, at almost **50% decrease in total sales**.

## Recommendations

## Dashboard

## Presentation Sample

## Data Source
https://www.kaggle.com/datasets/bhanuprasadchouki/olist-cleaned-files
