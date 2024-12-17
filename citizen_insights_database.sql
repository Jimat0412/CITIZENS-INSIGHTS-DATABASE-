CREATE DATABASE Citizen_Insights_Database;
USE Citizen_Insights_Database;
DESCRIBE basic_information;
ALTER TABLE basic_information
MODIFY COLUMN DateOfBirth DATE;
UPDATE basic_information
SET DateOfBirth = STR_TO_DATE(DateOfBirth, '%d/%m/%y');
SELECT STR_TO_DATE(DateOfBirth, '%d/%m/%y') FROM basic_information;
ALTER TABLE education_information
MODIFY COLUMN GraduationYear YEAR;


-- Age Calculation
SELECT CitizenID, 
       Gender, 
       YEAR(CURRENT_DATE) - YEAR(DateOfBirth) AS Age 
FROM Basic_Information;

-- Age Calculation for Non-binary
SELECT CitizenID, 
       YEAR(CURRENT_DATE) - YEAR(DateOfBirth) AS Age, 
       Gender 
FROM Basic_Information 
WHERE Gender = 'Non-binary';

-- Age Calculation for Female
SELECT CitizenID, 
       YEAR(CURRENT_DATE) - YEAR(DateOfBirth) AS Age, 
       Gender 
FROM Basic_Information 
WHERE Gender = 'Female';

-- Age Calculation for Male
SELECT CitizenID, 
       YEAR(CURRENT_DATE) - YEAR(DateOfBirth) AS Age, 
       Gender 
FROM Basic_Information 
WHERE Gender = 'Male';

-- Calculation for MaritalStatus 
SELECT MaritalStatus,COUNT(*) AS Totalcount
FROM Basic_Information
GROUP BY MaritalStatus;

-- Calculation for State
SELECT State,COUNT(*) AS Totalcount
FROM Basic_Information
GROUP BY State;

-- Calculation for EmploymentStatus
SELECT EmploymentStatus,COUNT(*) AS Totalcount
FROM Basic_Information
GROUP BY EmploymentStatus;

-- Calculation for city
SELECT City,COUNT(*) AS Totalcount
FROM Basic_Information
GROUP BY city;

-- Total Annual income
SELECT SUM(AnnualIncome) AS TotalAnnualIncome
FROM Basic_Information;

-- Gender Distribution:
SELECT Gender, COUNT(*) AS Count 
FROM Basic_Information 
GROUP BY Gender;

-- Most Popular Fields of Study
SELECT FieldOfStudy, COUNT(*) AS Count 
FROM Education_Information 
GROUP BY FieldOfStudy 
ORDER BY Count DESC;

-- categorize the ages
SELECT
    DateOfBirth,
    CASE
        WHEN Age BETWEEN 19 AND 25 THEN 'Young Adults'
        WHEN Age BETWEEN 26 AND 55 THEN 'Mid-Career'
        WHEN Age BETWEEN 56 AND 75 THEN 'Seniors'
        ELSE 'Other'  -- You can handle cases outside 19-75 range if needed
    END AS AgeGroup
FROM basic_information;

-- Most Popular HighestEducation
SELECT HighestEducation, COUNT(*) AS Count 
FROM Education_Information 
GROUP BY HighestEducation
ORDER BY Count DESC;

-- LanguageProficiency count
SELECT LanguageProficiency, COUNT(*) AS Count 
FROM Education_Information
GROUP BY LanguageProficiency;

-- SocialSecurity count
SELECT SocialSecurity, COUNT(*) AS Count 
FROM government_benefits
GROUP BY SocialSecurity;

-- HealthcarePlan count
SELECT HealthcarePlan, COUNT(*) AS Count 
FROM government_benefits
GROUP BY HealthcarePlan;

-- UnemploymentBenefits count
SELECT UnemploymentBenefits, COUNT(*) AS Count 
FROM government_benefits
GROUP BY UnemploymentBenefits;

-- DisabilityBenefits count
SELECT DisabilityBenefits, COUNT(*) AS Count 
FROM government_benefits
GROUP BY DisabilityBenefits;

