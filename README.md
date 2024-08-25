# <center>Entrega de Proyecto Final SQL</center>

### Creación de una base de datos para una aplicación de café al paso

Paula Andrea Diaz

Comisión: 57190

Tutor: Ariel Annone

Docente: Anderson Torres

---

## Temática del proyecto

"CoffeeToGo" es una aplicación diseñada para ofrecer suscripciones mensuales que permiten a los usuarios retirar cafés en cualquiera de las cafeterías asociadas en Argentina. Los usuarios podrán seleccionar entre varios planes de suscripción que varían en precio y beneficios, mientras que las cafeterías asociadas se benefician de una base de clientes recurrentes y un mayor alcance de su clientela. La aplicación busca promover la comodidad y el acceso fácil a cafés de calidad para sus usuarios y apoyar a las cafeterías locales en la expansión de su mercado. A partir de lo anterior mencionado nace la necesidad de diseñar una base de datos eficiente que pueda manejar todas las operaciones relacionadas con los usuarios, las cafeterías, las suscripciones y  los consumos de manera óptima.

## Propuesta de Valor

**Para los Usuarios:**

Acceso conveniente y económico a una variedad de cafés en múltiples ubicaciones.
Flexibilidad para elegir entre diferentes planes de suscripción según sus necesidades y preferencias.
Beneficios adicionales como promociones en cafeterías asociadas.

**Para las Cafeterías:** 

Aumento en la base de clientes y en la fidelización a través de la suscripción recurrente.
Incremento de ingresos mediante la participación en la plataforma.
Oportunidad de promover promociones exclusivas a través de la aplicación.

## Planes de Suscripción

* **Básico:** $30,000 mensuales. Una consumición tradicional por día.
* **Bronze:** $50,000 mensuales. Dos consumiciones tradicionales por día.
* **Silver:** $70,000 mensuales. Dos consumiciones tradicionales o una consumición especial por día.
* **Gold:** $100,000 mensuales. Consumiciones tradicionales ilimitadas y una consumición especial por día.
* **Diamond:** $130,000 mensuales. Consumiciones tradicionales y especiales ilimitadas por día.


## Diagrama entidad relación (DER)


```
     +--------------------+                            +----------------+      +----------------+
     |  PAYMENT_HISTORY   |                            | CAFETERIA_MENU |      |   MENU_ITEMS   |
     +--------------------|                            +----------------+      +----------------+
     | PAYMENT_ID PK      |                   |------->| CAFETERIA_ID FK|  |---| ITEM_ID PK     |
     | USER_ID FK         |<--|               |        | ITEM_ID  FK    |<-|   | ITEM_NAME      |
     | SUBSCRIPTION_ID FK |<--|               |        +----------------+      | ITEM_TYPE      |
     | AMOUNT             |   |               |                                | PRICE          |
     | PAYMENT_DATE       |   |               |                                +----------------+
     | PAYMENT_METHOD     |   |               |            
     +--------------------+   |               |            
                          |---|               |            
+-------------------+     | +-------------+   |   +-----------------+          +---------------------+      
|   SUBSCRIPTIONS   |     | |    USERS    |   |   |  CAFETERIAS     |          |        REVIEWS      |
+-------------------+     | +-------------+   |   +-----------------+          +---------------------+
| SUBSCRIPTION_ID PK|--|----| USER_ID  PK |-| |---| CEFETERIA_ID PK |----|     | REVIEW_ID PK        | 
| USER_ID   FK      |<-|    | FIRST_NAME  | |     | NAME            |    |---->| CAFETERIA_ID FK     |
| PLAN_ID   FK      |<--|   | LAST_NAME   | |     | ADDRESS         |    |  |->| USER_ID FK          |
| START_DATE        |   |   | EMAIL       | |     | PHONE           |    |  |  | RATING              |
| END_DATE          |   |   | PHONE       | |     | EMAIL           |    |  |  | COMMENT             | 
| STATUS            |   |   | ADDRESS     | |     | OPENING_HOURS   |    |  |  | REVIEW_DATE         |
+-------------------+   |   | PAYMENT_INFO| |     +-----------------+    |  |  +---------------------+
           |            |   +-------------+ |-------------------------------|
           |            |                   |------------|               | 
           |            |                                |               |
           |            |                                |               |  
+---------------------+ |     +-------------------+      |               |  
| SUBSCRIPTION_PLANS  | |     | CONSUMPTIONS      |      |               |  
+---------------------+ |     +-------------------+      |               |  
| PLAN_ID PK          |--     | CONSUMPTIONS_ID PK|      |               |  
| PLAN_NAME           | |     | USER_ID FK        |<-----|               | 
| PRICE               | |     | CAFETERIA_ID FK   |<---------------------|  
| DAILY_LIMIT_TRAD    |------>| SUBSCRIPTION_ID FK|      |    
| DAILY_LIMIT_SPEC    | |     | DATE              |      |     
+---------------------+ |     | TYPE              |      |                                 
                        |     +-------------------+      |                                 
                        |                                |                            
+--------------------+  |                                |
|     PROMOTIONS     |  |                                |
+--------------------+  |                                |
| PROMOTION_ID PK    |  |                                |
| PLAN_ID FK         |<-|                                |
| USER_ID FK         |<----------------------------------|
| PROMOTION_NAME     |
| DISCOUNT           |
| START_DATE         |
| END_DATE           |
| APPLICABLE_TO_ALL  |
+--------------------+


```


