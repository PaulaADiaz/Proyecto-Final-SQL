CREATE ROLE admin;
CREATE ROLE marketing;
CREATE ROLE finanzas;

GRANT ALL PRIVILEGES ON `Cafealpaso_diazpaula`.* TO 'admin';

-- Permisos sobre tablas
GRANT SELECT, INSERT, UPDATE, DELETE ON `Cafealpaso_diazpaula`.`SUBSCRIPTION` TO 'marketing';
GRANT SELECT, INSERT, UPDATE, DELETE ON `Cafealpaso_diazpaula`.`SUBSCRIPTION_PLANS` TO 'marketing';
GRANT SELECT, INSERT, UPDATE, DELETE ON `Cafealpaso_diazpaula`.`REVIEWS` TO 'marketing';
GRANT SELECT, INSERT, UPDATE, DELETE ON `Cafealpaso_diazpaula`.`PROMOTIONS` TO 'marketing';
GRANT SELECT, INSERT, UPDATE, DELETE ON `Cafealpaso_diazpaula`.`CAFETERIA_MENU` TO 'marketing';
GRANT SELECT, INSERT, UPDATE, DELETE ON `Cafealpaso_diazpaula`.`MENU_ITEMS` TO 'marketing';

-- Permisos sobre vistas
GRANT SELECT ON `Cafealpaso_diazpaula`.`USER_CONSUMPTION_SUMMARY_VW` TO 'marketing';
GRANT SELECT ON `Cafealpaso_diazpaula`.`ACTIVE_PROMOTIONS_VW` TO 'marketing';
GRANT SELECT ON `Cafealpaso_diazpaula`.`CAFETERIA_REVIEWS_VW` TO 'marketing';
GRANT SELECT ON `Cafealpaso_diazpaula`.`CAFETERIA_MENU_ITEMS_VW` TO 'marketing';

-- Permisos sobre funciones
GRANT EXECUTE ON FUNCTION `Cafealpaso_diazpaula`.`TotalConsumptions` TO 'marketing';
GRANT EXECUTE ON FUNCTION `Cafealpaso_diazpaula`.`AverageRating` TO 'marketing';
GRANT EXECUTE ON FUNCTION `Cafealpaso_diazpaula`.`CalculateTotalPaymentsByMethod` TO 'marketing';

-- Permisos sobre procedimientos almacenados
GRANT EXECUTE ON PROCEDURE `Cafealpaso_diazpaula`.`GetCoffeeTypeConsumptionSummary` TO 'marketing';

-- Permisos sobre tablas
GRANT SELECT, INSERT, UPDATE, DELETE ON `Cafealpaso_diazpaula`.`PAYMENT_HISTORY` TO 'finanzas';
GRANT SELECT, INSERT, UPDATE, DELETE ON `Cafealpaso_diazpaula`.`SUBSCRIPTION` TO 'finanzas';
GRANT SELECT, INSERT, UPDATE, DELETE ON `Cafealpaso_diazpaula`.`SUBSCRIPTION_PLANS` TO 'finanzas';

-- Permisos sobre vistas
GRANT SELECT ON `Cafealpaso_diazpaula`.`USER_CONSUMPTION_SUMMARY_VW` TO 'finanzas';

-- Permisos sobre funciones
GRANT EXECUTE ON FUNCTION `Cafealpaso_diazpaula`.`CalculateTotalPaymentsByMethod` TO 'finanzas';

-- Permisos sobre procedimientos almacenados
GRANT EXECUTE ON PROCEDURE `Cafealpaso_diazpaula`.`GetCafeteriaConsumptionStats` TO 'finanzas';
GRANT EXECUTE ON PROCEDURE `Cafealpaso_diazpaula`.`GetCoffeeTypeConsumptionSummary` TO 'finanzas';

CREATE USER 'admin_user'@'%' IDENTIFIED BY 'password_admin';
GRANT admin TO 'admin_user'@'%';

CREATE USER 'marketing_user'@'%' IDENTIFIED BY 'password_marketing';
GRANT marketing TO 'marketing_user'@'%';

CREATE USER 'finanzas_user'@'%' IDENTIFIED BY 'password_finanzas';
GRANT finanzas TO 'finanzas_user'@'%';

FLUSH PRIVILEGES;

SHOW GRANTS FOR 'admin_user'@'%';
SHOW GRANTS FOR 'marketing_user'@'%';
SHOW GRANTS FOR 'finanzas_user'@'%';

ALTER USER 'finanzas_user'@'%' 
IDENTIFIED BY 'password_finanzas' 
FAILED_LOGIN_ATTEMPTS 3 
PASSWORD_LOCK_TIME 1;
