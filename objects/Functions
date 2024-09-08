-- Función 1: cuenta las consumiciones por usuario.

DELIMITER //

CREATE FUNCTION TotalConsumptions(userId INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM CONSUMPTIONS
    WHERE USER_ID = userId;
    RETURN total;
END//
DELIMITER ;


-- Función 2: calcula el promedio de puntuaciones de una cafetería.

DELIMITER //
CREATE FUNCTION AverageRating(cafeteriaId INT)
RETURNS DECIMAL(3,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE avgRating DECIMAL(3,2);
    SELECT AVG(RATING) INTO avgRating
    FROM REVIEWS
    WHERE CAFETERIA_ID = cafeteriaId;
    RETURN avgRating;
END//
DELIMITER ;


-- Función 3: calcula la suma de pagos por método de pago.

DELIMITER //
CREATE FUNCTION CalculateTotalPaymentsByMethod(method VARCHAR(30))
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE totalPayments DECIMAL(10,2);
    
    -- Calcular la suma total de pagos para el método especificado
    SELECT 
        COALESCE(SUM(PAYMENT), 0) INTO totalPayments
    FROM 
        PAYMENT_HISTORY
    WHERE 
        PAYMENT_METHOD = method;

    RETURN totalPayments;
END//
DELIMITER ;