## Listado de tablas y descripción

A continuación se presentan las 10 tablas que componen la base de datos.

| Tabla         | Columna           | Tipo de Datos                         | PK/FK |  Descripción                          |
| ------------- | ----------------- |-------------------------------------- |------- | -----------------------------------: |
| USERS         | USER_ID           | INT                                   | PK     | Identificador único del usuario      |
|               | FIRST_NAME        | VARCHAR (60) DEFAULT 'USER_UNKNOW'    |        | Nombre del ususario                  |
|               | LAST_NAME         | VARCHAR (60) DEFAULT 'USER_UNKNOW'    |        | Apellido del usuario                 |
|               | EMAIL             | VARCHAR (80) UNIQUE NOT NULL          |        | Mail del usuario                     |
|               | PHONE             | VARCHAR (25) NOT NULL                 |        | Teléfono del usuario                 |
|               | ADDRESS           | VARCHAR (100)                         |        | Dirección del usuario                |
|               | SIGN_UP_DATE      | DATE                                  |        | Fecha de registro del usuario        |



| Tabla              | Columna           | Tipo de Datos                         | PK/FK  |  Descripción                                 |
| ------------------ | ----------------- |-------------------------------------- |------- |-------------------------------------------:  |
| SUBSCRIPTION_PLANS | PLAN_ID           | INT                                   | PK     | Identificador único del plan                 |
|                    | PLAN_NAME         | VARCHAR(50) UNIQUE                    |        | Nombre del plan                              |
|                    | PRICE             | DECIMAL(10,2)                         |        | Costo mensual del plan                       |
|                    | DAILY_LIMIT_TRAD  | INT                                   |        | Límite diario de consumiciones tradicionales |
|                    | DAILY_LIMIT_SPEC  | INT                                   |        | Límite diario de consumiciones especiales    |



| Tabla         | Columna           | Tipo de Datos                         | PK/FK  |  Descripción                         |
| ------------- | ----------------- |-------------------------------------- |------- |-------------------------------------: |
| SUBSCRIPTION  | SUBSCRIPTION_ID   | INT                                   | PK     | Identificador único de la suscripción |
|               | USER_ID           | INT                                   | FK     | Identificador del usuario             |
|               | PLAN_ID           | INT                                   | FK     | Identificador del plan de suscripción |
|               | START_DATE        | DATE                                  |        | Fecha de inicio de la suscripción     |
|               | END_DATE          | DATE                                  |        | Fecha de vencimiento de la suscripción|
|               | STATUS            | VARCHAR(20)                           |        | Estado de la suscripción (act., inac.)|


| Tabla         | Columna           | Tipo de Datos                         |PK/FK  |  Descripción                       |
| ------------- | ----------------- |-------------------------------------- |-------|-----------------------------------:|
| CAFETERIAS    | CAFETERIA_ID      | INT                                   | PK    | Identificador único de la cafetería|
|               | NAME              | VARCHAR(100)                          |       | Nombre de la cafetería             |
|               | ADDRESS           | VARCHAR(100)                          |       | Dirección de la cafetería          |
|               | PHONE             | VARCHAR(25)                           |       | Teléfono de la cafeteria           |
|               | EMAIL             | VARCHAR(100)                          |       | Mail de la cafetería               |
|               | OPENING_HOURS     | VARCHAR(50)                           |       | Horario de apertura de la cafetería|
|               | CLOSING_HOURS     | VARCHAR(50)                           |       | Horario de cierre de la cafeterería|


