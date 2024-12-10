/*
Select location, date, total_cases, total_deaths,
(total_deaths/total_cases) * 100 As DeathPercentage
From covid.covid_deaths as d
Where location like '%states%'
and continent is not null
*/

-- Pecentage of population that got Covid
/*
Select location, date, total_cases, population, (total_cases/population) * 100 as PercentOfPopulationInfected
From covid.covid_deaths
WHERE location like '%states%'
and continent is not null
*/

-- Countries with higest infection rate compared to population
/*
Select location, population, 
MAX(total_cases) as HigestInfectionCount, 
MAX(total_cases/population) * 100 as MAX_PercentOfPopulationInfected 
From covid.covid_deaths
where continent is not null
Group by location, population
order by MAX_PercentOfPopulationInfected desc
*/

/*
-- Countries with highest death count per population
SELECT location, MAX(CAST(COALESCE(total_deaths, 0) AS UNSIGNED)) AS TotalDeathCount 
From covid.covid_deaths 
where continent is not null
Group by location
order by TotaLDeathCount desc
*/

-- Showing continents with highest death counts 
/*SELECT continent, MAX(CAST(COALESCE(total_deaths, 0) AS UNSIGNED)) AS TotalDeathCount 
From covid.covid_deaths 
where continent is not null
Group by continent
order by TotaLDeathCount desc
*/

-- Global numbers
/*SELECT date, SUM(new_cases) as total_cases, SUM(CAST(COALESCE(new_deaths, 0) AS UNSIGNED)) as total_deaths,
SUM(CAST(COALESCE(new_deaths, '0') AS UNSIGNED))/SUM(CAST(COALESCE(new_cases, 0) AS UNSIGNED))*100 AS DeathPercentage
From covid.covid_deaths
Where continent is not null
GROUP BY date
order by 1,2
*/


-- Looking at Total Population vs Vaccinations
/*SELECT d.continent, d.location, Cast(d.date as date), d.population,
v.new_vaccinations,
SUM(CAST(COALESCE(v.new_vaccinations, 0) AS UNSIGNED)) OVER (Partition by d.location order by d.date, d.location) as RollingPeopleVaccinated,
FROM covid.covid_deaths as d
JOIN covid.covid_vaccinations as v
	ON d.location = v.location
    and v.date = d.date
	
WHERE d.continent is not null
order by d.location, d.date
*/

-- CTE
/*
WITH PopVsVaccination AS (
    SELECT 
        d.continent, 
        d.location, 
        CAST(d.date AS DATE) AS date, 
        d.population,
        v.new_vaccinations,
        SUM(COALESCE(v.new_vaccinations, 0)) OVER (PARTITION BY d.location ORDER BY d.date) AS RollingPeopleVaccinated
    FROM 
        covid.covid_deaths AS d
    JOIN 
        covid.covid_vaccinations AS v
        ON d.location = v.location
        AND v.date = d.date
    WHERE 
        d.continent IS NOT NULL
)
SELECT 
    continent, 
    location, 
    date, 
    population, 
    RollingPeopleVaccinated, 
    (RollingPeopleVaccinated / population) * 100 AS Rolling_percentage
FROM 
    PopVsVaccination
ORDER BY 
    location, date;
*/


-- TEMP TABLE
/*
DROP TABLE IF EXISTS PercentPopulationVaccinated;
CREATE TEMPORARY TABLE PercentPopulationVaccinated
(
    continent VARCHAR(255),
    location VARCHAR(255),
    date DATETIME,
    population NUMERIC,
    new_vaccinations NUMERIC,
    RollingPeopleVaccinated NUMERIC
);

INSERT INTO PercentPopulationVaccinated 
SELECT 
    d.continent, 
    d.location, 
    d.date, 
    d.population,
    v.new_vaccinations,
    SUM(COALESCE(v.new_vaccinations, 0)) OVER (PARTITION BY d.location ORDER BY d.date) AS RollingPeopleVaccinated
FROM 
    covid.covid_vaccinations AS v
INNER JOIN
    covid.covid_deaths AS d
    ON v.date = d.date
    AND v.location = d.location
WHERE 
    d.continent IS NOT NULL
ORDER BY 
    d.location, d.date;

SELECT * FROM PercentPopulationVaccinated;
*/

-- Create View 
/*Create or Replace View TotalDeathCount_ByContinent as
SELECT continent, MAX(CAST(COALESCE(total_deaths, 0) AS UNSIGNED)) AS TotalDeathCount 
From covid.covid_deaths 
where continent is not null
Group by continent
order by TotaLDeathCount desc
*/

-- FOR TABLEAU
-- 1.

/*Select SUM(new_cases) as total_cases, SUM(COALESCE(new_deaths, 0)) as total_deaths, 
SUM(COALESCE(new_deaths, 0))/SUM(new_cases)*100 as DeathPercentage
From covid.covid_deaths
where continent is not null 
order by 1,2
*/

-- 2.
/*
Select location, SUM(coalesce(new_deaths, 0 )) as TotalDeathCount
From covid.covid_deaths
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc
*/


-- 3. 

/*
Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From covid.covid_deaths
Group by Location, Population
order by PercentPopulationInfected desc
*/

-- 4.
Select location, 
coalesce(population, 0) as population,
cast(date as date), 
MAX(coalesce(total_cases, 0)) as HighestInfectionCount,
Max(coalesce(total_cases, 0) / coalesce(population, 0)) *100 as PercentPopulationInfected
From covid.covid_deaths
Group by location, population, date


