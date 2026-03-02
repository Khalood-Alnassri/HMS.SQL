-- ============================================
-- Hospital Management System - Sample Data Insertion
-- ============================================

USE HospitalManagementSystem;
GO

-- ============================================
-- TABLE 1: PATIENT (20 patients)
-- ============================================
INSERT INTO PATIENT (F_name, L_name, Phone_no, Email, Address, DOB, Blood_group, Gender)
VALUES
('Ahmed', 'Hassan', '0101234567', 'ahmed.hassan@email.com', '123 Nile St, Cairo', '1985-03-15', 'A+', 'M'),
('Fatma', 'Ali', '0102345678', 'fatma.ali@email.com', '456 Pyramids Ave, Giza', '1990-07-22', 'B+', 'F'),
('Mohamed', 'Ibrahim', '0103456789', 'mohamed.ibrahim@email.com', '789 Tahrir Sq, Cairo', '1978-11-30', 'O+', 'M'),
('Layla', 'Mahmoud', '0104567890', 'layla.mahmoud@email.com', '321 Alex Rd, Alexandria', '1995-02-14', 'AB+', 'F'),
('Omar', 'Farouk', '0105678901', 'omar.farouk@email.com', '654 Port Said St, Suez', '1982-09-08', 'A-', 'M'),
('Nour', 'Salem', '0106789012', 'nour.salem@email.com', '987 Heliopolis Ave, Cairo', '1988-05-19', 'B-', 'F'),
('Khaled', 'Youssef', '0107890123', 'khaled.youssef@email.com', '147 Maadi St, Cairo', '1975-12-25', 'O-', 'M'),
('Mariam', 'Adel', '0108901234', 'mariam.adel@email.com', '258 Zamalek Rd, Cairo', '1992-04-10', 'AB-', 'F'),
('Youssef', 'Kamal', '0109012345', 'youssef.kamal@email.com', '369 Nasr City, Cairo', '1980-08-17', 'A+', 'M'),
('Sara', 'Mostafa', '0100123456', 'sara.mostafa@email.com', '741 Dokki St, Giza', '1998-01-05', 'B+', 'F'),
('Tarek', 'Hosny', '0111234567', 'tarek.hosny@email.com', '852 Garden City, Cairo', '1987-06-28', 'O+', 'M'),
('Hala', 'Nabil', '0112345678', 'hala.nabil@email.com', '963 Mohandessin, Giza', '1993-10-12', 'A-', 'F'),
('Amr', 'Sayed', '0113456789', 'amr.sayed@email.com', '159 Shubra, Cairo', '1977-03-20', 'AB+', 'M'),
('Dina', 'Rashid', '0114567890', 'dina.rashid@email.com', '357 Abbasia, Cairo', '1991-09-15', 'B-', 'F'),
('Mahmoud', 'Zaki', '0115678901', 'mahmoud.zaki@email.com', '486 Masr El Gedida, Cairo', '1984-07-03', 'O-', 'M'),
('Rana', 'Galal', '0116789012', 'rana.galal@email.com', '753 New Cairo', '1996-11-22', 'A+', 'F'),
('Sherif', 'Amin', '0117890123', 'sherif.amin@email.com', '951 6th October, Giza', '1979-02-09', 'B+', 'M'),
('Heba', 'Fathi', '0118901234', 'heba.fathi@email.com', '246 Sheikh Zayed, Giza', '1994-05-30', 'O+', 'F'),
('Karim', 'Nasser', '0119012345', 'karim.nasser@email.com', '135 Obour City, Cairo', '1986-12-18', 'AB-', 'M'),
('Noha', 'Refaat', '0120123456', 'noha.refaat@email.com', '864 Shorouk City, Cairo', '1989-08-07', 'A-', 'F');
GO

-- ============================================
-- TABLE 2: DEPARTMENT (5 departments)
-- Manager_ID will be set to NULL initially
-- ============================================
INSERT INTO DEPARTMENT (Dept_name, Location, No_of_doctors, Contact_number, Manager_ID)
VALUES
('Cardiology', 'Building A - Floor 2', 4, '0221234567', NULL),
('Neurology', 'Building B - Floor 3', 3, '0221234568', NULL),
('Orthopedics', 'Building C - Floor 1', 4, '0221234569', NULL),
('Pediatrics', 'Building A - Floor 1', 5, '0221234570', NULL),
('Radiology', 'Building D - Ground Floor', 4, '0221234571', NULL);
GO

