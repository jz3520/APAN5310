CREATE TABLE timezone(
                timezone_id       integer,
                timezone          varchar(100),
                PRIMARY KEY (timezone_id)
            )
CREATE TABLE source(
            source        varchar(100),
            latitude      float,
            longitude     float,
            timezone_id   integer,
            PRIMARY KEY (source),
            FOREIGN KEY (timezone_id) REFERENCES timezone
        )
CREATE TABLE timestamp(
            timestamp   numeric(13,3),
            datetime    timestamp NOT NULL,
            PRIMARY KEY (timestamp),
            UNIQUE(datetime)
        )
CREATE TABLE product(
            product_id       varchar(100),
            cab_type         varchar(100),
            name             varchar(100),
            PRIMARY KEY (product_id)
        )
CREATE TABLE order_(
            id               varchar(100),
            product_id       varchar(100),
            PRIMARY KEY (id),
            FOREIGN KEY (product_id) REFERENCES product
        )
CREATE TABLE trip(
            id               varchar(100),
            timestamp     numeric(13,3),
            source        varchar(100),
            destination   varchar(100),
            distance      float NOT NULL,
            PRIMARY KEY (id,source, timestamp, destination),
            FOREIGN KEY (timestamp) REFERENCES timestamp,
            FOREIGN KEY (source) REFERENCES source,
            FOREIGN KEY(id) REFERENCES order_
        )
CREATE TABLE solarTerms(
            datetime            timestamp,
            sunriseTime         char(10),
            sunsetTime          char(10),
            moonPhase           numeric(3,2),
            PRIMARY KEY (datetime),
            FOREIGN KEY (datetime) REFERENCES timestamp(datetime)
        )
CREATE TABLE surge(
            surge_id integer,
            surge_multiplier numeric(2,1) not null,
            PRIMARY KEY (surge_id)
        )
CREATE TABLE price(
            id               varchar(100),
            surge_id integer,
            source        varchar(100),
            destination   varchar(100),
            product_id           varchar(100),
            timestamp     numeric(13,3),
            price                numeric(5,2),
            PRIMARY KEY (surge_id, source, timestamp, destination, product_id,id),
            FOREIGN KEY (surge_id) REFERENCES surge (surge_id),
            FOREIGN KEY (id,source, timestamp, destination) REFERENCES trip,
            FOREIGN KEY (product_id) REFERENCES product (product_id)
        )
CREATE TABLE apparentTemperature(
            apparentTemperature_id        integer,
            apparentTemperature           numeric(4,2),
            apparentTemperatureHigh       numeric(4,2),
            apparentTemperatureHighTime   char(10),
            apparentTemperatureLow        numeric(4,2),
            apparentTemperatureLowTime    char(10),
            apparentTemperatureMin        numeric(4,2),
            apparentTemperatureMinTime    char(10),
            apparentTemperatureMax        numeric(4,2),
            apparentTemperatureMaxTime    char(10),
            PRIMARY KEY (apparentTemperature_id)
        )
CREATE TABLE temperature(
            temperature_id                integer,
            apparentTemperature_id        integer,
            temperature                   numeric(4,2),
            temperatureHigh               numeric(4,2),
            temperatureHighTime           char(10),
            temperatureLow                numeric(4,2),
            temperatureLowTime            char(10),
            temperatureMin                numeric(4,2),
            temperatureMinTime            char(10),
            temperatureMax                numeric(4,2),
            temperatureMaxTime            char(10),
            PRIMARY KEY (temperature_id),
            FOREIGN KEY (apparentTemperature_id) REFERENCES apparentTemperature
        )
CREATE TABLE weather(
            weather_id                    integer,
            temperature_id                integer,
            short_summary                 varchar(100),
            precipIntensity               numeric(5,4),
            precipProbability             numeric(3,2),
            precipIntensityMax            numeric(5,4),
            humidity                      numeric(3,2),
            windSpeed                     numeric(4,2),
            windGust                      numeric(4,2),
            windGustTime                  char(10),
            visibility                    numeric(5,3),
            icon                          varchar(30),
            dewPoint                      numeric(4,2),
            pressure                      numeric(6,2),
            windBearing                   integer,
            cloudCover                    numeric(3,2),
            uvIndex                       integer,
            uvIndexTime                   char(10),
            ozone                         numeric(5,1),
            PRIMARY KEY (weather_id),
            FOREIGN KEY (temperature_id) REFERENCES temperature
        )
CREATE TABLE climateSummary(
            id                    varchar(100),
            weather_id            integer,
            short_summary         varchar(100),
            long_summary          varchar(300),
            PRIMARY KEY (id, weather_id),
            FOREIGN KEY (id) REFERENCES order_,
            FOREIGN KEY (weather_id) REFERENCES weather
        )





