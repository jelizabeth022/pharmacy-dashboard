-- Medicines Table
CREATE TABLE medicines (
    medicine_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    manufacturer VARCHAR(255),
    price DECIMAL(10,2) CHECK (price >= 0),
    dosage VARCHAR(50),
    expiry_date DATE CHECK (expiry_date > CURRENT_DATE),
    stock_quantity INT CHECK (stock_quantity >= 0)
);

-- Suppliers Table
CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    contact_info VARCHAR(255),
    address TEXT
);

-- Inventory Table
CREATE TABLE inventory (
    inventory_id SERIAL PRIMARY KEY,
    medicine_id INT REFERENCES medicines(medicine_id) ON DELETE CASCADE,
    supplier_id INT REFERENCES suppliers(supplier_id) ON DELETE SET NULL,
    quantity INT CHECK (quantity >= 0),
    last_stock_update DATE DEFAULT CURRENT_DATE
);

-- Customers Table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_info VARCHAR(255) UNIQUE,
    date_of_birth DATE CHECK (date_of_birth < CURRENT_DATE)
);

-- Prescriptions Table
CREATE TABLE prescriptions (
    prescription_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id) ON DELETE CASCADE,
    medicine_id INT REFERENCES medicines(medicine_id) ON DELETE CASCADE,
    doctor_name VARCHAR(255),
    prescribed_date DATE DEFAULT CURRENT_DATE,
    dosage_instructions TEXT
);

-- Sales Table
CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    medicine_id INT REFERENCES medicines(medicine_id) ON DELETE CASCADE,
    customer_id INT REFERENCES customers(customer_id) ON DELETE SET NULL,
    quantity INT CHECK (quantity > 0),
    total_price DECIMAL(10,2) CHECK (total_price >= 0),
    sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
