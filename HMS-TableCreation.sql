-- ============================================
-- Hospital Management System - Database Creation
-- ============================================

-- Create Database
CREATE DATABASE HospitalManagementSystem;
GO

USE HospitalManagementSystem;
GO

-- ============================================
-- TABLE 1: PATIENT
-- ============================================
CREATE TABLE PATIENT (
    Patient_ID INT IDENTITY(1,1) PRIMARY KEY,
    F_name VARCHAR(50) NOT NULL,
    L_name VARCHAR(50) NOT NULL,
    Phone_no VARCHAR(15) NOT NULL UNIQUE,
    Email VARCHAR(100) UNIQUE,
    Address VARCHAR(255),
    DOB DATE NOT NULL CHECK (DOB <= GETDATE()),
    Blood_group VARCHAR(5) CHECK (Blood_group IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-')),
    Gender CHAR(1) NOT NULL CHECK (Gender IN ('M', 'F', 'O'))
);
GO

-- ============================================
-- TABLE 2: DEPARTMENT
-- ============================================
CREATE TABLE DEPARTMENT (
    Dept_ID INT IDENTITY(1,1) PRIMARY KEY,
    Dept_name VARCHAR(100) NOT NULL UNIQUE,
    Location VARCHAR(100) NOT NULL,
    No_of_doctors INT DEFAULT 0 CHECK (No_of_doctors >= 0),
    Contact_number VARCHAR(15) NOT NULL,
    Manager_ID INT NULL
);
GO

-- ============================================
-- TABLE 3: DOCTOR
-- ============================================
CREATE TABLE DOCTOR (
    Doctor_ID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100) NOT NULL,
    Phone_no VARCHAR(15) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    License_no VARCHAR(50) NOT NULL UNIQUE,
    Qualification VARCHAR(200) NOT NULL,
    Years_of_experience INT CHECK (Years_of_experience >= 0),
    Dept_ID INT NOT NULL,
    Supervisor_ID INT NULL,
    CONSTRAINT FK_Doctor_Department FOREIGN KEY (Dept_ID) 
        REFERENCES DEPARTMENT(Dept_ID),
    CONSTRAINT FK_Doctor_Supervisor FOREIGN KEY (Supervisor_ID) 
        REFERENCES DOCTOR(Doctor_ID)
);
GO

-- ============================================
-- Add Foreign Key to DEPARTMENT (after DOCTOR table exists)
-- ============================================
ALTER TABLE DEPARTMENT
ADD CONSTRAINT FK_Department_Manager FOREIGN KEY (Manager_ID) 
    REFERENCES DOCTOR(Doctor_ID);
GO

-- ============================================
-- TABLE 4: APPOINTMENT
-- ============================================
CREATE TABLE APPOINTMENT (
    APPT_ID INT IDENTITY(1,1) PRIMARY KEY,
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Scheduled' 
        CHECK (Status IN ('Scheduled', 'Completed', 'Cancelled', 'No-Show')),
    Appointment_type VARCHAR(30) NOT NULL 
        CHECK (Appointment_type IN ('Consultation', 'Follow-up', 'Emergency', 'Routine')),
    Reason VARCHAR(500),
    Patient_ID INT NOT NULL,
    Doctor_ID INT NOT NULL,
    CONSTRAINT FK_Appointment_Patient FOREIGN KEY (Patient_ID) 
        REFERENCES PATIENT(Patient_ID) ON DELETE CASCADE,
    CONSTRAINT FK_Appointment_Doctor FOREIGN KEY (Doctor_ID) 
        REFERENCES DOCTOR(Doctor_ID),
    CONSTRAINT UQ_Appointment_Booking UNIQUE (Patient_ID, Doctor_ID, Date, Time)
);
GO

