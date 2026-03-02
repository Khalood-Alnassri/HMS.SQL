-- ============================================
-- Hospital Management System - SQL Assessment
-- 20 Practical Scenarios
-- ============================================

USE HospitalManagementSystem;
GO

-- SCENARIO 1
-- A new patient named "Yasmin Khaled" needs to be registered in the system.
-- Her phone number is 0121111111, email is yasmin.khaled@email.com
-- She was born on 1997-06-15, has blood group AB+, and is female.
-- Address: "888 Helwan St, Cairo"
-- Write a query to add this patient to the database.

BEGIN TRANSACTION;

INSERT INTO PATIENT (F_name, L_name, Phone_no, Address, Email, DOB, Blood_group, Gender)
VALUES ('Yasmin', 'Khaled', '0121111111', '888 Helwan St, Cairo' ,'yasmin.khaled@email.com', '1997-06-15', 'AB+', 'F');

COMMIT TRANSACTION;

PRINT 'Transaction 1: New patient added successfully!';
GO

-- SCENARIO 2
-- The hospital is opening a new department called "Dermatology"
-- Location: "Building E - Floor 2"
-- Contact number: 0221234572
-- Initially it will have 0 doctors and no manager yet
-- Write a query to add this new department.

BEGIN TRANSACTION;

INSERT INTO  DEPARTMENT (Dept_name, Location, No_of_doctors, Contact_number, Manager_ID)
VALUES ('Dermatology', 'Building E - Floor 2', NULL, '0221234572', NULL);

COMMIT TRANSACTION;

PRINT 'Transaction 1: New department added successfully!';
GO

-- SCENARIO 3
-- Patient with ID 8 has changed their phone number to 0188888888
-- Write a query to update this patient's phone number.

UPDATE PATIENT
SET Phone_no = 0188888888
WHERE Patient_ID = 8;
GO

-- SCENARIO 4
-- All appointments scheduled for Doctor ID 3 on 2024-03-02 
-- need to be rescheduled to 2024-03-09 (same time, same patients)
-- Write a query to update these appointments.

UPDATE APPOINTMENT
SET Date = '2024-03-09' 
WHERE Date IN ('2024-03-02')
AND Doctor_ID = 3
GO

-- SCENARIO 5
-- The Cardiology department (Dept_ID = 1) wants to increase 
-- all their service prices by 15% due to new equipment costs.
-- Write a query to update all service prices for this department.

UPDATE SERVICE
SET Unit_price = Unit_price * 1.15
WHERE Dept_ID = 1
GO

-- SCENARIO 6
-- Generate a report showing all scheduled appointments with:
-- - Appointment ID
-- - Appointment date and time
-- - Patient full name (first name + last name)
-- - Patient phone number
-- - Doctor name
-- - Doctor specialization
-- Order the results by appointment date and time.

SELECT A.APPT_ID,
       A.Date,
	   A.Time, 
	   P.F_name + '' + P.L_name AS Patient_full_name,
	   P.Phone_no,
	   D.Name,
	   D.Specialization
FROM APPOINTMENT A
    JOIN PATIENT P ON A.Patient_ID = P.Patient_ID
	JOIN DOCTOR D ON A.Doctor_ID = D.Doctor_ID
WHERE A.Status = 'scheduled'
ORDER BY A.Date, A.Time
 GO

 -- SCENARIO 7
-- The hospital needs a list of all doctors showing:
-- - Doctor name
-- - Their department name
-- - Their department manager's name
-- - Number of appointments they have handled
-- Only include doctors who have at least one appointment.
-- Order by number of appointments (highest first).

SELECT D.Name,
       Dep.Dept_name,
	   N.Name AS Manager_name,
	   COUNT (A.APPT_ID) AS Appointment_no
FROM APPOINTMENT A
   JOIN DOCTOR D ON A.Doctor_ID = D.Doctor_ID
   JOIN DEPARTMENT Dep ON D.Dept_ID = Dep.Dept_ID
   LEFT JOIN DOCTOR N ON Dep.Manager_ID = N.Doctor_ID
   GROUP BY D.Name, Dep.Dept_name, N.Name
   HAVING COUNT (APPT_ID) >= 1
   ORDER BY (SELECT COUNT (*) FROM APPOINTMENT) DESC
GO

-- SCENARIO 8
-- Create a financial summary report showing:
-- - Department name
-- - Total number of completed appointments in that department
-- - Total revenue from paid bills in that department
-- - Average bill amount in that department
-- Only include departments that have generated revenue.
-- Order by total revenue (highest first).

SELECT D.Dept_name,
       COUNT (A.APPT_ID) AS total_appointment, 
	   COUNT (B.Bill_ID) AS total_biil,
	   AVG (B.Total_amount) AS avg_amount
FROM DEPARTMENT D
    JOIN DOCTOR L ON L.Dept_ID = D.Dept_ID
	JOIN APPOINTMENT A ON A.Doctor_ID = L.Doctor_ID
	JOIN BILLING B ON B.APPT_ID = A.APPT_ID