-- ============================================
-- TABLE 3: DOCTOR (10 doctors)
-- 5 will be managers, some will be supervisors
-- ============================================
INSERT INTO DOCTOR (Name, Specialization, Phone_no, Email, License_no, Qualification, Years_of_experience, Dept_ID, Supervisor_ID)
VALUES
-- Cardiology Department (Dept_ID = 1)
('Dr. Hossam Helmy', 'Cardiologist', '0501234567', 'hossam.helmy@hospital.com', 'LIC001', 'MD, FACC', 15, 1, NULL),
('Dr. Mona Samir', 'Interventional Cardiologist', '0501234568', 'mona.samir@hospital.com', 'LIC002', 'MD, FSCAI', 8, 1, 1),

-- Neurology Department (Dept_ID = 2)
('Dr. Ashraf Fouad', 'Neurologist', '0501234569', 'ashraf.fouad@hospital.com', 'LIC003', 'MD, PhD Neurology', 20, 2, NULL),
('Dr. Salma Ahmed', 'Pediatric Neurologist', '0501234570', 'salma.ahmed@hospital.com', 'LIC004', 'MD, Fellowship', 6, 2, 3),

-- Orthopedics Department (Dept_ID = 3)
('Dr. Wael Mansour', 'Orthopedic Surgeon', '0501234571', 'wael.mansour@hospital.com', 'LIC005', 'MD, FRCS', 18, 3, NULL),
('Dr. Eman Lotfy', 'Sports Medicine', '0501234572', 'eman.lotfy@hospital.com', 'LIC006', 'MD, Fellowship', 10, 3, 5),

-- Pediatrics Department (Dept_ID = 4)
('Dr. Sameh Khalil', 'Pediatrician', '0501234573', 'sameh.khalil@hospital.com', 'LIC007', 'MD, FAAP', 12, 4, NULL),
('Dr. Nesma Gamal', 'Neonatologist', '0501234574', 'nesma.gamal@hospital.com', 'LIC008', 'MD, Neonatology', 7, 4, 7),

-- Radiology Department (Dept_ID = 5)
('Dr. Tamer Sobhy', 'Radiologist', '0501234575', 'tamer.sobhy@hospital.com', 'LIC009', 'MD, DABR', 14, 5, NULL),
('Dr. Rania Essam', 'Interventional Radiologist', '0501234576', 'rania.essam@hospital.com', 'LIC010', 'MD, Fellowship', 9, 5, 9);
GO

-- ============================================
-- UPDATE DEPARTMENT - Set Manager_ID
-- ============================================
UPDATE DEPARTMENT SET Manager_ID = 1 WHERE Dept_ID = 1; -- Dr. Hossam Helmy manages Cardiology
UPDATE DEPARTMENT SET Manager_ID = 3 WHERE Dept_ID = 2; -- Dr. Ashraf Fouad manages Neurology
UPDATE DEPARTMENT SET Manager_ID = 5 WHERE Dept_ID = 3; -- Dr. Wael Mansour manages Orthopedics
UPDATE DEPARTMENT SET Manager_ID = 7 WHERE Dept_ID = 4; -- Dr. Sameh Khalil manages Pediatrics
UPDATE DEPARTMENT SET Manager_ID = 9 WHERE Dept_ID = 5; -- Dr. Tamer Sobhy manages Radiology
GO

-- ============================================
-- TABLE 4: SERVICE (20 services distributed across departments)
-- ============================================
INSERT INTO SERVICE (Service_name, Service_type, Unit_price, Description, Dept_ID)
VALUES
-- Cardiology Services (Dept_ID = 1)
('ECG Test', 'Lab Test', 150.00, 'Electrocardiogram test', 1),
('Echocardiogram', 'Lab Test', 800.00, 'Ultrasound of the heart', 1),
('Stress Test', 'Lab Test', 600.00, 'Cardiac stress testing', 1),
('Cardiac Catheterization', 'Surgery', 15000.00, 'Invasive cardiac procedure', 1),

