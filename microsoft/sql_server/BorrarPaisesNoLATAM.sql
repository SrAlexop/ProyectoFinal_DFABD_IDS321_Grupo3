USE COVID_Staging;
GO

-- 1. Ve cuantas filas SI se van a conservar (deberian ser las de tus 20 paises)
SELECT Country_Region, COUNT(*) AS TotalFilas
FROM stg.DailyReports_Raw
WHERE Country_Region IN (
    'Argentina','Bolivia','Brazil','Chile','Colombia','Costa Rica','Cuba',
    'Dominican Republic','Ecuador','El Salvador','Guatemala','Haiti',
    'Honduras','Mexico','Nicaragua','Panama','Paraguay','Peru','Uruguay','Venezuela'
)
GROUP BY Country_Region
ORDER BY Country_Region;

-- 2. Ve que otros nombres de pais existen que NO coincidieron
--    (por si algun pais viene escrito distinto, ej. "US" vs "United States")
SELECT DISTINCT Country_Region
FROM stg.DailyReports_Raw
WHERE Country_Region NOT IN (
    'Argentina','Bolivia','Brazil','Chile','Colombia','Costa Rica','Cuba',
    'Dominican Republic','Ecuador','El Salvador','Guatemala','Haiti',
    'Honduras','Mexico','Nicaragua','Panama','Paraguay','Peru','Uruguay','Venezuela'
)
ORDER BY Country_Region;


DELETE FROM stg.DailyReports_Raw
WHERE Country_Region NOT IN (
    'Argentina','Bolivia','Brazil','Chile','Colombia','Costa Rica','Cuba',
    'Dominican Republic','Ecuador','El Salvador','Guatemala','Haiti',
    'Honduras','Mexico','Nicaragua','Panama','Paraguay','Peru','Uruguay','Venezuela'
);
