/*
Covid 19 Data Exploration 
Skills used: Joins, Aggregate Functions,Converting Data Types
*/


-- Chances of contracting covid

USE project_portfolio;

SELECT location,
	   sum(total_cases),
	   sum(population),
       sum(total_cases)/sum(population)*100 as covid_percentage
FROM   coviddeaths
WHERE  location like '%india%'
GROUP BY location;

-- Chances of death if you contract covid

SELECT location,
	   sum(total_cases),
	   sum(total_deaths),
       sum(total_deaths)/sum(total_cases)*100 as death_percentage
FROM   coviddeaths
WHERE  location like '%india%' 
GROUP BY location;

-- countries with the highest infection rate

SELECT location,
       population,
       max(total_cases) as total_cases,
       max(total_cases/population*100) as infection_rate
FROM   coviddeaths
GROUP BY location,population
ORDER BY infection_rate desc
limit 5;

-- countires with the highest deaths

SELECT location,
	   sum(CAST(total_deaths AS UNSIGNED)) AS total_deaths
FROM   coviddeaths
GROUP BY location
ORDER BY total_deaths desc
LIMIT 5;

-- total populaton vs vaccination

SELECT cd.location,
       sum(cd.population) as population,
       sum(cast(cv.total_vaccinations as unsigned)) as vacciations,
       sum(cv.total_vaccinations/cd.population*100) as vaccination_rate
FROM coviddeaths cd
JOIN covidvaccinations cv
on cd.location = cv.location
where cd.location like '%india%'
GROUP BY cd.location;

