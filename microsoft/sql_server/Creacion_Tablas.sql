USE COVID_Staging;
GO

-- Crea el schema si no existe
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'stg')
    EXEC('CREATE SCHEMA stg');
GO
 
-- Crea la tabla de staging (todo como texto, se limpia despues)
IF OBJECT_ID('stg.DailyReports_Raw', 'U') IS NOT NULL
    DROP TABLE stg.DailyReports_Raw;
GO
 
CREATE TABLE stg.DailyReports_Raw (
    FIPS                 NVARCHAR(20)  NULL,
    Admin2               NVARCHAR(200) NULL,
    Province_State       NVARCHAR(200) NULL,
    Country_Region       NVARCHAR(200) NULL,
    Last_Update          NVARCHAR(50)  NULL,
    Lat                  NVARCHAR(50)  NULL,
    Long_                NVARCHAR(50)  NULL,
    Confirmed            NVARCHAR(50)  NULL,
    Deaths               NVARCHAR(50)  NULL,
    Recovered            NVARCHAR(50)  NULL,
    Active               NVARCHAR(50)  NULL,
    Combined_Key         NVARCHAR(300) NULL,
    Incident_Rate        NVARCHAR(50)  NULL,
    Case_Fatality_Ratio  NVARCHAR(50)  NULL,
    NombreArchivoOrigen  NVARCHAR(300) NULL,
    FechaCarga           DATETIME2     DEFAULT SYSDATETIME()
);
GO
 
PRINT 'Tabla stg.DailyReports_Raw creada correctamente.';

-- DataHub_Indicadores
 
CREATE TABLE stg.DataHub_Indicadores_Raw (
    Fecha                  NVARCHAR(20)  NULL,  -- viene como YYYY-MM-DD
    Pais                   NVARCHAR(200) NULL,  -- administrative_area_level_1
    IsoAlpha3              NVARCHAR(10)  NULL,
    Poblacion              NVARCHAR(50)  NULL,
    DiabetesPrevalence     NVARCHAR(50)  NULL,
    ExtremePoverty         NVARCHAR(50)  NULL,
    CardiovascDeathRate    NVARCHAR(50)  NULL,
    HandwashingFacilities  NVARCHAR(50)  NULL,
    GdpPerCapita           NVARCHAR(50)  NULL,
    NombreArchivoOrigen    NVARCHAR(300) NULL,
    FechaCarga             DATETIME2     DEFAULT SYSDATETIME()
);
GO
 
PRINT 'Tabla stg.DataHub_Indicadores_Raw creada correctamente.';