| Tabla         | Columna           | Tipo de Datos                         |PK/FK  |  Descripción                               |
| ------------- | ----------------- |-------------------------------------- |-------|-------------------------------------------:|
| CONSUMPTIONS  | CONSUMPTION_ID    | INT                                   | PK    | Identificador único de la consumición      |
|               | USER_ID           | INT                                   | FK    | Identificador del usuario                  |
|               | CAFETERIA_ID      | INT                                   | FK    | Identificador de la cafetería              |
|               | SUBSCRIPTION_ID   | INT                                   | FK    | Identificación de la suscripción           |
|               | DATE              | DATE                                  |       | Fecha de la consumición                    |
|               | TYPE              | VARCHAR(15)                           |       | Tipo de consumición (tradicional/especial) |

| Tabla           | Columna           | Tipo de Datos                         |PK/FK  |  Descripción                          |
| --------------- | ----------------- |-------------------------------------- |-------|--------------------------------------:|
| PAYMENT_HISTORY | PAYMENT_ID        | INT                                   | PK    | Identificador único del pago          |
|                 | USER_ID           | INT                                   | FK    | Identificador del usuario             |
|                 | SUSCRIPTION_ID    | INT                                   | FK    | Identificación de la suscripción      |
|                 | PAYMENT           | DECIMAL(10,2)                         |       | Monto del pago                        |
|                 | PAYMENT_DATE      | DATE                                  |       | Fecha del pago                        |
|                 | PAYMENT_METHOD    | VARCHAR (30)                          |       | Método de pago (tarjeta/transferencia)|


| Tabla         | Columna           | Tipo de Datos                         |PK/FK  |  Descripción                       |
| ------------- | ----------------- |-------------------------------------- |-------|-----------------------------------:|
| MENU_ITEMS    | ITEM_ID           | INT                                   | PK    | Identificador único del item       |
|               | ITEM_NAME         | VARCHAR(100)                          |       | Nombre del ítem                    |
|               | ITEM_TYPE         | VARCHAR(15)                           |       | Tipo de ítem (tradicional/especial)|


| Tabla         | Columna           | Tipo de Datos                         | PK/FK |  Descripción                       |
| ------------- | ----------------- |-------------------------------------- |-------|-----------------------------------:|
| CAFETERIA_MENU| CAFETERIA_ID      | INT                                   | FK    | Identificador de la cafetería      |
|               | ITEM_ID           | INT                                   | FK    | Identificador del ítem             |


| Tabla           | Columna           | Tipo de Datos                         |PK/FK  |  Descripción                            |
| --------------- | ----------------- |-------------------------------------- |-------|---------------------------------------: |
| PROMOTIONS      | PROMOTION_ID      | INT                                   | PK    | Identificación única de la promoción    |
|                 | PROMOTION_NAME    | VARCHAR(100)                          |       | Nombre de la promoción                  |
|                 | DISCOUNT          | DECIMAL(5,2)                          |       | Descuento de la promoción               |
|                 | START_DATE        | DATE                                  |       | Fecha de inicio de la promoción         |
|                 | END    _DATE      | DATE                                  |       | Fecha de fin de la promoción            |
|                 | APPLICABLE_TO_ALL | BOOLEAN                               |       | La promoción es para todos los usuarios |
|                 | USER_ID           | INT                                   | FK    | Identificador del usuario               |
|                 | PLAN_ID           | INT                                   | FK    | Identificador del plan de suscripción   |


| Tabla           | Columna           | Tipo de Datos                         |PK/FK  |  Descripción                           |
| --------------- | ----------------- | -------------------------------------- | ------- | ---------------------------------------: |
| REVIEWS         | REVIEW   _ID      | INT                                    | PK    | Identificación única de la review      |
|                 | USER_ID           | INT                                    | FK    | Identificador del usuario              |
|                 | CAFETERIA_ID      | INT                                    | FK    | Identificador de la cafeteria          |
|                 | RATING            | INT                                    |       | Puntuación (1-10)                      |
|                 | COMMENT           | TEXT                                   |       | Comentario del usuario de la cafetería |
|                 | REVIEW_DATE       | DATE                                   |       | Fecha de la review                     |

## Script SQL para la creación de la base de datos y tablas

Se adjunta en el repositorio el archivo CafeAlPaso_DiazPaula.sql con el script necesario para la creación de las base de datos, con sus tablas.

## Estructura e ingesta de datos
* Se realiza principalmente por medio del archivo population.sql
* La carga de la tabla users se realiza por medio de un csv colocado en el directorio ./structure/DATAUSERS.csv

