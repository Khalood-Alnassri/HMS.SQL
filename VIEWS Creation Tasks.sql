
USE HospitalManagementSystem;
GO

-- ============================================
-- View 1: ViewHighValuePatients
-- ============================================
/*
Create a view that displays patients who have spent more than $2000 in total,
including their total number of appointments.

Required columns:
- Patient_ID
- Patient full name (first + last)
- Phone number
- Total amount spent
- Total number of appointments

Order by total amount spent (highest first).
*/

CREATE VIEW ViewHighValuePatients 
AS 

    SELECT P.Patient_ID, 
	       P.F_name + ' ' + P.L_name AS patient_name,
		   P.Phone_no,
		   SUM (B.Total_amount) AS total_amount,
		   COUNT (A.APPT_ID) AS total_appointments
	FROM PATIENT P JOIN APPOINTMENT A ON P.Patient_ID = A.Patient_ID
	JOIN BILLING B ON P.Patient_ID = B.Patient_ID
	GROUP BY P.Patient_ID, P.F_name, P.L_name, P.Phone_no
	HAVING  SUM (B.Total_amount) > $2000
	
--usage

SELECT *
FROM ViewHighValuePatients
ORDER BY total_amount DESC;

-- ============================================
-- View 2: ViewDoctorWorkload
-- ============================================
/*
Create a view that lists each doctor along with their total number of completed 
appointments and their average appointment revenue.

Required columns:
- Doctor_ID
- Doctor name
- Specialization
- Department name
- Total completed appointments
- Average revenue per appointment

Order by total completed appointments (highest first).
*/

CREATE VIEW ViewDoctorWorkload (Doctor_id, Doctor_name, Doctor_Specialization, Department_name, total_appointments, avg_revenue_per_appointment)
AS
    SELECT X.Doctor_ID,
	       X.Name AS Doctor_name, 
		   X.Specialization,
		   D.Dept_name,
		   COUNT (A.APPT_ID) AS total_appointments,
		   SUM (B.Total_amount) / COUNT (A.APPT_ID) AS avg_revenue_per_appointment
	FROM DEPARTMENT D JOIN DOCTOR X ON D.Dept_ID = X.Dept_ID
	JOIN APPOINTMENT A ON X.Doctor_ID = A.Doctor_ID
	JOIN BILLING B ON A.APPT_ID = B.APPT_ID
	GROUP BY X.Doctor_ID, X.Name, X.Specialization, D.Dept_name, A.Status
	HAVING A.Status = 'completed'

--usage

SELECT * 
FROM ViewDoctorWorkload 
ORDER BY total_appointments DESC;

-- ============================================
-- View 3: ViewPendingBills
-- ============================================
/*
Create a view showing all unpaid bills (status = 'Pending' or 'Overdue'),
grouped by payment status and ordered by due date.

Required columns:
- Bill_ID
- Patient full name
- Patient phone number
- Bill amount
- Payment status
- Due date
- Days overdue (difference between due date and current date)

Order by due date (oldest first).
*/

CREATE VIEW ViewPendingBills (Bill_id, Patient_name, Phone_number, Amount, Payment, due_date, Days_Overdue)
AS
    SELECT B.Bill_ID,
	       P.F_name + ' ' + P.L_name AS Patient_full_name,
		   P.Phone_no,
		   B.Total_amount,
		   B.Payment_status,
		   B.Due_date,
		   DATEDIFF(DAY, Due_date, GETDATE()) AS Days_Overdue
	FROM PATIENT P JOIN BILLING B ON P.Patient_ID = B.Patient_ID
	GROUP BY B.Payment_status, B.Bill_ID, P.F_name, P.L_name, P.Phone_no, B.Due_date, B.Total_amount
	HAVING B.Payment_status IN ('Pending' , 'Overdue') 

--usage

SELECT *
FROM ViewPendingBills
ORDER BY Due_date DESC;

-- ============================================
-- View 4: ViewServiceUtilization
-- ============================================
/*
Create a view summarizing service usage by department: 
total times each service was used and total revenue generated.

Required columns:
- Department name
- Service name
- Service type
- Unit price
- Times used (count of appointments using this service)
- Total revenue generated from this service

Only include services that have been used at least once.
Order by department name, then by total revenue (highest first).
*/

CREATE VIEW ViewServiceUtilization 
AS
     
	 SELECT D.Dept_name,
	        S.Service_name,
			S.Service_type,
			COUNT (A.APPT_ID) AS Time_used,
			SUM (A.Subtotal) AS total_revenue
	 FROM DEPARTMENT D JOIN SERVICE S ON D.Dept_ID = S.Dept_ID
	 JOIN APP_SERVICE A ON S.Service_ID = A.Service_ID
	 GROUP BY D.Dept_name, S.Service_name, S.Service_type
	 HAVING COUNT (A.Service_ID) >= 1

--USAGE

SELECT *
FROM ViewServiceUtilization
ORDER BY Dept_name ASC,
       Total_revenue DESC;

-- ============================================
-- View 5: ViewAppointmentSchedule
-- ============================================
/*
Create a view showing all scheduled appointments along with patient contact details,
doctor information, and billing status.

Required columns:
- Appointment ID
- Appointment date
- Appointment time
- Patient full name
- Patient phone number
- Doctor name
- Department name
- Appointment type
- Payment status from billing

Only include appointments with status = 'Scheduled'.
Order by appointment date and time.
*/

CREATE VIEW ViewAppointmentSchedule (Appointment_id, Appointment_date, Appointment_time, Patient_name, Patient_Phone, Doctor_name, Department_name, appointment_type, payment_status)
AS 
      SELECT A.APPT_ID,
	         A.Date,
			 A.Time,
			 P.F_name + ' ' + P.L_name AS patient_name,
			 P.Phone_no,
			 D.Name,
			 DEP.Dept_name,
			 A.Appointment_type,
			 B.Payment_status
	  FROM PATIENT P JOIN APPOINTMENT A ON P.Patient_ID = A.Patient_ID
	  JOIN DOCTOR D ON D.Doctor_ID = A.Doctor_ID
	  JOIN DEPARTMENT DEP ON DEP.Dept_ID = D.Dept_ID
	  JOIN BILLING B ON A.APPT_ID = B.APPT_ID 
	  WHERE A.Status = 'Scheduled'

--usage

SELECT *
FROM ViewAppointmentSchedule
ORDER BY Appointment_date, Appointment_time;