use flight_control;

SELECT 
    f.flight_number,
    f.airline_iata,
    f.departure_date,
    f.departure_time,
    f.arrival_date,
    f.arrival_time,
    f.departure_airport AS from_iata,
    a1.city AS from_city,
    f.arrival_airport AS to_iata,
    a2.city AS to_city,
    t.price
FROM 
    flight f
JOIN 
    airport a1 ON f.departure_airport = a1.airport_iata
JOIN 
    airport a2 ON f.arrival_airport = a2.airport_iata
join
    ticket t ON f.flight_number = t.flight_number;


SELECT f.flight_number, a.name AS airline,
 d_air.city AS departure_city,
 a_air.city AS arrival_city,
 CONCAT(f.departure_date, ' ', f.departure_time) AS
departure_datetime,
 CONCAT(f.arrival_date, ' ', f.arrival_time) AS
arrival_datetime
FROM flight f
JOIN airline a ON f.airline_iata = a.airline_iata
JOIN airport d_air ON f.departure_airport = d_air.airport_iata
JOIN airport a_air ON f.arrival_airport = a_air.airport_iata;



SELECT
 f.flight_number,
 COUNT(t.ticket_id) AS total_tickets,
 CASE
 WHEN COUNT(t.ticket_id) >= 50 THEN 'Популярний'
 WHEN COUNT(t.ticket_id) BETWEEN 20 AND 49 THEN 'Норм'
 ELSE 'Мало продано'
 END AS status
FROM flight f
LEFT JOIN ticket t ON f.flight_number = t.flight_number
GROUP BY f.flight_number;

SELECT t.*
FROM ticket t
WHERE t.flight_number = (
    SELECT f.flight_number
    FROM flight f
    ORDER BY TIMESTAMP(f.arrival_date, f.arrival_time) - TIMESTAMP(f.departure_date, f.departure_time) DESC
    LIMIT 1
);


SELECT
 p.passenger_id,
 CONCAT(p.first_name_ua, ' ', p.last_name_ua) AS full_name,
 COUNT(t.ticket_id) AS ticket_count
FROM passenger p
JOIN invoice i ON p.passenger_id = i.passenger_id
JOIN ticket t ON i.invoice_id = t.invoice_id
GROUP BY p.passenger_id
HAVING COUNT(t.ticket_id) > 1;


