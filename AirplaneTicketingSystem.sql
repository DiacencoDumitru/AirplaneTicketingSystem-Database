CREATE DATABASE AirplaneTicketingSystem;

CREATE TABLE Customers
(
    id           SERIAL PRIMARY KEY,
    full_name    VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    email        VARCHAR(255)
);

CREATE TABLE Flights
(
    id             SERIAL PRIMARY KEY,
    flight_number  VARCHAR(10)  NOT NULL,
    departure_city VARCHAR(100) NOT NULL,
    arrival_city   VARCHAR(100) NOT NULL,
    departure_time TIMESTAMP    NOT NULL,
    arrival_time   TIMESTAMP    NOT NULL
);

CREATE TABLE Tickets
(
    id            SERIAL PRIMARY KEY,
    customer_id   INT            NOT NULL,
    flight_id     INT            NOT NULL,
    seat_number   VARCHAR(10),
    price         NUMERIC(10, 2) NOT NULL,
    purchase_date TIMESTAMP      NOT NULL,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES Customers (id),
    CONSTRAINT fk_flight FOREIGN KEY (flight_id) REFERENCES Flights (id)
);

CREATE TABLE Airplanes
(
    id       SERIAL PRIMARY KEY,
    model    VARCHAR(100) NOT NULL,
    capacity INT          NOT NULL
);

CREATE TABLE Flight_Crews
(
    id        SERIAL PRIMARY KEY,
    flight_id INT          NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    role      VARCHAR(100) NOT NULL,
    CONSTRAINT fk_flight_crew FOREIGN KEY (flight_id) REFERENCES Flights (id)
);



INSERT INTO Customers (full_name, phone_number, email)
VALUES ('John Doe', '1234567890', 'john.doe@example.com'),
       ('Jane Smith', '0987654321', 'jane.smith@example.com'),
       ('Alice Johnson', '5551234567', 'alice.johnson@example.com'),
       ('Bob Brown', '7778889999', 'bob.brown@example.com');

INSERT INTO Flights (flight_number, departure_city, arrival_city, departure_time, arrival_time)
VALUES ('FL123', 'New York', 'London', '2024-12-01 10:00:00', '2024-12-01 20:00:00'),
       ('FL456', 'Paris', 'Berlin', '2024-12-02 08:30:00', '2024-12-02 10:00:00'),
       ('FL789', 'Tokyo', 'Seoul', '2024-12-03 14:00:00', '2024-12-03 16:30:00'),
       ('FL101', 'Dubai', 'Mumbai', '2024-12-04 09:00:00', '2024-12-04 11:00:00');

INSERT INTO Tickets (customer_id, flight_id, seat_number, price, purchase_date)
VALUES (1, 1, '12A', 500.00, '2024-11-01 15:30:00'),
       (2, 2, '15B', 200.00, '2024-11-02 10:45:00'),
       (3, 3, '3C', 300.00, '2024-11-03 12:00:00'),
       (4, 4, '7D', 400.00, '2024-11-04 09:20:00');

INSERT INTO Airplanes (model, capacity)
VALUES ('Boeing 747', 400),
       ('Airbus A320', 180),
       ('Embraer E190', 100),
       ('Bombardier CRJ200', 50);

INSERT INTO Flight_Crews (flight_id, full_name, role)
VALUES (1, 'Captain James Kirk', 'Pilot'),
       (1, 'Spock', 'Co-Pilot'),
       (2, 'Jean-Luc Picard', 'Pilot'),
       (2, 'Data', 'Co-Pilot'),
       (3, 'Han Solo', 'Pilot'),
       (3, 'Chewbacca', 'Co-Pilot'),
       (4, 'Leia Organa', 'Pilot'),
       (4, 'Luke Skywalker', 'Co-Pilot');



-- Interogări pe o singură tabelă


-- Lista tuturor clienților cu numele complet și email-ul
SELECT full_name, email
FROM Customers;

-- Lista zborurilor cu ora de plecare și ora de sosire
SELECT flight_number, departure_time, arrival_time
FROM Flights;

-- Lista biletelor cu prețul și data achiziției
SELECT seat_number, price, purchase_date
FROM Tickets;

-- Lista avioanelor cu modelele, capacitatea lor
SELECT model, capacity
FROM Airplanes;

-- Lista echipajelor cu numele complet, rolurile lor
SELECT full_name, role
FROM Flight_Crews;



-- Interogări cu mai multe tabele


-- Lista clienților și zborurile pentru care au cumpărat bilete. Conectăm trei tabele: Tickets, Customers și Flights
SELECT Customers.full_name, Flights.flight_number
FROM Tickets
         JOIN Customers ON Tickets.customer_id = Customers.id
         JOIN Flights ON Tickets.flight_id = Flights.id;

-- Lista zborurilor împreună cu modelele avioanelor.Se presupune că există o relație între tabelele Flights și Airplanes. Dacă relația lipsește, adaugam un câmp `airplane_id` în tabela Flights
SELECT Flights.flight_number, Airplanes.model
FROM Flights
         JOIN Airplanes ON Flights.id = Airplanes.id;

-- Lista echipajelor pentru fiecare zbor
SELECT Flights.flight_number, Flight_Crews.full_name, Flight_Crews.role
FROM Flight_Crews
         JOIN Flights ON Flight_Crews.flight_id = Flights.id;

-- Lista clienților, locurile lor și prețul biletelor
SELECT Customers.full_name, Tickets.seat_number, Tickets.price
FROM Tickets
         JOIN Customers ON Tickets.customer_id = Customers.id;

-- Lista zborurilor care pleacă dintr-un anumit oraș și sosesc într-un alt oraș
SELECT Flights.flight_number, Flights.departure_city, Flights.arrival_city
FROM Flights
WHERE Flights.departure_city = 'București'
  AND Flights.arrival_city = 'Londra';