-- Neurology Services (Dept_ID = 2)
('EEG Test', 'Lab Test', 500.00, 'Electroencephalogram', 2),
('Brain MRI', 'MRI', 2500.00, 'Magnetic Resonance Imaging of brain', 2),
('Nerve Conduction Study', 'Lab Test', 700.00, 'Nerve function test', 2),

-- Orthopedics Services (Dept_ID = 3)
('X-Ray (Bone)', 'X-Ray', 200.00, 'Bone X-Ray imaging', 3),
('CT Scan (Bone)', 'CT Scan', 1200.00, 'Computed Tomography for bones', 3),
('Arthroscopy', 'Surgery', 12000.00, 'Joint surgery procedure', 3),
('Physical Therapy Session', 'Therapy', 300.00, 'Rehabilitation session', 3),

-- Pediatrics Services (Dept_ID = 4)
('Pediatric Consultation', 'Consultation', 250.00, 'General pediatric checkup', 4),
('Vaccination', 'Treatment', 180.00, 'Childhood immunization', 4),
('Growth Assessment', 'Consultation', 200.00, 'Child development evaluation', 4),
('Pediatric Blood Test', 'Lab Test', 350.00, 'Complete blood count for children', 4),

-- Radiology Services (Dept_ID = 5)
('Chest X-Ray', 'X-Ray', 180.00, 'Chest radiography', 5),
('Abdominal Ultrasound', 'Lab Test', 600.00, 'Ultrasound of abdomen', 5),
('Full Body CT Scan', 'CT Scan', 3500.00, 'Comprehensive CT imaging', 5),
('Mammography', 'X-Ray', 450.00, 'Breast cancer screening', 5),
('Interventional Radiology', 'Surgery', 8000.00, 'Image-guided procedures', 5);
GO

-- ============================================
-- TABLE 5: APPOINTMENT (40 appointments)
-- Various states, different doctors, some patients have multiple appointments
-- ============================================
INSERT INTO APPOINTMENT (Date, Time, Status, Appointment_type, Reason, Patient_ID, Doctor_ID)
VALUES
-- Completed appointments (past dates)
('2024-01-15', '09:00:00', 'Completed', 'Consultation', 'Chest pain evaluation', 1, 1),
('2024-01-16', '10:30:00', 'Completed', 'Follow-up', 'Post-surgery checkup', 2, 5),
('2024-01-17', '11:00:00', 'Completed', 'Consultation', 'Headache and dizziness', 3, 3),
('2024-01-18', '14:00:00', 'Completed', 'Routine', 'Annual physical exam', 4, 7),
('2024-01-19', '15:30:00', 'Completed', 'Emergency', 'Severe back pain', 5, 5),
('2024-01-20', '09:30:00', 'Completed', 'Consultation', 'Heart palpitations', 6, 2),
('2024-01-22', '10:00:00', 'Completed', 'Follow-up', 'Medication review', 1, 1),
('2024-01-23', '13:00:00', 'Completed', 'Consultation', 'Child fever and cough', 7, 7),
('2024-01-24', '08:30:00', 'Completed', 'Routine', 'Diabetes checkup', 8, 1),
('2024-01-25', '16:00:00', 'Completed', 'Consultation', 'Knee injury', 9, 6),
('2024-01-26', '11:30:00', 'Completed', 'Emergency', 'Chest pain', 10, 1),
('2024-01-27', '14:30:00', 'Completed', 'Follow-up', 'Post-treatment review', 3, 3),
('2024-01-29', '09:00:00', 'Completed', 'Consultation', 'Migraine symptoms', 11, 4),
('2024-01-30', '10:30:00', 'Completed', 'Routine', 'Baby vaccination', 12, 8),
('2024-02-01', '15:00:00', 'Completed', 'Consultation', 'Shoulder pain', 13, 5),
('2024-02-02', '08:00:00', 'Completed', 'Follow-up', 'Cardiac follow-up', 1, 2),
('2024-02-03', '12:00:00', 'Completed', 'Consultation', 'Numbness in hands', 14, 3),
('2024-02-05', '13:30:00', 'Completed', 'Routine', 'Annual checkup', 15, 9),
('2024-02-06', '09:30:00', 'Completed', 'Consultation', 'Child growth concern', 16, 7),
('2024-02-07', '14:00:00', 'Completed', 'Follow-up', 'Physical therapy progress', 9, 6),
('2024-02-08', '11:00:00', 'Completed', 'Emergency', 'Severe headache', 17, 4),
('2024-02-10', '10:00:00', 'Completed', 'Consultation', 'Abdominal pain', 18, 9),
('2024-02-11', '15:30:00', 'Completed', 'Routine', 'Blood pressure monitoring', 6, 2),
('2024-02-12', '08:30:00', 'Completed', 'Follow-up', 'Orthopedic follow-up', 5, 5),
('2024-02-13', '16:00:00', 'Completed', 'Consultation', 'Sleep disorder', 19, 3),

