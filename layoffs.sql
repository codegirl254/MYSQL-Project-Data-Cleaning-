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
--  2.1 Remove the white spaces in the company column using the trim() function
select distinct company ,trim(company)
from layoffs_staging;
set sql_safe_updates =0;
update layoffs_staging 
set company = trim(company);

-- 2.2 standardizing the industry column
select distinct industry
from layoffs_staging order by industry;

select *
from layoffs_staging
where industry like "crypto%";

-- updating cryptocurrency to crypto
update layoffs_staging set industry = "Crypto" where industry like "crypto%";


-- 2.3 standardizing the location column
select * from layoffs_staging;
select distinct location 
from layoffs_staging order by 1;

-- 2.4 standardizing the date  column
select 'date',
str_to_date( 'date' , '%m/%d/%Y')
 from layoffs_staging;


-- 3.Null values or blank values
-- 4.Remove any columns

