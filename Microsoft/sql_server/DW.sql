CREATE DATABASE COVID_DW

USE COVID_DW;
GO

-- =========================================================
-- DIMENSION 1: TIEMPO
-- =========================================================
CREATE TABLE DimTiempo (
    FechaKey        INT PRIMARY KEY,        -- formato yyyymmdd
    Fecha           DATE NOT NULL,
    Anio            INT NOT NULL,
    Mes             INT NOT NULL,
    Dia             INT NOT NULL,
    NombreMes       NVARCHAR(20),
    Trimestre       INT,
    SemanaAnio      INT,
    NombreDiaSemana NVARCHAR(20)
);
GO

-- =========================================================
-- DIMENSION 2: PAIS (identidad geografica, no cambia con el tiempo)
-- =========================================================
CREATE TABLE DimPais (
    PaisKey     INT IDENTITY PRIMARY KEY,
    NombrePais  NVARCHAR(200) NOT NULL,
    CodigoPais   NVARCHAR(10)  NULL,
    Region      NVARCHAR(100) NULL,   -- 'Centroamerica', 'Sudamerica', 'Caribe'
    UNIQUE (CodigoPais)
);
GO

-- =========================================================
-- DIMENSION 3: INDICADOR SOCIOECONOMICO ANUAL
-- Grano: un registro por Pais + Año (estos valores de OWID
-- se actualizan una vez al año, no varian dia a dia).
-- Se denormaliza el nombre del pais aqui (sin FK a DimPais)
-- para mantener el modelo como estrella clasica, sin copos de nieve.
-- =========================================================
CREATE TABLE DimIndicadorAnual (
    IndicadorAnualKey     INT IDENTITY PRIMARY KEY,
    NombrePais            NVARCHAR(200) NOT NULL,
    Anio                  INT NOT NULL,
    Poblacion             BIGINT NULL,
    PibPerCapita          FLOAT NULL,
    PrevalenciaDiabetes    FLOAT NULL,
    ExtremaPobreza        FLOAT NULL,
    TasaMuerteCardiovasculares   FLOAT NULL,
    FacilidadesLavadoManos FLOAT NULL,
    UNIQUE (NombrePais, Anio)
);
GO

-- =========================================================
-- TABLA DE HECHOS (grano: Fecha + Pais)
-- =========================================================
CREATE TABLE FactCovidDiario (
    FactKey             BIGINT IDENTITY PRIMARY KEY,
    FechaKey            INT NOT NULL REFERENCES DimTiempo(FechaKey),
    PaisKey             INT NOT NULL REFERENCES DimPais(PaisKey),
    IndicadorAnualKey   INT NOT NULL REFERENCES DimIndicadorAnual(IndicadorAnualKey),
    CasosConfirmados    INT NULL,
    Muertes             INT NULL,
    Recuperados         INT NULL,
    Activos             INT NULL,
    TasaIncidentes        FLOAT NULL,
    TasaFatalidad   FLOAT NULL,
    CasosNuevos         INT NULL,   -- calculado en el ETL con LAG()
    MuertesNuevas       INT NULL,   -- calculado en el ETL con LAG()
    UNIQUE (FechaKey, PaisKey)
);
GO

PRINT 'Modelo estrella clasico creado: 3 dimensiones + 1 tabla de hechos.';