-- Scheduled appointments (future dates)
('2024-03-01', '09:00:00', 'Scheduled', 'Consultation', 'Routine cardiac checkup', 2, 1),
('2024-03-02', '10:30:00', 'Scheduled', 'Follow-up', 'Neurology follow-up', 3, 4),
('2024-03-03', '11:00:00', 'Scheduled', 'Routine', 'Pediatric checkup', 7, 8),
('2024-03-04', '14:00:00', 'Scheduled', 'Consultation', 'Joint pain evaluation', 13, 6),
('2024-03-05', '15:30:00', 'Scheduled', 'Follow-up', 'Post-imaging consultation', 18, 10),

-- Cancelled appointments
('2024-02-15', '09:30:00', 'Cancelled', 'Consultation', 'General checkup', 10, 7),
('2024-02-16', '13:00:00', 'Cancelled', 'Routine', 'Blood test', 11, 9),

-- No-Show appointments
('2024-02-17', '08:00:00', 'No-Show', 'Consultation', 'Back pain', 12, 5),
('2024-02-18', '14:30:00', 'No-Show', 'Follow-up', 'Treatment review', 14, 3),

-- Additional completed appointments for same patients
('2024-02-14', '10:00:00', 'Completed', 'Follow-up', 'Heart condition monitoring', 1, 1),
('2024-02-19', '11:30:00', 'Completed', 'Consultation', 'Bone fracture review', 5, 6),
('2024-02-20', '15:00:00', 'Completed', 'Follow-up', 'Neurological assessment', 3, 3),
('2024-02-21', '09:00:00', 'Completed', 'Routine', 'Child wellness visit', 7, 7),
('2024-02-22', '13:30:00', 'Completed', 'Consultation', 'Radiology consultation', 18, 9),
('2024-02-23', '16:00:00', 'Completed', 'Follow-up', 'Therapy progress check', 9, 5);
GO

