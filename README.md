


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