-- Total VolunteerHoursPerYear
SELECT SUM(VolunteerHoursPerYear) AS TotalVolunteerHoursPerYear
FROM civic_engagement;

-- VoterRegistration Count
SELECT VoterRegistration, COUNT(*) AS Count 
FROM civic_engagement
GROUP BY VoterRegistration;

-- CommunityGroupMembership Count
SELECT CommunityGroupMembership, COUNT(*) AS Count 
FROM civic_engagement
GROUP BY CommunityGroupMembership;

-- Total DonationsToCharity
SELECT SUM(DonationsToCharity) AS TotalDonationsToCharity
FROM civic_engagement;

-- Correlation Between Income and Education AVG
SELECT e.HighestEducation, AVG(b.AnnualIncome) AS AvgAnnualIncome
FROM Basic_Information b
JOIN Education_Information e ON b.CitizenID = e.CitizenID
GROUP BY e.HighestEducation
ORDER BY AvgAnnualIncome DESC;

-- Correlation Between Income and Education AVG
SELECT e.HighestEducation, SUM(b.AnnualIncome) AS SUMAnnualIncome
FROM Basic_Information b
JOIN Education_Information e ON b.CitizenID = e.CitizenID
GROUP BY e.HighestEducation
ORDER BY SUMAnnualIncome DESC;

SELECT e.HighestEducation, MAX(b.AnnualIncome) AS MaxAnnualIncome
FROM Basic_Information b
JOIN Education_Information e ON b.CitizenID = e.CitizenID
GROUP BY e.HighestEducation
ORDER BY MaxAnnualIncome DESC;

-- maximum or minimum income for each education level
SELECT e.HighestEducation, MAX(b.AnnualIncome) AS MaxAnnualIncome
FROM Basic_Information b
JOIN Education_Information e ON b.CitizenID = e.CitizenID
GROUP BY e.HighestEducation
ORDER BY MaxAnnualIncome DESC;

SELECT e.HighestEducation, MIN(b.AnnualIncome) AS MINAnnualIncome
FROM Basic_Information b
JOIN Education_Information e ON b.CitizenID = e.CitizenID
GROUP BY e.HighestEducation
ORDER BY MINAnnualIncome DESC;

-- Citizens Receiving Multiple Benefits
SELECT CitizenID 
FROM Government_Benefits 
WHERE SocialSecurity = 'TRUE' 
  AND UnemploymentBenefits = 'TRUE' 
  AND DisabilityBenefits = 'TRUE';
  
  -- Healthcare Plan Popularity
  SELECT HealthcarePlan, COUNT(*) AS Count 
FROM Government_Benefits 
GROUP BY HealthcarePlan 
ORDER BY Count DESC;

-- Voter Registration Rates
SELECT COUNT(*) AS RegisteredVoters 
FROM Civic_Engagement 
WHERE VoterRegistration = 'TRUE';

-- Volunteer Activity by Employment Status
SELECT b.EmploymentStatus, AVG(c.VolunteerHoursPerYear) AS AvgVolunteerHours 
FROM Basic_Information b
JOIN Civic_Engagement c ON b.CitizenID = c.CitizenID
GROUP BY b.EmploymentStatus;

-- Education and Civic Engagemen
SELECT e.HighestEducation, c.CommunityGroupMembership, COUNT(*) AS Count 
FROM Education_Information e
JOIN Civic_Engagement c ON e.CitizenID = c.CitizenID
GROUP BY e.HighestEducation, c.CommunityGroupMembership;

-- Regional Analysis of Income and Donations AVG
SELECT b.State, AVG(b.AnnualIncome) AS AvgIncome, AVG(c.DonationsToCharity) AS AvgDonations 
FROM Basic_Information b
JOIN Civic_Engagement c ON b.CitizenID = c.CitizenID
GROUP BY b.State;

-- Regional Analysis of Income and Donations SUM
SELECT b.State, SUM(b.AnnualIncome) AS TOTALIncome, SUM(c.DonationsToCharity) AS TOTALDonations 
FROM Basic_Information b
JOIN Civic_Engagement c ON b.CitizenID = c.CitizenID
GROUP BY b.State;

