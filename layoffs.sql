SELECT * FROM layoffs;

-- 1.Remove duplicates
-- 2.Standardize the data
-- 3.Null values or blank values
-- 4.Remove any columns

create table layoffs_staging like layoffs;