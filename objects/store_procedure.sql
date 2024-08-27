USE CafeAlPaso_DiazPaula; 

-- Procedimiento 1: obtiene estadísticas de consumo de café en una cafetería específica dentro de un rango de fechas seleccionado.

CREATE PROCEDURE GetCafeteriaConsumptionStats(
    IN cafId INT,
    IN startDate DATE,
    IN endDate DATE
)
BEGIN
    DECLARE totalConsumptions INT;
    DECLARE avgDailyConsumptions DECIMAL(10,4);

    -- Calcular el total de consumiciones
    SELECT COUNT(*) INTO totalConsumptions
    FROM Consumptions
    WHERE CAFETERIA_ID = cafId
      AND DATE BETWEEN startDate AND endDate;

    -- Calcular el promedio diario de consumiciones
    SELECT IFNULL(
        (SELECT COUNT(*) / DATEDIFF(endDate, startDate) + 1
         FROM Consumptions
         WHERE CAFETERIA_ID = cafId
           AND DATE BETWEEN startDate AND endDate), 0
    ) INTO avgDailyConsumptions;

    -- Devolver los resultados
    SELECT totalConsumptions, avgDailyConsumptions;
END;


-- Procedimiento 2: proporciona un resumen de consumiciones por tipo de café dentro de un rango de fechas dado.

CREATE PROCEDURE GetCoffeeTypeConsumptionSummary(
    IN startDate DATE,
    IN endDate DATE
)
BEGIN
    SELECT 
        TYPE, 
        COUNT(*) AS Total_Consumptions
    FROM Consumptions
    WHERE DATE BETWEEN startDate AND endDate
    GROUP BY TYPE;
END;