-- ============================================
-- TABLE 6: MEDICAL_RECORD (40 records for completed appointments only)
-- Only for appointments with status 'Completed'
-- ============================================
INSERT INTO MEDICAL_RECORD (Visit_date, Diagnosis, Treatment_plan, Prescribed_medications, Doctor_notes, Follow_up_required, APPT_ID)
VALUES
('2024-01-15', 'Angina Pectoris', 'Medication therapy and lifestyle changes', 'Aspirin 75mg, Atorvastatin 20mg', 'Patient advised to reduce stress and monitor BP', 1, 1),
('2024-01-16', 'Post-surgical recovery normal', 'Continue physiotherapy', 'Ibuprofen 400mg as needed', 'Healing progressing well', 1, 2),
('2024-01-17', 'Tension Headache', 'Stress management and hydration', 'Paracetamol 500mg', 'Recommend regular sleep schedule', 1, 3),
('2024-01-18', 'Healthy - Annual checkup', 'Maintain current health regimen', 'Multivitamin daily', 'All vitals normal', 0, 4),
('2024-01-19', 'Lumbar Strain', 'Rest, ice therapy, and pain management', 'Diclofenac 50mg, Muscle relaxant', 'Avoid heavy lifting for 2 weeks', 1, 5),
('2024-01-20', 'Premature Ventricular Contractions', 'Monitor heart rhythm, reduce caffeine', 'Beta-blocker 25mg', 'Consider Holter monitor if symptoms persist', 1, 6),
('2024-01-22', 'Hypertension - controlled', 'Continue current medication', 'Lisinopril 10mg, Aspirin 75mg', 'Blood pressure improving', 1, 7),
('2024-01-23', 'Upper Respiratory Infection', 'Symptomatic treatment, rest', 'Amoxicillin 250mg, Cough syrup', 'Keep child hydrated', 1, 8),
('2024-01-24', 'Type 2 Diabetes - managed', 'Diet control and medication compliance', 'Metformin 500mg twice daily', 'HbA1c levels acceptable', 1, 9),
('2024-01-25', 'Meniscus Tear', 'Arthroscopic surgery recommended', 'Pain medication as needed', 'Schedule surgery within 2 weeks', 1, 10),
('2024-01-26', 'Acute Coronary Syndrome', 'Immediate cardiac catheterization', 'Emergency cardiac protocol', 'Patient stabilized, admitted to CCU', 1, 11),
('2024-01-27', 'Migraine - improving', 'Continue preventive medication', 'Sumatriptan 50mg as needed', 'Frequency reduced significantly', 1, 12),
('2024-01-29', 'Chronic Migraine', 'Preventive therapy initiated', 'Topiramate 50mg daily', 'Patient to maintain headache diary', 1, 13),
('2024-01-30', 'Healthy infant - immunization', 'Routine vaccination completed', 'None', 'Growth and development normal', 0, 14),
('2024-02-01', 'Rotator Cuff Injury', 'Physical therapy 3x weekly', 'NSAIDs, Ice therapy', 'Avoid overhead activities', 1, 15),
('2024-02-02', 'Stable Angina', 'Optimize medical therapy', 'Increased Atorvastatin to 40mg', 'Exercise tolerance improved', 1, 16),
('2024-02-03', 'Carpal Tunnel Syndrome', 'Wrist splinting, consider surgery if no improvement', 'Vitamin B complex', 'Nerve conduction study recommended', 1, 17),
('2024-02-05', 'Healthy - routine screening', 'Continue healthy lifestyle', 'None', 'All laboratory results normal', 0, 18),
('2024-02-06', 'Growth delay - mild', 'Nutritional counseling, monitor growth', 'Multivitamin with iron', 'Recheck in 3 months', 1, 19),
('2024-02-07', 'Knee rehabilitation progressing', 'Continue therapy protocol', 'None', 'Range of motion improving', 1, 20),
('2024-02-08', 'Cluster Headache', 'Oxygen therapy, preventive medication', 'Verapamil 80mg, Oxygen as needed', 'Emergency plan discussed', 1, 21),
('2024-02-10', 'Gastritis', 'Dietary modification, PPI therapy', 'Omeprazole 20mg daily', 'Avoid spicy foods and NSAIDs', 1, 22),
('2024-02-11', 'Hypertension - well controlled', 'Continue current regimen', 'No changes', 'Blood pressure at goal', 1, 23),
('2024-02-12', 'Post-operative - healing well', 'Remove sutures next visit', 'None', 'No signs of infection', 1, 24),
('2024-02-13', 'Insomnia - chronic', 'Sleep hygiene education, CBT', 'Melatonin 3mg at bedtime', 'Avoid screens before bed', 1, 25),
('2024-02-14', 'Coronary Artery Disease - stable', 'Continue cardiac rehabilitation', 'Current medications maintained', 'Exercise tolerance excellent', 1, 35),
('2024-02-19', 'Healed fracture - tibial', 'Gradual return to activities', 'Calcium and Vitamin D', 'X-ray shows complete healing', 0, 36),
('2024-02-20', 'Peripheral Neuropathy', 'Medication adjustment, physical therapy', 'Gabapentin 300mg increased to 600mg', 'Symptoms moderately improved', 1, 37),
('2024-02-21', 'Healthy child - wellness visit', 'Routine care, vaccination schedule reviewed', 'None', 'Development milestones met', 0, 38),
('2024-02-22', 'Liver cyst - benign', 'Observation, no treatment needed', 'None', 'Annual imaging recommended', 1, 39),
('2024-02-23', 'Post-therapy assessment', 'Discharge from physical therapy', 'Home exercise program', 'Functional goals achieved', 0, 40);
GO