-- Annual Income by Highest Education
SELECT e.HighestEducation, 
       SUM(b.AnnualIncome) AS TotalAnnualIncome, 
       AVG(b.AnnualIncome) AS AverageAnnualIncome
FROM Basic_Information b
JOIN Education_Information e ON b.CitizenID = e.CitizenID
GROUP BY e.HighestEducation
ORDER BY TotalAnnualIncome DESC;

-- Analyze the average annual income across different age groups
SELECT 
    CASE 
        WHEN YEAR(CURRENT_DATE) - YEAR(DateOfBirth) BETWEEN 18 AND 30 THEN '18-30'
        WHEN YEAR(CURRENT_DATE) - YEAR(DateOfBirth) BETWEEN 31 AND 45 THEN '31-45'
        WHEN YEAR(CURRENT_DATE) - YEAR(DateOfBirth) BETWEEN 46 AND 60 THEN '46-60'
        ELSE '61+' 
    END AS AgeGroup,
    AVG(AnnualIncome) AS AvgIncome,
    COUNT(*) AS TotalCitizens
FROM Basic_Information
GROUP BY AgeGroup
ORDER BY AgeGroup;

 -- Identify the proportion of citizens receiving multiple government benefits.
 SELECT 
    COUNT(*) AS TotalCitizens,
    SUM(CASE 
        WHEN SocialSecurity = 'TRUE' AND UnemploymentBenefits = 'TRUE' AND DisabilityBenefits = 'TRUE' THEN 1 
        ELSE 0 
    END) AS MultipleBenefits
FROM Government_Benefits;

-- Measure average volunteer hours and voter registration rates by state.
SELECT 
    b.State,
    AVG(c.VolunteerHoursPerYear) AS AvgVolunteerHours,
    SUM(CASE WHEN c.VoterRegistration = 'TRUE' THEN 1 ELSE 0 END) / COUNT(*) * 100 AS VoterRegistrationRate
FROM Basic_Information b
JOIN Civic_Engagement c ON b.CitizenID = c.CitizenID
GROUP BY b.State
ORDER BY AvgVolunteerHours DESC;

-- Examine the distribution of education levels across genders.
SELECT 
    b.Gender, 
    e.HighestEducation, 
    COUNT(*) AS Total
FROM Basic_Information b
JOIN Education_Information e ON b.CitizenID = e.CitizenID
GROUP BY b.Gender, e.HighestEducation
ORDER BY b.Gender, e.HighestEducation;

-- Analyze whether higher-income citizens are more engaged in community activities.
SELECT 
    CASE 
        WHEN b.AnnualIncome < 50000 THEN 'Low Income'
        WHEN b.AnnualIncome BETWEEN 50000 AND 100000 THEN 'Middle Income'
        ELSE 'High Income'
    END AS IncomeGroup,
    AVG(c.VolunteerHoursPerYear) AS AvgVolunteerHours,
    AVG(c.DonationsToCharity) AS AvgDonations
FROM Basic_Information b
JOIN Civic_Engagement c ON b.CitizenID = c.CitizenID
GROUP BY IncomeGroup
ORDER BY IncomeGroup;

-- Find the percentage of unemployed citizens receiving government benefits.
SELECT 
    b.EmploymentStatus,
    SUM(CASE WHEN g.SocialSecurity = 'TRUE' OR g.UnemploymentBenefits = 'TRUE' OR g.DisabilityBenefits = 'TRUE' THEN 1 ELSE 0 END) / COUNT(*) * 100 AS BenefitsRate
FROM Basic_Information b
JOIN Government_Benefits g ON b.CitizenID = g.CitizenID
WHERE b.EmploymentStatus = 'Unemployed'
GROUP BY b.EmploymentStatus;

-- citizens into high, medium, and low civic engagement groups.
SELECT 
    CitizenID,
    CASE 
        WHEN VolunteerHoursPerYear > 300 OR DonationsToCharity > 5000 THEN 'High Engagement'
        WHEN VolunteerHoursPerYear BETWEEN 100 AND 300 OR DonationsToCharity BETWEEN 1000 AND 5000 THEN 'Medium Engagement'
        ELSE 'Low Engagement'
    END AS EngagementLevel
