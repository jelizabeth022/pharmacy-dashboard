-- 🚀 Insert Medicines (100+ entries)
INSERT INTO medicines (name, category, manufacturer, price, dosage, expiry_date, stock_quantity) VALUES
('Paracetamol', 'Pain Relief', 'ABC Pharma', 5.99, '500mg', '2026-05-01', 100),
('Ibuprofen', 'Pain Relief', 'XYZ Pharma', 8.50, '400mg', '2025-12-31', 50),
('Amoxicillin', 'Antibiotic', 'MediCare Inc.', 15.00, '250mg', '2026-10-10', 30);

DO $$
DECLARE i INT;
BEGIN
    FOR i IN 1..97 LOOP
        INSERT INTO medicines (name, category, manufacturer, price, dosage, expiry_date, stock_quantity)
        VALUES (
            'Medicine_' || i, 
            CASE WHEN i % 3 = 0 THEN 'Antibiotic' 
                 WHEN i % 3 = 1 THEN 'Pain Relief' 
                 ELSE 'Heart Health' END,
            'Manufacturer_' || i, 
            ROUND(CAST(RANDOM() * 20 + 5 AS NUMERIC), 2), 
            FLOOR(RANDOM() * 500) || 'mg', 
            CURRENT_DATE + INTERVAL '1 day' * CAST((i * 10) AS INTEGER), 
            FLOOR(RANDOM() * 100 + 1)
        );
    END LOOP;
END $$;

-- 🚀 Insert Suppliers (20+ entries)
INSERT INTO suppliers (name, contact_info, address) VALUES
('HealthCorp', '123-456-7890', '123 Health St, NY'),
('MediSupply', '987-654-3210', '456 Med Lane, LA');

DO $$
DECLARE i INT;
BEGIN
    FOR i IN 1..18 LOOP
        INSERT INTO suppliers (name, contact_info, address)
        VALUES ('Supplier_' || i, '555-000-' || i, 'Street ' || i || ', City_' || i);
    END LOOP;
END $$;

-- 🚀 Insert Customers (100+ entries)
INSERT INTO customers (name, contact_info, date_of_birth) VALUES
('John Doe', '555-123-4567', '1985-07-10'),
('Jane Smith', '555-987-6543', '1992-02-15');

DO $$
DECLARE i INT;
BEGIN
    FOR i IN 1..98 LOOP
        INSERT INTO customers (name, contact_info, date_of_birth)
        VALUES (
            'Customer_' || i, 
            '666-000-' || i, 
            CURRENT_DATE - INTERVAL '1 day' * CAST(FLOOR(RANDOM() * 15000 + 7000) AS INTEGER)
        );
    END LOOP;
END $$;

-- 🚀 Insert Inventory (100+ entries) - Ensuring Medicine & Supplier Exists
DO $$
DECLARE i INT;
DECLARE med_id INT;
DECLARE supp_id INT;
BEGIN
    FOR i IN 1..100 LOOP
        -- Select random medicine_id from the medicines table
        SELECT medicine_id INTO med_id FROM medicines ORDER BY RANDOM() LIMIT 1;

        -- Select random supplier_id from the suppliers table
        SELECT supplier_id INTO supp_id FROM suppliers ORDER BY RANDOM() LIMIT 1;

        -- Insert into inventory ensuring FK constraints are met
        INSERT INTO inventory (medicine_id, supplier_id, quantity, last_stock_update)
        VALUES (
            med_id, 
            supp_id, 
            FLOOR(RANDOM() * 200 + 10), 
            CURRENT_DATE - INTERVAL '1 day' * CAST(FLOOR(RANDOM() * 30) AS INTEGER)
        );
    END LOOP;
END $$;

-- 🚀 Insert Prescriptions (50+ entries)
DO $$
DECLARE i INT;
DECLARE cust_id INT;
DECLARE med_id INT;
BEGIN
    FOR i IN 1..50 LOOP
        -- Select random customer_id
        SELECT customer_id INTO cust_id FROM customers ORDER BY RANDOM() LIMIT 1;

        -- Select random medicine_id
        SELECT medicine_id INTO med_id FROM medicines ORDER BY RANDOM() LIMIT 1;

        INSERT INTO prescriptions (customer_id, medicine_id, doctor_name, prescribed_date, dosage_instructions)
        VALUES (
            cust_id,
            med_id,
            'Dr. ' || chr(65 + CAST(FLOOR(RANDOM() * 26) AS INTEGER)) || ' Smith',  -- ✅ Fixed chr() issue
            CURRENT_DATE - INTERVAL '1 day' * CAST(FLOOR(RANDOM() * 60) AS INTEGER),
            'Take ' || FLOOR(RANDOM() * 3 + 1) || ' tablets daily'
        );
    END LOOP;
END $$;
                      
-- 🚀 Insert Sales Transactions (100+ entries)
DO $$
DECLARE i INT;
DECLARE cust_id INT;
DECLARE med_id INT;
BEGIN
    FOR i IN 1..100 LOOP
        -- Select random customer_id
        SELECT customer_id INTO cust_id FROM customers ORDER BY RANDOM() LIMIT 1;

        -- Select random medicine_id
        SELECT medicine_id INTO med_id FROM medicines ORDER BY RANDOM() LIMIT 1;

        INSERT INTO sales (medicine_id, customer_id, quantity, total_price, sale_date)
        VALUES (
            med_id,
            cust_id,
            FLOOR(RANDOM() * 5 + 1),
            ROUND(CAST(RANDOM() * 50 + 5 AS NUMERIC), 2),
            CURRENT_DATE - INTERVAL '1 day' * CAST(FLOOR(RANDOM() * 30) AS INTEGER)
        );
    END LOOP;
END $$;
