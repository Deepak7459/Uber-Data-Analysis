-- Drop table if exists
DROP TABLE IF EXISTS bookings;

-- Create table
CREATE TABLE bookings (
    Booking_Date            DATE,
    Booking_Time            TIME,
    Booking_ID              INTEGER PRIMARY KEY,
    Booking_Status          VARCHAR(50),
    Customer_ID             VARCHAR(50),
    Vehicle_Type            VARCHAR(50),
    Pickup_Location         TEXT,
    Drop_Location           TEXT,
    V_TAT                   DECIMAL(10,2),     -- Vehicle Turnaround Time (minutes)
    C_TAT                   DECIMAL(10,2),     -- Customer Turnaround Time (minutes)
    Cancelled_By_Customer   TEXT,
    Cancelled_By_Driver     TEXT,
    Incomplete_Rides        TEXT,
    Incomplete_Rides_Reason TEXT,
    Booking_Value           NUMERIC(20,2),
    Payment_Method          VARCHAR(50),
    Ride_Distance           NUMERIC(10,2),     -- in km
    Driver_Rating           NUMERIC(3,2),
    Customer_Rating         NUMERIC(3,2)
);

-- Verify table creation
SELECT * FROM bookings;

-- Import data
COPY bookings 
FROM 'D:/Uber Project/Bookings.csv' 
DELIMITER ',' 
CSV HEADER;

--------------------------------------------------------
-- SQL Questions & Answers
--------------------------------------------------------

-- 1. Retrieve all successful bookings
SELECT *
FROM bookings
WHERE booking_status = 'Successful';

-- 2. The average ride distance for each vehicle type
SELECT 
    vehicle_type,
    AVG(ride_distance) AS average_ride_distance
FROM bookings
GROUP BY vehicle_type;

-- 3. Get the total number of cancelled rides by customers
SELECT 
    COUNT(*) AS cancelled_rides_by_customers
FROM bookings
WHERE booking_status = 'Cancelled by Customer';

-- 4. List the top 5 customers who booked the highest number of rides
SELECT 
    customer_id,
    COUNT(*) AS total_rides
FROM bookings
GROUP BY customer_id
ORDER BY total_rides DESC
LIMIT 5;

-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues
SELECT 
    COUNT(*) AS driver_personal_car_cancel
FROM bookings
WHERE cancelled_by_driver = 'Personal and Car related issue';

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings
SELECT 
    MAX(driver_rating) AS max_rating,
    MIN(driver_rating) AS min_rating
FROM bookings
WHERE vehicle_type = 'Prime Sedan';

-- 7. Retrieve all rides where payment was made using UPI
SELECT *
FROM bookings
WHERE payment_method = 'UPI';

-- 8. Find the average customer rating per vehicle type
SELECT 
    vehicle_type,
    AVG(customer_rating) AS average_customer_rating
FROM bookings
GROUP BY vehicle_type
ORDER BY vehicle_type;

-- Check data
SELECT * FROM bookings;

-- 9. Calculate the total booking value of rides completed successfully
SELECT 
    SUM(booking_value) AS total_successful_ride_value
FROM bookings
WHERE booking_status = 'Successful';

-- 10. List all incomplete rides along with the reason
SELECT 
    booking_id,
    incomplete_rides_reason
FROM bookings
WHERE incomplete_rides = '1';