## Objetos de la base de datos


### Documentacion de Vistas
### Vista: USER_CONSUMPTION_SUMMARY_VW

**Descripción:** Esta vista muestra el consumo total de café por usuario y el plan que tiene.

**Columnas:**

* **User_ID:** ID del usuario
* **User_Name:** Concatena nombre y apellido
* **Total_Consumptions:** cuenta la cantidad de consumiciones del usuario
* **Subscription_plan:** plan de suscripción del usuario

**Ejemplo de consulta:**

```sql
SELECT *
FROM USER_CONSUMPTION_SUMMARY_VW
ORDER BY TOTAL_CONSUMPTIONS DESC, USER_ID;
```

### Vista: ACTIVE_PROMOTIONS_VW

**Descripción:** Esta vista muestra las promociones vigentes.

**Columnas:**

* **PROMOTION_NAME:** Nombre de la promoción
* **DISCOUNT:** Descuento que hace la promoción
* **START_DATE:** Fecha de inicio de la promoción
* **END_DATE:** Fecha de finalización de la promoción
* **APPLICABLE_TO_ALL:** Boolean si la aplicación es para todos o para usuarios seleccionados
* **USER_ID:** usuario que tiene vigente la promoción
* **PLAN_ID:** Plan en el que tendrá el descuento el usuario

**Ejemplo de consulta:**

```sql
SELECT *
FROM ACTIVE_PROMOTIONS_VW
ORDER BY START_DATE;
```

### Vista: CAFETERIA_REVIEWS_VW

**Descripción:** Esta vista muestra la calificación promedio y el número de reseñas por cafetería.

**Columnas:**

* **CAFETERIA_ID:** ID de la cafetería
* **NAME:** Nombre de la cafetería
* **REVIEW_COUNT:** Cantidad de reseñas de la cafetería
* **AVERAGE_RATING:** Calificación promedio de la cafetería

**Ejemplo de consulta:**

```sql
SELECT *
FROM CAFETERIA_REVIEWS_VW
ORDER BY REVIEW_COUNT DESC;
```

### Vista: CAFETERIA_MENU_ITEMS_VW

**Descripción:** Esta vista muestra los tipos de café que ofrece cada cafetería.

**Columnas:**

* **CAFETERIA_ID:** ID de la cafetería
* **NAME:** Nombre de la cafetería
* **ITEM_ID:** ID del café
* **ITEM_NAME:** Nombre del café
* **ITEM_TYPE:** Tipo del café (Tradicional/Especial)

**Ejemplo de consulta:**

```sql
SELECT *
FROM CAFETERIA_MENU_ITEMS_VW
ORDER BY NAME;
```

## Documentación de Funciones

### Función: TotalConsumptions

**Descripción:** Esta función cuenta las consumiciones por usuario.

**Parámetros:**

* **user_id:** Identificador único de usuario

**Retorno:**

* número total de consumiciones por usuario

**Ejemplo de uso:**

```sql
SELECT TotalConsumptions(15) AS Total_Consumiciones;
```

### Función: AverageRating

**Descripción:** Esta función calcula el promedio de puntuaciones de una cafetería.

**Parámetros:**

* **cafeteriaId:** Identificador único de la cafetería


**Retorno:**

* Calificación promedio de la cafetería

**Ejemplo de uso:**

```sql
SELECT AverageRating(2) AS Calificación_Promedio;
```

### Función: CalculateTotalPaymentsByMethod

**Descripción:** Esta función calcula la suma de pagos por método de pago.

**Parámetros:**

* **method:** método de pago (transferencia o tarjeta)

**Retorno:**

* monto total de pagos por el medio de pago seleccionado

**Ejemplo de uso:**

```sql
SELECT 
    'TARJETA' AS PaymentMethod,
    CalculateTotalPaymentsByMethod('TARJETA') AS TotalPagos
UNION ALL
SELECT 
    'TRANSFERENCIA' AS PaymentMethod,
    CalculateTotalPaymentsByMethod('TRANSFERENCIA') AS TotalPagos;
```

## Documentación de Triggers

### Trigger: BeforeCoffeeTypeInsert

**Descripción:** Este trigger verifica si el tipo de café que se intenta crear ya existe en el menú de la cafetería antes de permitir la inserción. Se activa antes de insertar un nuevo tipo de café en la tabla CAFETERIA_MENU.Si el tipo de café ya existe, se registra el intento en una tabla de logs y se lanza un error para evitar la duplicación.

**Detalles:**

