# Complaint Management System (CMS)

## Overview
This project is a simple Complaint Management System built using Java Servlets, JSP, and JDBC. It allows users to log in, file complaints, and administrators to manage those complaints (view, update status, delete).

---

## Database Configuration

### Database Schema
- **Table: users**
    - `id` INT PRIMARY KEY AUTO_INCREMENT
    - `email` VARCHAR(100) UNIQUE NOT NULL
    - `password` VARCHAR(100) NOT NULL
    - `role` VARCHAR(20) NOT NULL (e.g., admin, user)
    - `status` VARCHAR(20) DEFAULT 'active'

- **Table: complaints**
    - `id` INT PRIMARY KEY AUTO_INCREMENT
    - `user_id` INT NOT NULL (Foreign key referencing `users.id`)
    - `title` VARCHAR(255) NOT NULL
    - `description` TEXT NOT NULL
    - `status` VARCHAR(20) DEFAULT 'Pending'  (Pending, In Progress, Resolved)
    - `remarks` TEXT NULL
    - `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP

### Sample Insert Data
```sql
INSERT INTO users (email, password, role, status) VALUES
('admin@example.com', 'admin123', 'admin', 'active'),
('user1@example.com', 'user123', 'user', 'active');

INSERT INTO complaints (user_id, title, description, status) VALUES
(2, 'Internet not working', 'My internet has been down for 3 days', 'Pending');
````

## Running the Project

- Import the project into IntelliJ IDEA.
- Configure your application server (Tomcat, Jetty, etc.).
- Make sure the database is running and accessible.
- Deploy the project on the server.
- Access the login page at `http://localhost:8080/your-app-context/view/login.jsp`.
- Use admin or user credentials to log in and test functionalities.

---

## Features

- User login with role-based access (admin/user).
- Admin dashboard to view, update, and delete complaints.
- Session management with logout functionality.
- Basic form validations and session timeout handling.
- JSP pages styled with CSS.
- Optional alert dialogs for user feedback (can be enhanced with libraries like SweetAlert2).

---





