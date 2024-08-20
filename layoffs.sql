SELECT * FROM layoffs;

-- creating a db to work on so that we do not interfer with our main database
create table layoffs_staging like layoffs;
insert into layoffs_staging 
select * from layoffs;

-- 1.Remove duplicates

with duplicated as
 (select *,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,'date',stage,funds_raised_millions) as RN
from layoffs_staging)
select * from duplicated 
where RN > 1;

-- confirm if they are duplicates
select * 
from layoffs_staging
where company = "Cazoo";

-- 2.Standardize the data
-- 3.Null values or blank values
-- 4.Remove any columns

