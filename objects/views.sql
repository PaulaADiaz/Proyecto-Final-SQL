USE CafeAlPaso_DiazPaula;

-- Vista para el consumo de cafe de los usuarios
-- Esta vista muestra el consumo total de cafe por usuario y el plan que tiene
CREATE VIEW USER_CONSUMPTION_SUMMARY_VW AS
SELECT
    u.USER_ID,
    CONCAT(u.FIRST_NAME, ' ', u.LAST_NAME) AS USER_NAME,
    COUNT(c.CONSUMPTION_ID) AS TOTAL_CONSUMPTIONS,
    sp.PLAN_NAME AS SUBSCRIPTION_PLAN
FROM USERS u
LEFT JOIN CONSUMPTIONS c ON u.USER_ID = c.USER_ID
LEFT JOIN SUBSCRIPTION s ON u.USER_ID = s.USER_ID
LEFT JOIN SUBSCRIPTION_PLANS sp ON s.PLAN_ID = sp.PLAN_ID
GROUP BY u.USER_ID, u.FIRST_NAME, u.LAST_NAME, sp.PLAN_NAME;

-- Vista para las promociones vigentes
-- Esta vista muestra las promociones vigentes
CREATE VIEW ACTIVE_PROMOTIONS_VW AS
SELECT
    p.PROMOTION_NAME,
    p.DISCOUNT,
    p.START_DATE,
    p.END_DATE,
    p.APPLICABLE_TO_ALL,
    p.USER_ID,
    p.PLAN_ID
FROM PROMOTIONS p
WHERE p.START_DATE <= NOW() AND p.END_DATE >= NOW();

-- Vista para el ranking de las cafeterias segun reseñas
-- Esta vista muestra la calificacion promedio y el numero de reseñas por cafeteria
CREATE VIEW CAFETERIA_REVIEWS_VW AS
SELECT
    r.CAFETERIA_ID,
    caf.NAME,
    COUNT(r.REVIEW_ID) AS REVIEW_COUNT,
    AVG(r.RATING) AS AVERAGE_RATING
FROM REVIEWS r
JOIN CAFETERIAS caf ON r.CAFETERIA_ID = caf.CAFETERIA_ID
GROUP BY r.CAFETERIA_ID;

-- Vista para el menu de cafe por cafeteria
-- Esta vista muestra los tipos de cafe que ofrece cada cafeteria
CREATE VIEW CAFETERIA_MENU_ITEMS_VW AS
SELECT
    caf.CAFETERIA_ID,
    caf.NAME,
    mi.ITEM_ID,
    mi.ITEM_NAME,
    mi.ITEM_TYPE
FROM CAFETERIAS caf
JOIN CAFETERIA_MENU cm ON caf.CAFETERIA_ID = cm.CAFETERIA_ID
JOIN MENU_ITEMS mi ON cm.ITEM_ID = mi.ITEM_ID;