-- ============================================
-- TABLE 7: BILLING (40 bills for all 40 appointments)
-- ============================================
INSERT INTO BILLING (Bill_date, Total_amount, Payment_status, Payment_method, Due_date, APPT_ID, Patient_ID)
VALUES
('2024-01-15', 950.00, 'Paid', 'Card', '2024-01-30', 1, 1),
('2024-01-16', 300.00, 'Paid', 'Cash', '2024-01-31', 2, 2),
('2024-01-17', 500.00, 'Paid', 'Insurance', '2024-02-01', 3, 3),
('2024-01-18', 250.00, 'Paid', 'Card', '2024-02-02', 4, 4),
('2024-01-19', 1400.00, 'Paid', 'Insurance', '2024-02-03', 5, 5),
('2024-01-20', 800.00, 'Partial', 'Cash', '2024-02-04', 6, 6),
('2024-01-22', 150.00, 'Paid', 'Card', '2024-02-06', 7, 1),
('2024-01-23', 430.00, 'Paid', 'Insurance', '2024-02-07', 8, 7),
('2024-01-24', 150.00, 'Paid', 'Card', '2024-02-08', 9, 8),
('2024-01-25', 12500.00, 'Pending', 'Insurance', '2024-02-09', 10, 9),
('2024-01-26', 15800.00, 'Paid', 'Insurance', '2024-02-10', 11, 10),
('2024-01-27', 500.00, 'Paid', 'Cash', '2024-02-11', 12, 3),
('2024-01-29', 500.00, 'Paid', 'Card', '2024-02-13', 13, 11),
('2024-01-30', 180.00, 'Paid', 'Cash', '2024-02-14', 14, 12),
('2024-02-01', 500.00, 'Paid', 'Insurance', '2024-02-16', 15, 13),
('2024-02-02', 800.00, 'Paid', 'Card', '2024-02-17', 16, 1),
('2024-02-03', 700.00, 'Pending', NULL, '2024-02-18', 17, 14),
('2024-02-05', 780.00, 'Paid', 'Insurance', '2024-02-20', 18, 15),
('2024-02-06', 450.00, 'Paid', 'Cash', '2024-02-21', 19, 16),
('2024-02-07', 300.00, 'Paid', 'Card', '2024-02-22', 20, 9),
('2024-02-08', 500.00, 'Paid', 'Insurance', '2024-02-23', 21, 17),
('2024-02-10', 850.00, 'Paid', 'Card', '2024-02-25', 22, 18),
('2024-02-11', 150.00, 'Paid', 'Cash', '2024-02-26', 23, 6),
('2024-02-12', 200.00, 'Paid', 'Card', '2024-02-27', 24, 5),
('2024-02-13', 500.00, 'Overdue', NULL, '2024-02-20', 25, 19),
('2024-03-01', 950.00, 'Pending', NULL, '2024-03-15', 26, 2),
('2024-03-02', 500.00, 'Pending', NULL, '2024-03-16', 27, 3),
('2024-03-03', 250.00, 'Pending', NULL, '2024-03-17', 28, 7),
('2024-03-04', 500.00, 'Pending', NULL, '2024-03-18', 29, 13),
('2024-03-05', 600.00, 'Pending', NULL, '2024-03-19', 30, 18),
('2024-02-15', 250.00, 'Pending', NULL, '2024-03-01', 31, 10),
('2024-02-16', 350.00, 'Pending', NULL, '2024-03-02', 32, 11),
('2024-02-17', 200.00, 'Overdue', NULL, '2024-02-24', 33, 12),
('2024-02-18', 500.00, 'Overdue', NULL, '2024-02-25', 34, 14),
('2024-02-14', 950.00, 'Paid', 'Insurance', '2024-02-28', 35, 1),
('2024-02-19', 500.00, 'Paid', 'Card', '2024-03-05', 36, 5),
('2024-02-20', 500.00, 'Paid', 'Insurance', '2024-03-06', 37, 3),
('2024-02-21', 250.00, 'Paid', 'Cash', '2024-03-07', 38, 7),
('2024-02-22', 600.00, 'Paid', 'Card', '2024-03-08', 39, 18),
('2024-02-23', 300.00, 'Paid', 'Insurance', '2024-03-09', 40, 9);
GO

-- ============================================
-- TABLE 8: APP_SERVICE (Services for appointments)
-- Distributed across the 40 appointments
-- ============================================
INSERT INTO APP_SERVICE (APPT_ID, Service_ID, Quantity)
VALUES
-- Appointment 1 (Cardiology)
(1, 1, 1),  -- ECG Test
(1, 2, 1),  -- Echocardiogram

