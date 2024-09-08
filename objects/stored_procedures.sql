-- Procedimiento 1: obtiene estadisticas de consumo de cafe en una cafeteria especifica dentro de un rango de fechas seleccionado.

DELIMITER //

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
    FROM CONSUMPTIONS
    WHERE CAFETERIA_ID = cafId
      AND DATE BETWEEN startDate AND endDate;

    -- Calcular el promedio diario de consumiciones
    SELECT IFNULL(
        (SELECT COUNT(*) / DATEDIFF(endDate, startDate) + 1
         FROM CONSUMPTIONS
         WHERE CAFETERIA_ID = cafId
           AND DATE BETWEEN startDate AND endDate), 0
    ) INTO avgDailyConsumptions;

    -- Devolver los resultados
    SELECT totalConsumptions, avgDailyConsumptions;
END //
DELIMITER ;


-- Procedimiento 2: proporciona un resumen de consumiciones por tipo de cafe dentro de un rango de fechas dado.

DELIMITER //

CREATE PROCEDURE GetCoffeeTypeConsumptionSummary(
    IN startDate DATE,
    IN endDate DATE
)
BEGIN
    SELECT 
        TYPE, 
        COUNT(*) AS Total_Consumptions
    FROM CONSUMPTIONS
    WHERE DATE BETWEEN startDate AND endDate
    GROUP BY TYPE;
END //
DELIMITER ;
