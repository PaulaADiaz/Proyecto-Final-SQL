
DROP DATABASE IF EXISTS CafeAlPaso_DiazPaula ; 

CREATE DATABASE CafeAlPaso_DiazPaula ;

-- Usar la base de datos
USE CafeAlPaso_DiazPaula;

-- Creación de tablas

-- USERS
CREATE TABLE USERS (
    USER_ID INT PRIMARY KEY AUTO_INCREMENT,
    FIRST_NAME VARCHAR(60) DEFAULT 'USER_UNKNOW',
    LAST_NAME VARCHAR(60) DEFAULT 'USER_UNKNOW',
    EMAIL VARCHAR(80) UNIQUE NOT NULL,
    PHONE VARCHAR(25) NOT NULL,
    ADDRESS VARCHAR(100),
    BIRTHDAY_DATE DATE,
    SIGN_UP_DATE DATETIME DEFAULT (CURRENT_DATE)
)COMMENT 'Almacena la información de los usuarios';

-- SUBSCRIPTION_PLANS
CREATE TABLE SUBSCRIPTION_PLANS (
    PLAN_ID INT PRIMARY KEY AUTO_INCREMENT,
    PLAN_NAME VARCHAR(50) UNIQUE NOT NULL,
    PRICE DECIMAL(10,2),
    DAILY_LIMIT_TRAD INT, -- NÚMERO DE CONSUMICIONES TRADICIONALES LÍMITE POR DÍA
    DAILY_LIMIT_SPEC INT -- NÚMERO DE CONSUMICIONES ESPECIALES LÍMITE POR DÍA
)COMMENT 'Almacena la información de los diferentes planes de suscripción';

-- SUBSCRIPTION
CREATE TABLE SUBSCRIPTION (
    SUBSCRIPTION_ID INT PRIMARY KEY AUTO_INCREMENT,
    USER_ID INT,
    PLAN_ID INT,
    START_DATE DATE,
    END_DATE DATE,
    STATUS VARCHAR(20), -- ACTIVO/INACTIVO
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
    FOREIGN KEY (PLAN_ID) REFERENCES SUBSCRIPTION_PLANS(PLAN_ID)
)COMMENT 'Almacena la información de las suscrpicones para los usuarios';

-- CAFETERIAS
CREATE TABLE CAFETERIAS (
    CAFETERIA_ID INT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(100) NOT NULL,
    ADDRESS VARCHAR(100) NOT NULL, 
    PHONE VARCHAR(25) NOT NULL,
    EMAIL VARCHAR(100) NOT NULL, -- no es unique porque diferentes sucursales de una misma cadena de cafeterías pueden compartir misma casilla de mail
    OPENING_HOURS VARCHAR(50),
    CLOSING_HOURS VARCHAR(50)
)COMMENT 'Almacena la información de las cafeterias';

-- CONSUMPTIONS
CREATE TABLE CONSUMPTIONS (
    CONSUMPTION_ID INT PRIMARY KEY AUTO_INCREMENT,
    USER_ID INT,
    CAFETERIA_ID INT,
    SUBSCRIPTION_ID INT,
    DATE DATETIME,
    TYPE VARCHAR(15), -- TRADICIONAL/ESPECIAL
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
    FOREIGN KEY (CAFETERIA_ID) REFERENCES CAFETERIAS(CAFETERIA_ID),
    FOREIGN KEY (SUBSCRIPTION_ID) REFERENCES SUBSCRIPTION(SUBSCRIPTION_ID)
)COMMENT 'Almacena información de las consumiciones de los usuarios';

-- PAYMENT_HISTORY
CREATE TABLE PAYMENT_HISTORY (
    PAYMENT_ID INT PRIMARY KEY AUTO_INCREMENT,
    USER_ID INT,
    SUBSCRIPTION_ID INT,
    PAYMENT DECIMAL(10,2),
    PAYMENT_DATE DATETIME,
    PAYMENT_METHOD VARCHAR(30), -- TARJETA/TRANSFERENCIA
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
    FOREIGN KEY (SUBSCRIPTION_ID) REFERENCES SUBSCRIPTION(SUBSCRIPTION_ID)
)COMMENT 'Almacena la información de los pagos de las suscripciones';

-- MENU_ITEMS
CREATE TABLE MENU_ITEMS (
    ITEM_ID INT PRIMARY KEY AUTO_INCREMENT,
    ITEM_NAME VARCHAR(100),
    ITEM_TYPE VARCHAR(15) -- TRADICIONAL/ESPECIAL
)COMMENT 'Almacena la información de los distintos cafés';

-- CAFETERIA_MENU
CREATE TABLE CAFETERIA_MENU (
    CAFETERIA_ID INT,
    ITEM_ID INT,
    PRIMARY KEY (CAFETERIA_ID, ITEM_ID),
    FOREIGN KEY (CAFETERIA_ID) REFERENCES CAFETERIAS(CAFETERIA_ID),
    FOREIGN KEY (ITEM_ID) REFERENCES MENU_ITEMS(ITEM_ID)
)COMMENT 'Almacena la información de la variedad de items por cafetería';

-- PROMOTIONS
CREATE TABLE PROMOTIONS (
    PROMOTION_ID INT PRIMARY KEY AUTO_INCREMENT,
    PROMOTION_NAME VARCHAR(100),
    DISCOUNT DECIMAL(5,2),
    START_DATE DATETIME,
    END_DATE DATETIME,
    APPLICABLE_TO_ALL BOOLEAN,
    USER_ID INT,
    PLAN_ID INT,
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
    FOREIGN KEY (PLAN_ID) REFERENCES SUBSCRIPTION_PLANS(PLAN_ID)
)COMMENT 'Almacena la información de promociones para suscripciones';

-- REVIEWS
CREATE TABLE REVIEWS (
    REVIEW_ID INT PRIMARY KEY AUTO_INCREMENT,
    USER_ID INT,
    CAFETERIA_ID INT,
    RATING INT,
    COMMENT TEXT,
    REVIEW_DATE DATE,
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
    FOREIGN KEY (CAFETERIA_ID) REFERENCES CAFETERIAS(CAFETERIA_ID)
)COMMENT 'Almacena la información de las reseñas de los usuarios en diversas cafeterias';