-- Appointment 2 (Orthopedics)
(2, 11, 1), -- Physical Therapy Session

-- Appointment 3 (Neurology)
(3, 5, 1),  -- EEG Test

-- Appointment 4 (Pediatrics)
(4, 12, 1), -- Pediatric Consultation

-- Appointment 5 (Orthopedics)
(5, 8, 2),  -- X-Ray (Bone)
(5, 11, 1), -- Physical Therapy Session

-- Appointment 6 (Cardiology)
(6, 2, 1),  -- Echocardiogram

-- Appointment 7 (Cardiology)
(7, 1, 1),  -- ECG Test

-- Appointment 8 (Pediatrics)
(8, 12, 1), -- Pediatric Consultation
(8, 15, 1), -- Pediatric Blood Test

-- Appointment 9 (Cardiology)
(9, 1, 1),  -- ECG Test

-- Appointment 10 (Orthopedics)
(10, 9, 1), -- CT Scan (Bone)
(10, 10, 1),-- Arthroscopy

-- Appointment 11 (Cardiology)
(11, 1, 1), -- ECG Test
(11, 2, 1), -- Echocardiogram
(11, 4, 1), -- Cardiac Catheterization

-- Appointment 12 (Neurology)
(12, 5, 1), -- EEG Test

-- Appointment 13 (Neurology)
(13, 5, 1), -- EEG Test

-- Appointment 14 (Pediatrics)
(14, 13, 1),-- Vaccination

-- Appointment 15 (Orthopedics)
(15, 8, 1), -- X-Ray (Bone)
(15, 11, 2),-- Physical Therapy Session

-- Appointment 16 (Cardiology)
(16, 2, 1), -- Echocardiogram

-- Appointment 17 (Neurology)
(17, 7, 1), -- Nerve Conduction Study

-- Appointment 18 (Radiology)
(18, 16, 1),-- Chest X-Ray
(18, 17, 1),-- Abdominal Ultrasound

-- Appointment 19 (Pediatrics)
(19, 14, 1),-- Growth Assessment

-- Appointment 20 (Orthopedics)
(20, 11, 1),-- Physical Therapy Session

-- Appointment 21 (Neurology)
(21, 5, 1), -- EEG Test

-- Appointment 22 (Radiology)
(22, 17, 1),-- Abdominal Ultrasound

-- Appointment 23 (Cardiology)
(23, 1, 1), -- ECG Test

-- Appointment 24 (Orthopedics)
(24, 8, 1), -- X-Ray (Bone)

-- Appointment 25 (Neurology)
(25, 5, 1), -- EEG Test

-- Appointment 26 (Cardiology)
(26, 1, 1), -- ECG Test
(26, 2, 1), -- Echocardiogram

-- Appointment 27 (Neurology)
(27, 5, 1), -- EEG Test

-- Appointment 28 (Pediatrics)
(28, 12, 1),-- Pediatric Consultation

-- Appointment 29 (Orthopedics)
(29, 8, 1), -- X-Ray (Bone)
(29, 11, 2),-- Physical Therapy Session

-- Appointment 30 (Radiology)
(30, 17, 1),-- Abdominal Ultrasound

-- Appointment 31 (Pediatrics)
(31, 12, 1),-- Pediatric Consultation

-- Appointment 32 (Radiology)
(32, 15, 1),-- Pediatric Blood Test

-- Appointment 33 (Orthopedics)
(33, 8, 1), -- X-Ray (Bone)

-- Appointment 34 (Neurology)
(34, 5, 1), -- EEG Test

-- Appointment 35 (Cardiology)
(35, 1, 1), -- ECG Test
(35, 2, 1), -- Echocardiogram

-- Appointment 36 (Orthopedics)
(36, 8, 1), -- X-Ray (Bone)
(36, 11, 2),-- Physical Therapy Session

-- Appointment 37 (Neurology)
(37, 5, 1), -- EEG Test

-- Appointment 38 (Pediatrics)
(38, 12, 1),-- Pediatric Consultation

-- Appointment 39 (Radiology)
(39, 17, 1),-- Abdominal Ultrasound

-- Appointment 40 (Orthopedics)
(40, 11, 1);-- Physical Therapy Session
GO

-- ============================================
-- End of Data Insertion Script
-- ============================================