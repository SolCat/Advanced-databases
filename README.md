# Advanced-databases

## **Project Overview**
The goal of this analysis is to identify, classify, and possibly quantify the main types of activities that a citizen engages in during a given period (here, a year). This is analyzed for specific profiles such as gender, marital status, education level, and professional situation.

## **Data & Statistics**
The dataset used in this study was sourced from the MTUS website, which provides detailed time-use data from 25 countries over five decades. It focuses on a wide range of daily activities, including work, leisure, and household tasks. The data offers valuable insights into how time-use trends vary across different time periods and geographic locations. 

For more information, visit the MTUS website: [MTUS](https://www.mtusdata.org/mtus/)

## **Methodology**
- **Modeling choice**: 
  - **Database Architecture**: For our data warehouse modeling, we chose a relational model. Beyond the fact that relational database management systems (RDBMS) simplify data storage management and maintenance (due to ACID properties), they are particularly well-suited for structured data modeling.
    
  - **Data Grain**: We focused on studying an individual's daily habits, particularly the time spent on various activities and tasks. This analysis takes into account specific situational, temporal, and spatial contexts, helping us understand how these factors shape daily routines. The model is defined by individual activity instances, with measurements across dimensions such as time, location, and personal characteristics.
- **Building the Data Warehouse**
  
- **Querying the Data Warehouse**: 
  - **Top 5 countries spending the most time on work;**
  - **Top 5 activities individuals spend the most time on per day;**
  - **Average time spent on household tasks by country and sex;**
  - **Countries spending the most time on media (computer, TV) in the evening since 2000;**
  - **Evolution of work and rest time in the Netherlands between 1975 and 2005;**
  - **Average media, sports, and travel times by age group.**

## **Key Outcomes**
This project was highly enriching, as it allowed us to implement all the steps involved in data warehouse design, including building our own dataset. We spent significant time on data preprocessing and integration, facing several challenges. 

Here are the main conclusions drawn from the analysis:
- **Spaniards** work the most, averaging **7.5 hours** per day.
- **Rest** is the most time-consuming activity, followed by **work (7 hours)**, **studies (5 hours)**, and **media/household tasks (3 hours each)**.
- **Women** generally spend more time on **household chores** than men. **Israel** is the most unequal in task distribution, while **Finland** has the most equal distribution.
- Older individuals (**71+ years**) spend the most time on **media**, but they are less mobile compared to other age groups.

## Authors
Solène Catella, Maëlle Brassier, Maxime Loizon & Adrien BAZOGE