* **Tabla afectada:** consumptions
* **Acción:** INSERT
* **Información registrada:** Fecha, tipo de café y ID de la cafetería

**Ejemplo:**

* Si el tipo de café ya existe en el menú de la cafetería especificada, se creará una entrada en la tabla TriggerLogs con los siguientes datos:
     * LogDate: La fecha y hora en el momento del intento de inserción.
     * Message: Mensaje que indica el intento de insertar un tipo de café que ya existe.
* Se lanzará un error con el mensaje: 'El tipo de café ya existe en el menú de la cafetería.

### Trigger: AfterConsumptionInsert

**Descripción:** Este trigger registra el intento de superar el límite diario de consumiciones (tradicionales o especiales) para un usuario según el plan que tiene en la tabla "logtable".

**Detalles:**

* **Tabla afectada:** cafeteria_menu
* **Acción:** INSERT
* **Información registrada:** Mensaje de alerta, Fecha y hora del registro 

**Ejemplo:**

* Se inserta una nueva consumición para un usuario.
* El trigger verifica si el usuario ha alcanzado el límite diario de consumiciones para el tipo de café.
* Si se supera el límite, el trigger registra la acción en la tabla LogTable con un mensaje que indica el usuario, la fecha y el tipo de café alcanzado el límite.

## Documentación de Procedimientos Almacenados

### Procedimiento: GetCafeteriaConsumptionStats

**Descripción:** Este procedimiento obtiene estadísticas de consumo de café en una cafetería específica dentro de un rango de fechas seleccionado.

**Parámetros:**

* **cafeteriaId:** ID de la cafetería para la cual se obtienen las estadísticas.
* **startDate:** Fecha de inicio del rango para la consulta.
* **endDate:** Fecha de fin del rango para la consulta.

**Retorno:**

* **totalConsumptions:** Total de consumiciones en la cafetería durante el rango de fechas.
* **avgDailyConsumptions:** Promedio diario de consumiciones en la cafetería durante el rango de fechas.

**Ejemplo de uso:**

```sql
 CALL GetCafeteriaConsumptionStats(3, '2024-07-31', '2024-08-02');
```

### Procedimiento: GetCoffeeTypeConsumptionSummary

**Descripción:** Este procedimiento proporciona un resumen de consumiciones por tipo de café dentro de un rango de fechas dado.

**Parámetros:**

* **startDate:** Fecha de inicio del rango para la consulta.
* **endDate:** Fecha de fin del rango para la consulta.

**Retorno:**

* **Type:** Tipo del café (tradicional o especial).
* **TotalConsumptions:** Cantidad total de consumiciones para cada tipo de café dentro del rango de fechas especificado.

**Ejemplo de uso:**

```sql
CALL GetCoffeeTypeConsumptionSummary('2022-01-01', '2025-08-02'); 
```

## Roles y Usuarios

**Descripción:** Se crearon 3 roles: admin, marketing y finanzas. A continuación se detallan los permisos y usuarios de cada uno de ellos.

### Rol: Admin

* **Accesos a:** todas las tablas y funciones de la base de datos. 
* **Permisos:** completos. Incluye: SELECT, INSERT, UPDATE, DELETE Y EXECUTE.
* **Usuario:** admin_user, contraseña: password_admin.
  
### Rol: Marketing

* **Accesos a:** las tablas de 'Promotions', 'Reviews', 'Cafeterías' y 'Users'.
* **Permisos:** SELECT e INSERT para la tabla de 'Promotions'. SELECT en el resto de las tablas mencionadas anteriormente.
* **Usuario:** marketing_user, contraseña: password_marketing.

### Rol: Finanzas

* **Accesos a:** las tablas de 'Payment_History', 'Subscription', 'Cafeterías' y 'Subscription_plans'.
* **Permisos:** SELECT e INSERT para la tabla de 'Payment_History'. SELECT en el resto de las tablas mencionadas anteriormente.
* **Usuario:** finanzas_user, contraseña: password_finanzas. Para este usuario se tiene una seguridad extra de máximo 3 intentos de ingreso, luego de 3 intentos fallidos, el usuario se bloquea por 1 día.

## Roles y Usuarios

**Descripción:** Se realiza un backup de la base de datos a través de DBeaver. Se adjunta en el repositorio dentro de la carpeta 'backuo' el archivo dump_cafealpaso_25082024.sql con el script completo que incluye tanto la estructura como la data de la BD.

## Herramientas y tecnologias usadas

* DBeaver 
* Mockaroo (para generar datos ficticios para tabla 'users')
