## CITIZENS-INSIGHTS

### Table Of Contents 

- [PROJECT OVERVIEW](PROJECT-OVERVIEW)
- [Data Source](Data-Source)
- [Tools](Tools)
- [Data Cleaning](Data-Cleaning)
- [EXPLORATORY DATA ANALYSIS](EXPLORATORY-DATA-ANALYSIS)
- [Data Analysis](Data-Analysis)
- [Results](Results)
- [Recommendations](Recommendations)
- [Limitations](Limitations)
  

### PROJECT OVERVIEW

The project aims to analyze a comprehensive dataset of citizen information to extract meaningful insights about demographics, education, government benefits, and civic engagement. The goal is to support data-driven decision-making, policy development, and segmentation strategies for government or civic organizations.

### Data Source

We have four (4) diffeent Tables which comes together to form Citizens insights database, which are "Basic_Information.csv" , "Civic_Engagement.csv" , "Education_Information.csv" and "Government_Benefits.csv".
in this we have a file where all tables are merged together, named Basic_Information updated.xlsx.[ Download Raw files Here](https://drive.google.com/drive/folders/1hv02xDaz68abIbgeCEUrf2hv5dQ73aty?usp=drive_link)


### Tools

- Excel - For Data Visualisation to present insights graphically. [Download Here](https://docs.google.com/spreadsheets/d/1N-xF1zd9L-8_ScBI99l497MRDz-D6vek/edit?usp=drive_link&ouid=104347593445969271770&rtpof=true&sd=true)
- SQL -  For querying, joining, and analyzing the relational database. [Download Here](https://drive.google.com/file/d/1asHJbJ6J3l3QLDdwPAt4bJJFsCCyJeVP/view?usp=drive_link)


### Data Cleaning

In the inital data phase we performed the following tasks:
1. Data Loading and inspection
2. Standardizing Of Data
3. inconsistent formats for dates and years
4. Complex Query Logic


### EXPLORATORY DATA ANALYSIS 

- Identification of demographic groups requiring focused support or engagement.
- Insights into the role of education in economic outcomes.
- Understanding of benefit reliance patterns and potential inefficiencies.
- Evidence-based strategies to enhance civic engagement across communities.


### Data Analysis

Some Codes worked with:

AGE CALCULATION
```SQL
SELECT CitizenID, 
       Gender, 
       YEAR(CURRENT_DATE) - YEAR(DateOfBirth) AS Age 
FROM Basic_Information;
```

Total Annual income
```SQL
SELECT SUM(AnnualIncome) AS TotalAnnualIncome
FROM Basic_Information;
```

 categorizing of ages
```SQL
SELECT
    DateOfBirth,
    CASE
        WHEN Age BETWEEN 19 AND 25 THEN 'Young Adults'
        WHEN Age BETWEEN 26 AND 55 THEN 'Mid-Career'
        WHEN Age BETWEEN 56 AND 75 THEN 'Seniors'
        ELSE 'Other'  -- You can handle cases outside 19-75 range if needed
    END AS AgeGroup
FROM basic_information;
```


### Results
### KEY FINDINGS [Age and Population Distribution]

- Mid-career (26–55) constitutes the largest portion of the population, encompassing individuals at the peak of their professional and economic productivity
- Seniors (56–75) show a noticeable proportion, reflecting an ageing demographic that requires healthcare and retirement support.
- Young Adults (19–25) represent a smaller but critical segment, transitioning from education into the workforce.

### KEY FINDINGS [INCOME AND AGE]

- Mid-career (26–55) individuals are the backbone of economic activities due to career stability and higher earning potential.
- Young Adults (19–25) are still in skill-building and entry-level stages, contributing less economically but holding high future potential.
- Seniors (56–75) contribute through mentorship, advisory roles, and part-time engagements but gradually withdraw from the primary workforce.

### KEY FINDINGS [Civic Engagement Patterns]

- Younger groups (19–25) may exhibit lower voter turnout and civic participation, necessitating targeted engagement initiatives
- Middle-aged groups (26–65) are likely to be the most actively involved in civic and economic activities.
- Older groups (66+) contribute through community and volunteer activities but require supportive policies for healthcare and social inclusion.

### KEY FINDINGS [SUPPORT NEEDS]

- Young Adults (19–25) rely on educational, training, and employment programs to integrate into the workforce effectively.
- Mid-career (26–55) have moderate support needs, including career development and family support services.
- Seniors (56–75) require significant support in healthcare, social security, and community engagement opportunities.


### RECOMMENDATIONS

1. Targeted Programs for Young Adults (19–25) like, Offer scholarships and affordable vocational training for internships and job placements, also, Implement civic education programs to boost participation in voting and community development.
2. Support for Mid-Career (26–55) like, Encourage continuous professional education and leadership training programs.
3. Comprehensive Senior Care (56–75) like, Expand affordable and accessible healthcare services, including preventive care, Offer financial literacy programs tailored for retirees to manage savings and pensions effectively.


### Limitations

1. The dataset had missed information and some columns with the wrong data types (like text instead of Date).
- Filled in the State’s abbreviation name with the correct full name.
- Fixed incorrect formats to make the data usable for analysis.
2. It was tricky to decide how to divide ages into meaningful groups for analysis. Some ages in the data didn’t make sense 
- Age groups were created logically, like young adults (19–25), Mid-career (26–55), and Senior (56–75).
3. Setting up income brackets (Low, Medium, High, Very High) was challenging because the data had a wide range of incomes.
- Adjusted these brackets until they made sense for the analysis.
4. Turning raw data into clear charts and graphs that tell a story was tough at first.
- Used tools like Power Query, and Excel to create clean visuals.
- Focused on making charts easy to understand, even for someone without a data background.
5. Turning raw data into clear charts and graphs that tell a story was tough at first.
- Used tools like Power Query, and Excel to create clean visuals.
- Focused on making charts easy to understand, even for someone without a data background.





