Use Excelr;

CREATE TABLE HRCleanedData (
    EmpID VARCHAR(50) PRIMARY KEY,
    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EmployeeCount INT,
    EmployeeNumber INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(50),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 Varchar(10),
    OverTime VARCHAR(10),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours Int,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/SQL/HR1.csv'
INTO TABLE HRCleanedData
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/SQL/HR2.csv'
INTO TABLE HRCleanedData
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
select * from HRCleanedData;

-- KPI Cards
select count(EMPID) as Employee_Count, count(case when attrition = 'yes' then 1 end) As Leavers, 
round((count(case when attrition = 'yes' then 1 end)/Count(*))*100,2) as Attrition_Percentage from HRCleanedData;  -- KPI CARDS

-- Attrition By Department
Select Department, count(EMPID) as Employee_Count ,
count(case when attrition = 'yes' then 1 end) As Leavers, 
round((count(case when attrition = 'yes' then 1 end)/Count(*))*100,2) as Attrition_Rate 
from HRCleanedData group by department order by Employee_Count desc;   -- Attrition by Department


-- Attrition By Job Role
Select JobRole, count(EMPID) as Employee_Count ,
count(case when attrition = 'yes' then 1 end) As Leavers, 
round((count(case when attrition = 'yes' then 1 end)/Count(*))*100,2) as Attrition_Rate 
from HRCleanedData group by JobRole order by Attrition_Rate desc;  -- Attrition By Jobrole

-- Attrition By Age Group

Select case When Age <= 25 then '18-25' 
when Age<= 35 then '26-35' 
when Age <= 45 then '36-45' 
When age<=55 then '46-55' Else '56+' End as AgeGroup, count(EMPID) as Employee_Count ,
count(case when attrition = 'yes' then 1 end) As Leavers, 
round((count(case when attrition = 'yes' then 1 end)/Count(*))*100,2) as Attrition_Rate 
from HRCleanedData group by Agegroup order by AgeGroup;  -- Attrition By Age Group


-- Attrition By Salary Slab
Select case When MonthlyIncome<3000 then '1-Low'
When MonthlyIncome<5000 then '2-Lower Medium'
When MonthlyIncome<8000 then '3-Medium' 
When MonthlyIncome<12000 then '4-Upper Medium'
When MonthlyIncome<16000 then '5-High'
Else '6-Very High' End As Salary_Slab, count(EmpID) As Employee_Count,
 count(case when attrition = 'yes' then 1 end) As Leavers, 
round((count(case when attrition = 'yes' then 1 end)/Count(*))*100,2) as Attrition_Rate
from HRCleanedData group by Salary_Slab Order by Salary_Slab;

-- Attrition By Tenure
Select case When YearsAtCompany <=1 then '0-1'
When YearsAtCompany <=3 then '2-3'
When YearsAtCompany <=5 then '4-5'
When YearsAtCompany <=10 then '6-10'
Else '11+' End As TenureBand , Count(EmpID) As Employee_Count,
count(case when attrition = 'yes' then 1 end) As Leavers, 
round((count(case when attrition = 'yes' then 1 end)/Count(*))*100,2) as Attrition_Rate
from HRCleanedData group by TenureBand order by cast(TenureBand AS UNSIGNED) ASC; 

-- Attrition By Distance
Select case When DistanceFromHome <=5 then '1-5' 
When DistanceFromHome <=10 then '6-10'
When DistanceFromHome <=20 then '11-20'
Else '21+' End As DistanceBand   , Count(EMpID) as Employee_Count,
count(case when attrition = 'yes' then 1 end) As Leavers, 
round((count(case when attrition = 'yes' then 1 end)/Count(*))*100,2) as Attrition_Rate
from HRCleanedData group by DistanceBand Order by cast(DistanceBand As Unsigned) Asc;


-- Attrition By OverTime
Select OverTime, Count(EmpID) as Employee_Count,
count(case when attrition = 'yes' then 1 end) As Leavers, 
round((count(case when attrition = 'yes' then 1 end)/Count(*))*100,2) as Attrition_Rate
from HRCleanedData group by Overtime order by OverTime Desc;

-- Attrition By Stock Option Level

Select StockOptionLevel, Count(EmpID) as Employee_Count,
count(case when attrition = 'yes' then 1 end) As Leavers, 
round((count(case when attrition = 'yes' then 1 end)/Count(*))*100,2) as Attrition_Rate
from HRCleanedData group by StockOptionLevel order by StockOptionLevel;

-- Attrition By Business Travel
Update    HRCleanedData  set BusinessTravel='Travel_Rarely' where BusinessTravel = 'TravelRarely';

Select BusinessTravel, Count(EmpID) as Employee_Count,
count(case when attrition = 'yes' then 1 end) As Leavers, 
round((count(case when attrition = 'yes' then 1 end)/Count(*))*100,2) as Attrition_Rate
from HRCleanedData group by BusinessTravel order by BusinessTravel;


--  Attrition By Marital Status
Select MaritalStatus, Count(EmpID) as Employee_Count,
count(case when attrition = 'yes' then 1 end) As Leavers, 
round((count(case when attrition = 'yes' then 1 end)/Count(*))*100,2) as Attrition_Rate
from HRCleanedData group by MaritalStatus order by MaritalStatus;

-- Attrition By Job Level
Select JobLevel, Count(EmpID) as Employee_Count,
count(case when attrition = 'yes' then 1 end) As Leavers, 
round((count(case when attrition = 'yes' then 1 end)/Count(*))*100,2) as Attrition_Rate
from HRCleanedData group by JobLevel order by JobLevel;

-- Attrition By Gender

Select Gender, Count(EmpID) as Employee_Count,
count(case when attrition = 'yes' then 1 end) As Leavers, 
round((count(case when attrition = 'yes' then 1 end)/Count(*))*100,2) as Attrition_Rate
from HRCleanedData group by Gender order by Gender;

-- Attrition Rate Vs Monthly Income
Select round(monthlyincome,-3)as MonthlyIncomeStep, Count(Empid) As Employee_Count, 
count(case when attrition = 'yes' then 1 end) As Leavers, 
round((count(case when attrition = 'yes' then 1 end)/Count(*))*100,2) as Attrition_Rate
from HRCleanedData group by MonthlyIncomeStep Order by MonthlyIncomeStep;


-- Attrition Rate vs Years Since Last Promotion
select YearsSinceLastPromotion As Last_Promotion, Count(Empid) as Employee_Count,
count(case when attrition = 'yes' then 1 end) As Leavers, 
round((count(case when attrition = 'yes' then 1 end)/Count(*))*100,2) as Attrition_Rate
from HRCleanedData group by Last_Promotion Order by Last_Promotion;

-- Age Group vs Salary Slab
 Select case When Age <= 25 then '18-25' 
when Age<= 35 then '26-35' 
when Age <= 45 then '36-45' 
When age<=55 then '46-55' Else '56+' End as AgeGroup, 
Sum(case When MonthlyIncome<3000  then 1 End ) As Low_Income_Attrition,
Sum(Case When MonthlyIncome<5000 then 1 End ) As Lower_Medium_Income_Attrition,
Sum(Case When MonthlyIncome<8000 then 1 End ) As Medium_Income_Attrition,
Sum(Case When MonthlyIncome<12000 then 1 End ) As Upper_Medium_Income_Attrition,
Sum(Case When MonthlyIncome<16000 then 1 End ) As High_Income_Attrition,
Sum(Case When MonthlyIncome>16000 then 1 End ) As Very_High_Income_Attrition
from HRCleanedData Group by AgeGroup Order by AgeGroup;