GROUP BY D.Dept_name
HAVING SUM (B.Total_amount) > 0
ORDER BY SUM (B.Total_amount) DESC
GO

-- SCENARIO 9
-- Generate a patient activity report showing:
-- - Patient full name
-- - Patient blood group
-- - Total number of appointments they've had
-- - Total amount they've spent (sum of all their bills)
-- - Their payment status distribution (how many paid, pending, etc.)
-- Only include patients who have had more than 2 appointments.
-- Order by total amount spent (highest first).

SELECT P.F_name + ' ' + P.L_name AS patient_full_name,
       P.Blood_group,
	   COUNT (A.APPT_ID) AS total_appointment,
	   SUM (B.Total_amount) AS total_amount,
	   COUNT (B.Payment_status) AS payment_status
FROM PATIENT P
    JOIN APPOINTMENT A ON P.Patient_ID = A.Patient_ID
	LEFT JOIN BILLING B ON P.Patient_ID = B.Patient_ID
GROUP BY P.F_name, P.L_name, P.Blood_group
HAVING COUNT (A.APPT_ID) > 2
ORDER BY SUM (B.Total_amount) DESC
GO

-- SCENARIO 10
-- Create a detailed service utilization report showing:
-- - Service name
-- - Service type
-- - Department offering the service
-- - Number of times the service was used
-- - Total quantity of service provided
-- - Total revenue generated from this service
-- Only include services that have been used at least once.
-- Order by total revenue generated (highest first).

SELECT S.Service_name,
       S.Service_type,
	   D.Dept_name,
	   COUNT (A.Service_ID) AS service_use,
	   COUNT (A.Quantity) AS total_quantity,
	   COUNT (A.Subtotal) AS sub_total
FROM SERVICE S
   JOIN DEPARTMENT D ON D.Dept_ID = S.Dept_ID
   LEFT JOIN APP_SERVICE A ON S.Service_ID = A.Service_ID
GROUP BY S.Service_name, S.Service_type, D.Dept_name
HAVING  COUNT (A.Service_ID) >= 1
ORDER BY COUNT (A.Subtotal) DESC
GO

-- SCENARIO 11
-- Find all patients who have spent more than the average 
-- total spending across all patients.
-- Show: Patient ID, Patient name, and their total spending.
-- Order by total spending (highest first).

SELECT P.Patient_ID,
       P.F_name + ' ' + P.L_name AS patient_name,
	   SUM (B.Total_amount) AS total_spinding
FROM PATIENT P
   JOIN BILLING B ON P.Patient_ID = B.Patient_ID
GROUP BY P.Patient_ID, P.F_name, P.L_name
HAVING  SUM (B.Total_amount) > AVG (B.Total_amount) 
ORDER BY SUM (B.Total_amount) DESC
GO

-- SCENARIO 12
-- Find all doctors who have more appointments than 
-- the doctor with Doctor_ID = 7.
-- Show: Doctor ID, Doctor name, and their appointment count.
-- Order by appointment count (highest first).

SELECT D.Doctor_ID,
       D.Name,
	   COUNT (A.APPT_ID) AS appointment_count
FROM DOCTOR D
   JOIN APPOINTMENT A ON D.Doctor_ID = A.Doctor_ID
GROUP BY D.Doctor_ID, D.Name
HAVING  COUNT (A.APPT_ID) > (SELECT COUNT (*)
                            FROM APPOINTMENT WHERE Doctor_ID = 7)
ORDER BY appointment_count DESC
GO

-- SCENARIO 13
-- Find all services where the unit price is higher than 
-- the average price of services in the same service type.
-- Show: Service name, Service type, Unit price, 
-- and the average price for that service type.
-- Order by service type, then by unit price (highest first).

SELECT Service_name,
       Service_type, 
	   Unit_price,
	   AVG (Unit_price) AS avg_price
FROM SERVICE
WHERE Unit_price > (SELECT AVG (Unit_price)
                    FROM SERVICE)
GROUP BY Service_name, Service_type, Unit_price
ORDER BY Service_type ASC, Unit_price DESC
GO

-- SCENARIO 14
-- Find patients who have appointments but have never 
-- had a completed appointment (all their appointments are 
-- either scheduled, cancelled, or no-show).
-- Show: Patient ID, Patient name, Phone number.
-- Include a count of how many appointments they have.

SELECT P.Patient_ID,
       P.F_name + ' ' + P.L_name AS patient_name,
	   P.Phone_no,
	   COUNT (A.APPT_ID) AS appointment_count
FROM PATIENT P
   JOIN APPOINTMENT A ON P.Patient_ID = A.Patient_ID
WHERE A.Status IN ('scheduled', 'cancelled', 'no-show')
GROUP BY P.Patient_ID, P.F_name, P.L_name, P.Phone_no
GO

-- SCENARIO 15
-- Find the most expensive bill for each payment status category.
-- Show: Payment status, Bill ID, Total amount, Patient name.
-- Include the department name where the appointment took place.
-- Order by total amount (highest first).

SELECT ROW_NUMBER() OVER (PARTITION BY B.Payment_status ORDER BY B.Total_amount DESC) AS expensive_bill,
       B.Payment_status,
       B.Bill_ID,
	   B.Total_amount,
	   P.F_name + ' ' + P.L_name AS patient_name,
	   V.Dept_name
