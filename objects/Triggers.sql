-- Trigger 1: Verifica si el tipo de cafe que se intenta crear ya existe en el menu de la cafeterias antes de permitir la insercion

DELIMITER //

CREATE TABLE TriggerLogs (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    LogDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Message TEXT);

CREATE TRIGGER BeforeCoffeeTypeInsert
BEFORE INSERT ON CAFETERIA_MENU
FOR EACH ROW
BEGIN
    DECLARE coffeeTypeExists INT;
    DECLARE coffeeTypeName VARCHAR(255);
    
    SELECT ITEM_NAME INTO coffeeTypeName
    FROM MENU_ITEMS
    WHERE ITEM_ID = NEW.ITEM_ID; -- Obtiene el nombre del tipo de cafe que se intenta insertar
    
    SELECT COUNT(*) INTO coffeeTypeExists
    FROM CAFETERIA_MENU cm
    JOIN MENU_ITEMS mi ON cm.ITEM_ID = mi.ITEM_ID
    WHERE cm.CAFETERIA_ID = NEW.CAFETERIA_ID
      AND mi.ITEM_NAME = coffeeTypeName; -- Verifica si el tipo de cafe ya existe en la cafeteria

    IF coffeeTypeExists > 0 THEN
        INSERT INTO TriggerLogs (Message) 
        VALUES (CONCAT('Intento de insertar el tipo de cafe "', coffeeTypeName, '" que ya existe en el menu de la cafeteria con ID ', NEW.CAFETERIA_ID, '.')); -- Si ya existe, se registra en la tabla de logs y lanza un error

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El tipo de cafe ya existe en el menu de la cafeteria.'; -- Lanza el error con un mensaje fijo
    END IF;
END //
DELIMITER ;

-- Ejemplo de uso

INSERT INTO CAFETERIA_MENU (CAFETERIA_ID, ITEM_ID)
VALUES (1, 1);  

-- Trigger 2: Verifica el limite de consumos diarios para el usuario segun el plan de suscripcion

DELIMITER //

CREATE TABLE LogTable (
    LOG_ID INT AUTO_INCREMENT PRIMARY KEY,
    MESSAGE TEXT,
    LOG_DATE DATETIME);

CREATE TRIGGER AfterConsumptionInsert
AFTER INSERT ON CONSUMPTIONS
FOR EACH ROW
BEGIN
    DECLARE dailyLimitTrad INT DEFAULT 0;
    DECLARE dailyLimitSpec INT DEFAULT 0;
    DECLARE consumptionCountTrad INT DEFAULT 0;
    DECLARE consumptionCountSpec INT DEFAULT 0;
   
    SELECT sp.DAILY_LIMIT_TRAD, sp.DAILY_LIMIT_SPEC
    INTO dailyLimitTrad, dailyLimitSpec
    FROM USERS u
    JOIN USER_SUBSCRIPTIONS us ON u.USER_ID = us.USER_ID
    JOIN SUBSCRIPTION_PLANS sp ON us.PLAN_ID = sp.PLAN_ID
    WHERE u.USER_ID = NEW.USER_ID;

    SELECT COUNT(*) INTO consumptionCountTrad -- cuenta consumiciones tradicionales
    FROM CONSUMPTIONS
    WHERE USER_ID = NEW.USER_ID
      AND DATE(NEW.DATE) = DATE(DATE)
      AND TYPE = 'tradicional';

    SELECT COUNT(*) INTO consumptionCountSpec -- cuenta consumiciones especiales
    FROM CONSUMPTIONS
    WHERE USER_ID = NEW.USER_ID
      AND DATE(NEW.DATE) = DATE(DATE)
      AND TYPE = 'especial';

    IF consumptionCountTrad > dailyLimitTrad THEN
        INSERT INTO LogTable (MESSAGE, LOG_DATE)
        VALUES (CONCAT('Limite diario de consumiciones tradicionales alcanzado para el usuario ', NEW.USER_ID, ' en la fecha ', NEW.DATE), NOW());
    END IF; -- Verifica si supera el limite de consumiciones tradicionales

    IF consumptionCountSpec > dailyLimitSpec THEN
        INSERT INTO LogTable (MESSAGE, LOG_DATE)
        VALUES (CONCAT('Limite diario de consumiciones especiales alcanzado para el usuario ', NEW.USER_ID, ' en la fecha ', NEW.DATE), NOW());
    END IF; -- Verifica si supera el limite de consumiciones especiales

END //
DELIMITER ;


-- Ejemplo de uso


INSERT INTO CONSUMPTIONS (USER_ID, CAFETERIA_ID, SUBSCRIPTION_ID, DATE, TYPE)
VALUES (25, 3, 10, '2024-07-31', 'especial');