-- ============================================
-- TABLE 5: SERVICE
-- ============================================
CREATE TABLE SERVICE (
    Service_ID INT IDENTITY(1,1) PRIMARY KEY,
    Service_name VARCHAR(100) NOT NULL,
    Service_type VARCHAR(50) NOT NULL 
        CHECK (Service_type IN ('Consultation', 'Lab Test', 'X-Ray', 'MRI', 'CT Scan', 'Surgery', 'Treatment', 'Therapy')),
    Unit_price DECIMAL(10, 2) NOT NULL CHECK (Unit_price >= 0),
    Description TEXT,
    Dept_ID INT NOT NULL,
    CONSTRAINT FK_Service_Department FOREIGN KEY (Dept_ID) 
        REFERENCES DEPARTMENT(Dept_ID)
);
GO

-- ============================================
-- TABLE 6: APP_SERVICE (Junction Table)
-- ============================================
CREATE TABLE APP_SERVICE (
    APPT_ID INT NOT NULL,
    Service_ID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1 CHECK (Quantity > 0),
    Subtotal DECIMAL(10, 2),
    CONSTRAINT PK_App_Service PRIMARY KEY (APPT_ID, Service_ID),
    CONSTRAINT FK_AppService_Appointment FOREIGN KEY (APPT_ID) 
        REFERENCES APPOINTMENT(APPT_ID) ON DELETE CASCADE,
    CONSTRAINT FK_AppService_Service FOREIGN KEY (Service_ID) 
        REFERENCES SERVICE(Service_ID)
);
GO

-- ============================================
-- TABLE 7: MEDICAL_RECORD
-- ============================================
CREATE TABLE MEDICAL_RECORD (
    Med_ID INT IDENTITY(1,1) PRIMARY KEY,
    Visit_date DATE NOT NULL DEFAULT GETDATE(),
    Diagnosis TEXT NOT NULL,
    Treatment_plan TEXT NOT NULL,
    Prescribed_medications TEXT,
    Doctor_notes TEXT,
    Follow_up_required BIT NOT NULL DEFAULT 0,
    APPT_ID INT NOT NULL UNIQUE,
    CONSTRAINT FK_MedicalRecord_Appointment FOREIGN KEY (APPT_ID) 
        REFERENCES APPOINTMENT(APPT_ID)
);
GO

-- ============================================
-- TABLE 8: BILLING
-- ============================================
CREATE TABLE BILLING (
    Bill_ID INT IDENTITY(1,1) PRIMARY KEY,
    Bill_date DATE NOT NULL DEFAULT GETDATE(),
    Total_amount DECIMAL(10, 2) NOT NULL CHECK (Total_amount >= 0),
    Payment_status VARCHAR(20) NOT NULL DEFAULT 'Pending' 
        CHECK (Payment_status IN ('Paid', 'Pending', 'Partial', 'Overdue')),
    Payment_method VARCHAR(30) 
        CHECK (Payment_method IN ('Cash', 'Card', 'Insurance', 'Bank Transfer', 'Online')),
    Due_date DATE NOT NULL,
    APPT_ID INT NOT NULL UNIQUE,
    Patient_ID INT NOT NULL,
    CONSTRAINT FK_Billing_Appointment FOREIGN KEY (APPT_ID) 
        REFERENCES APPOINTMENT(APPT_ID),
    CONSTRAINT FK_Billing_Patient FOREIGN KEY (Patient_ID) 
        REFERENCES PATIENT(Patient_ID),
    CONSTRAINT CHK_Billing_DueDate CHECK (Due_date >= Bill_date)
);
GO
SELECT * FROM BILLING

-- ============================================
-- CREATE TRIGGER FOR APP_SERVICE.Subtotal
-- ============================================
CREATE TRIGGER trg_APP_SERVICE_Subtotal
ON APP_SERVICE
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE APP_SERVICE
    SET Subtotal = i.Quantity * s.Unit_price
    FROM APP_SERVICE a
    INNER JOIN inserted i ON a.APPT_ID = i.APPT_ID AND a.Service_ID = i.Service_ID
    INNER JOIN SERVICE s ON a.Service_ID = s.Service_ID;
END;
GO

PRINT 'Database HospitalManagementSystem created successfully!';
GO
-- ============================================
-- End of Database Creation Script
-- ============================================

