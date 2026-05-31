CREATE DATABASE heart_db;

USE heart_db;

CREATE TABLE heart_data (
    Age INT,
    Sex VARCHAR(10),
    ChestPainType VARCHAR(10),
    RestingBP FLOAT,
    Cholesterol FLOAT,
    FastingBS INT,
    RestingECG VARCHAR(10),
    MaxHR FLOAT,
    ExerciseAngina VARCHAR(10),
    Oldpeak FLOAT,
    ST_Slope VARCHAR(10),
    HeartDisease INT
);
-- Total records
SELECT COUNT(*) AS total_patients FROM heart_data;

-- Heart disease vs no heart disease count
SELECT HeartDisease, COUNT(*) AS count
FROM heart_data
GROUP BY HeartDisease;

-- Gender distribution
SELECT Sex, COUNT(*) AS count
FROM heart_data
GROUP BY Sex;

-- Average age of patients
SELECT AVG(Age) AS avg_age FROM heart_data;

-- Age range
SELECT MIN(Age) AS min_age, MAX(Age) AS max_age FROM heart_data;

-- Heart disease rate by gender
SELECT Sex, 
       COUNT(*) AS total,
       SUM(HeartDisease) AS disease_count,
       ROUND(SUM(HeartDisease) * 100.0 / COUNT(*), 2) AS disease_rate_pct
FROM heart_data
GROUP BY Sex;

-- Heart disease by chest pain type
SELECT ChestPainType,
       COUNT(*) AS total,
       SUM(HeartDisease) AS disease_count,
       ROUND(SUM(HeartDisease) * 100.0 / COUNT(*), 2) AS disease_pct
FROM heart_data
GROUP BY ChestPainType
ORDER BY disease_pct DESC;

-- Heart disease by ST_Slope
SELECT ST_Slope, 
       SUM(HeartDisease) AS disease_count,
       COUNT(*) AS total,
       ROUND(SUM(HeartDisease)*100.0/COUNT(*), 2) AS pct
FROM heart_data
GROUP BY ST_Slope;

-- Heart disease by Fasting Blood Sugar
SELECT FastingBS,
       COUNT(*) AS total,
       SUM(HeartDisease) AS disease_count
FROM heart_data
GROUP BY FastingBS;

-- Age group bucketing
SELECT 
  CASE 
    WHEN Age < 40 THEN 'Under 40'
    WHEN Age BETWEEN 40 AND 50 THEN '40-50'
    WHEN Age BETWEEN 51 AND 60 THEN '51-60'
    ELSE 'Above 60'
  END AS age_group,
  COUNT(*) AS total,
  SUM(HeartDisease) AS disease_count
FROM heart_data
GROUP BY age_group
ORDER BY age_group;

-- Avg cholesterol, BP, MaxHR by disease status
SELECT HeartDisease,
       ROUND(AVG(Cholesterol), 2) AS avg_cholesterol,
       ROUND(AVG(RestingBP), 2) AS avg_bp,
       ROUND(AVG(MaxHR), 2) AS avg_maxhr,
       ROUND(AVG(Oldpeak), 2) AS avg_oldpeak
FROM heart_data
GROUP BY HeartDisease;

-- High risk patients (high BP + high cholesterol + disease)
SELECT * FROM heart_data
WHERE RestingBP > 140 
  AND Cholesterol > 240 
  AND HeartDisease = 1;
  
  -- Exercise angina vs heart disease
SELECT ExerciseAngina,
       COUNT(*) AS total,
       SUM(HeartDisease) AS disease_count,
       ROUND(SUM(HeartDisease)*100.0/COUNT(*), 2) AS disease_pct
FROM heart_data
GROUP BY ExerciseAngina;

-- Resting ECG distribution
SELECT RestingECG, COUNT(*) AS count
FROM heart_data
GROUP BY RestingECG;

-- ECG type vs heart disease
SELECT RestingECG, 
       SUM(HeartDisease) AS disease_count,
       COUNT(*) AS total
FROM heart_data
GROUP BY RestingECG;

SELECT 
  Age,
  Sex,
  ChestPainType,
  RestingBP,
  Cholesterol,
  FastingBS,
  RestingECG,
  MaxHR,
  ExerciseAngina,
  Oldpeak,
  ST_Slope,
  HeartDisease,
  CASE 
    WHEN Age < 40 THEN 'Under 40'
    WHEN Age BETWEEN 40 AND 50 THEN '40-50'
    WHEN Age BETWEEN 51 AND 60 THEN '51-60'
    ELSE 'Above 60'
  END AS Age_Group,
  CASE 
    WHEN HeartDisease = 1 THEN 'Disease' 
    ELSE 'No Disease' 
  END AS Disease_Label
FROM heart_data;