FROM BILLING B
   JOIN PATIENT P ON P.Patient_ID = B.Patient_ID
   JOIN APPOINTMENT A ON A.APPT_ID = B.APPT_ID
   JOIN DOCTOR D ON D.Doctor_ID = A.Doctor_ID
   JOIN DEPARTMENT V ON V.Dept_ID = D.Dept_ID
ORDER BY B.Total_amount DESC
GO
 
-- SCENARIO 16
-- Rank all doctors within their department based on years of experience.
-- Show: Department name, Doctor name, Years of experience, and their rank.
-- The most experienced doctor in each department should have rank 1.
-- Order by department name, then by rank.

SELECT 
     RANK() OVER (PARTITION BY N.Dept_ID ORDER BY N.Years_of_experience DESC) AS experience_rank,
	 D.Dept_name,
	 N.Name,
	 N.Years_of_experience
FROM DEPARTMENT D
   JOIN DOCTOR N ON D.Dept_ID = N.Dept_ID
GROUP BY D.Dept_ID, D.Dept_name, N.Dept_ID, N.Name, N.Years_of_experience
ORDER BY D.Dept_name ASC,
         experience_rank DESC
GO

-- SCENARIO 17
-- Create a ranking of patients based on their total spending.
-- Show: Patient name, Total amount spent, and their spending rank.
-- Include only patients who have at least one bill.
-- Use a ranking method that doesn't skip numbers (dense ranking).
-- Order by rank.

SELECT P.F_name + ' ' + P.L_name AS patient_name,
       SUM (B.Total_amount) AS total_spending,
	   DENSE_RANK () OVER (ORDER BY SUM(B.Total_amount) DESC) AS spending_rank
FROM PATIENT P
   JOIN BILLING B ON P.Patient_ID = B.Patient_ID
GROUP BY P.F_name, P.L_name
HAVING COUNT (B.Bill_ID) >= 1
ORDER BY spending_rank
GO

-- SCENARIO 18
-- Rank all services by their utilization (how many times they've been used).
-- Show: Service name, Department name, Times used, and rank.
-- Partition the ranking by department (rank within each department).
-- Show all services, even those never used (times used = 0).
-- Order by department name, then by rank.

SELECT S.Service_name,
       D.Dept_name,
	   COUNT (S.Service_ID) AS service_use,
	   DENSE_RANK() OVER (PARTITION BY D.Dept_ID ORDER BY COUNT(S.Service_ID) DESC) AS utilization_rank
FROM SERVICE S
   JOIN DEPARTMENT D ON D.Dept_ID = S.Dept_ID
GROUP BY S.Service_name, D.Dept_name, D.Dept_ID
ORDER BY D.Dept_name ASC, utilization_rank ASC
GO


-- SCENARIO 19
-- A patient (Patient_ID = 12) is booking a new appointment with Doctor_ID = 4
-- for 2024-03-28 at 16:00:00. The appointment is for a "Routine" checkup
-- with reason "Annual physical examination", and status should be "Scheduled".
-- At the same time, create a bill for this appointment with:
-- - Bill amount: 500.00
-- - Payment status: Pending
-- - Due date: 2024-04-15
-- Write a transaction that creates both the appointment and the bill together.
-- Make sure both are saved or both are cancelled if there's an error.

BEGIN TRANSACTION;

-- Create the appointment
INSERT INTO APPOINTMENT (Date, Time, Status, Appointment_type, Reason, Patient_ID, Doctor_ID)
VALUES ('2024-03-28', '16:00:00', 'Scheduled', 'Routine', 'Annual physical examination', 12, 4);

-- Create the bill
INSERT INTO BILLING (Bill_date, Total_amount, Payment_status, Due_date, APPT_ID, Patient_ID)
VALUES (GETDATE(), 500.00, 'Pending', '2024-03-28', 42, 12);

COMMIT TRANSACTION;

PRINT 'Transaction 5: Appointment and bill created successfully!';
GO

-- SCENARIO 20
-- The hospital needs to cancel an appointment and all related records.
-- For Appointment_ID = 30:
-- - First, delete any services linked to this appointment (from APP_SERVICE)
-- - Then update the appointment status to 'Cancelled'
-- - Then update the corresponding bill's payment status to 'Cancelled'
-- Write a transaction that performs all three operations together.
-- All changes should be committed together or rolled back if any step fails.

BEGIN TRANSACTION;

-- delete any services linked to this appointment (from APP_SERVICE)
DELETE FROM APP_SERVICE
WHERE APPT_ID = 30

-- update the appointment status to 'Cancelled'
UPDATE APPOINTMENT
SET Status = 'Cancelled'
WHERE APPT_ID = 30

-- update the corresponding bill's payment status to 'Cancelled'
UPDATE BILLING
SET Payment_status = 'Cancelled'
WHERE APPT_ID = 30

COMMIT TRANSACTION;

PRINT 'Transaction 6: Appointment are Cancelled!';
GO