FROM Civic_Engagement;

-- SQL Query for Age Groups
SELECT 
    CASE
        WHEN TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) BETWEEN 19 AND 25 THEN '19–25'
        WHEN TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) BETWEEN 26 AND 35 THEN '26–35'
        WHEN TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) BETWEEN 36 AND 45 THEN '36–45'
        WHEN TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) BETWEEN 46 AND 55 THEN '46–55'
        WHEN TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) BETWEEN 56 AND 65 THEN '56–65'
        WHEN TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) BETWEEN 66 AND 75 THEN '66–75'
    END AS AgeGroup,
    COUNT(*) AS PopulationCount
FROM basic_information
GROUP BY AgeGroup;

-- calculations of citizens ages
SELECT 
    CitizenID,
    FirstName,
    LastName,
    Gender,
    DateOfBirth,
    FLOOR(DATEDIFF(CURDATE(), DateOfBirth) / 365) AS Age
FROM 
    basic_information;

-- income level
SELECT 
    AnnualIncome,
    CASE 
        WHEN AnnualIncome < 30000 THEN 'Low Income'
        WHEN AnnualIncome >= 30000 AND AnnualIncome < 70000 THEN 'Medium Income'
        WHEN AnnualIncome >= 70000 AND AnnualIncome < 150000 THEN 'High Income'
        ELSE 'Very High Income'
    END AS Income_Level
FROM basic_information;

-- categorising age group
SELECT 
    CitizenID,
    FirstName,
    LastName,
    Gender,
    DateOfBirth,
    FLOOR(DATEDIFF(CURDATE(), DateOfBirth) / 365) AS Age,
    CASE
        WHEN FLOOR(DATEDIFF(CURDATE(), DateOfBirth) / 365) BETWEEN 19 AND 25 THEN 'Young Adults'
        WHEN FLOOR(DATEDIFF(CURDATE(), DateOfBirth) / 365) BETWEEN 26 AND 55 THEN 'Mid-Career'
        WHEN FLOOR(DATEDIFF(CURDATE(), DateOfBirth) / 365) BETWEEN 56 AND 75 THEN 'Seniors'
        ELSE 'Other'  -- For ages outside the specified range
    END AS AgeGroup
FROM 
    basic_information;

-- Total Population
SELECT COUNT(*) AS TotalPopulation FROM basic_information;

-- Percentage Calculation
SELECT 
    AgeGroup,
    (PopulationCount / TotalPopulation) * 100 AS PopulationPercentage
FROM (
    SELECT 
        CASE
            WHEN TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) BETWEEN 19 AND 25 THEN '19–25'
            WHEN TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) BETWEEN 26 AND 35 THEN '26–35'
            WHEN TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) BETWEEN 36 AND 45 THEN '36–45'
            WHEN TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) BETWEEN 46 AND 55 THEN '46–55'
            WHEN TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) BETWEEN 56 AND 65 THEN '56–65'
            WHEN TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) BETWEEN 66 AND 75 THEN '66–75'
        END AS AgeGroup,
        COUNT(*) AS PopulationCount
    FROM basic_information
    GROUP BY AgeGroup
) AS AgeGroupData,
(SELECT COUNT(*) AS TotalPopulation FROM basic_information) AS TotalData;

USE citizen_insights_database;

 -- modify the State
 UPDATE Basic_Information
SET STATE = 'New York'
WHERE STATE = 'NY';

 UPDATE Basic_Information
SET STATE = 'Texas'
WHERE STATE = 'TX';

UPDATE Basic_Information
SET STATE = 'California'
WHERE STATE = 'CA';

UPDATE Basic_Information
SET STATE = 'Arizona'
WHERE STATE = 'AZ';

UPDATE Basic_Information
SET STATE = 'Illinois'
WHERE STATE = 'IL';
SELECT *FROM Basic_Information;