# NexCart - Java E-Commerce Website

A dynamic Java-based e-commerce web application built with Servlets, JSP, JDBC, MySQL, and Apache Tomcat. NexCart provides a complete shopping experience for customers, an admin panel for store management, and an AI-style support chatbot for common customer queries.

## Overview

NexCart follows the Model-View-Controller (MVC) architecture. Customers can browse products, filter/search the catalog, manage their cart, place orders, and view order history. Administrators can manage products, stock, users, and order statuses. The chatbot module helps users with quick answers about products, carts, orders, returns, cancellations, delivery, checkout, and account actions.

## Features

### Customer Features
- User registration and login
- Product catalog with search, category, price, stock, and sorting filters
- Shopping cart add, update, and remove actions
- Checkout and order placement
- Order history and cancellation support
- AI-style chatbot support page

### AI Chatbot Module
- Chat page available at `/chat`
- Handles both `GET /chat` and `POST /chat`
- Uses a rule-based assistant module for fast support replies
- Supports prompts about:
  - Products and categories
  - Cart and quantity changes
  - Checkout and payment
  - Orders, history, tracking, and status
  - Returns, refunds, and exchanges
  - Cancellations
  - Delivery and shipping
  - Login, registration, and accounts
- Escapes user input before displaying it on the JSP page

Example chatbot prompts:

```text
What is the return policy?
Can I get a refund?
Can I exchange clothes?
How do I cancel my order?
Where is my order history?
How can I track my order status?
How do I add products to cart?
How do I change quantity in cart?
Show me product categories.
How do I search products?
How do I checkout?
How do I pay?
What about delivery?
How do I login?
How do I register?
```

### Admin Features
- Admin dashboard with store statistics
- Product create, read, update, and delete operations
- Inventory and stock management
- User management
- Order status management
- Admin password change and logout

## Tech Stack

| Component | Technology |
|-----------|------------|
| Backend | Java Servlets, JSP |
| Frontend | HTML, CSS, JavaScript, Bootstrap |
| Server | Apache Tomcat 10.1 |
| Database | MySQL |
| Database Access | JDBC |
| JDBC Driver | MySQL Connector/J 9.7.0 |
| Architecture | MVC |

## Project Structure

```text
E-Commerce-Website/
|
|-- index.jsp                              # Entry point / Home page
|
|-- View/                                  # View layer - JSP pages
|   |-- chat.jsp                           # AI chatbot support page
|   |-- login.jsp                          # User login page
|   |-- register.jsp                       # User registration page
|   |-- products.jsp                       # Product listing and search page
|   |-- cart.jsp                           # Shopping cart page
|   |-- checkout.jsp                       # Checkout / order placement page
|   |-- orders.jsp                         # User order history page
|   |
|   |-- includes/                          # Shared JSP includes
|   |   |-- header.jsp                      # Shared navigation header
|   |   `-- footer.jsp                      # Shared footer
|   |
|   `-- admin/                             # Admin panel JSP pages
|       |-- login.jsp                       # Admin login page
|       |-- dashboard.jsp                   # Admin dashboard page
|       |-- products.jsp                    # Admin product management page
|       |-- product-form.jsp                # Add/Edit product form
|       |-- orders.jsp                      # Admin order management page
|       |-- users.jsp                       # Admin user management page
|       |-- user-form.jsp                   # Add/Edit user form
|       `-- change-password.jsp             # Admin password change page
|
|-- assets/                                # Static files
|   |-- css/
|   |   |-- style.css                       # Main stylesheet
|   |   |-- header.css                      # Header styling
|   |   `-- footer.css                      # Footer styling
|   `-- js/
|       `-- script.js                       # Main JavaScript file
|
|-- WEB-INF/
|   |-- web.xml                             # Servlet configuration and URL mappings
|   |-- classes/                            # Compiled .class files
|   `-- lib/                                # External JAR files
|       `-- mysql-connector-j-9.7.0.jar     # MySQL JDBC driver
|
|-- src/                                    # Backend Java source code
|   |
|   |-- controller/                         # Servlet controllers
|   |   |-- ChatServlet.java                # Handles AI chatbot requests
|   |   |-- LoginServlet.java               # Handles user login requests
|   |   |-- RegisterServlet.java            # Handles user registration requests
|   |   |-- LogoutServlet.java              # Handles user logout requests
|   |   |-- ProductController.java          # Handles product listing/search requests
|   |   |-- CartController.java             # Handles cart add/update/remove requests
|   |   |-- CheckoutServlet.java            # Handles checkout and order placement
|   |   |-- OrdersServlet.java              # Handles order history and cancellation
|   |   |-- AdminAuth.java                  # Admin session authentication helper
|   |   |-- AdminLoginServlet.java          # Handles admin login requests
|   |   |-- AdminLogoutServlet.java         # Handles admin logout requests
|   |   |-- AdminDashboardServlet.java      # Handles admin dashboard statistics
|   |   |-- AdminPasswordServlet.java       # Handles admin password changes
|   |   |-- AdminProductServlet.java        # Handles admin product CRUD operations
|   |   |-- AdminOrderServlet.java          # Handles admin order status updates
|   |   |-- AdminUserServlet.java           # Handles admin user management
|   |   |-- AdminSecurityFilter.java        # Protects admin routes
|   |   `-- UserSecurityFilter.java         # Protects customer-only routes
|   |
|   |-- model/                              # Model classes
|   |   |-- ChatAssistant.java              # Rule-based AI chatbot response module
|   |   |-- User.java                       # User model
|   |   |-- Admin.java                      # Admin model
|   |   |-- Product.java                    # Product model
|   |   |-- CartItem.java                   # Session cart item model
|   |   |-- Order.java                      # Order model
|   |   |
|   |   `-- dao/                            # Database access objects
|   |       |-- UserDAO.java                # User database operations
|   |       |-- AdminDAO.java               # Admin database operations
|   |       |-- ProductDAO.java             # Product CRUD/search operations
|   |       `-- OrderDAO.java               # Order database operations
|   |
|   `-- util/
|       `-- DBConnection.java               # MySQL database connection utility
|
|-- database/
|   `-- schema.sql                          # Database schema and seed data
|
|-- target/                                 # Build output
|-- .vscode/                                # VS Code/Tomcat configuration
|-- .gitignore                              # Git ignored files
`-- README.md                               # Project documentation
```

## Important Files

- `src/model/ChatAssistant.java` - rule-based chatbot response module
- `src/controller/ChatServlet.java` - chatbot servlet controller
- `View/chat.jsp` - chatbot user interface
- `WEB-INF/web.xml` - servlet and route mappings
- `src/util/DBConnection.java` - MySQL connection utility
- `database/schema.sql` - database schema and seed data

## Getting Started

### Prerequisites

- JDK 8 or higher
- Apache Tomcat 10.1 recommended
- MySQL 5.7 or higher
- MySQL Connector/J 9.7.0, already included in `WEB-INF/lib`
- VS Code or another Java IDE

### Database Setup

1. Create the MySQL database using the schema:

   ```bash
   mysql -u root -p < database/schema.sql
   ```

2. Check database credentials in:

   ```text
   src/util/DBConnection.java
   ```

3. Update username, password, host, or database name if your local MySQL setup is different.

### Compile Source Files

From the project root, compile the Java source files into `WEB-INF/classes`.

Example for Windows with Tomcat 10.1:

```powershell
javac -cp "C:\Program Files\Apache Software Foundation\Tomcat 10.1\lib\servlet-api.jar;WEB-INF\lib\*;WEB-INF\classes" -d WEB-INF\classes src\controller\*.java src\model\*.java src\model\dao\*.java src\util\*.java
```

### Deploy and Run

1. Deploy the project folder to Tomcat as `E-Commerce-Website`.
2. Start or restart Tomcat.
3. Open:

   ```text
   http://localhost:8080/E-Commerce-Website/
   ```

4. Open the chatbot directly:

   ```text
   http://localhost:8080/E-Commerce-Website/chat
   ```

Do not open `View/chat.jsp` directly. The chatbot must be accessed through `/chat` so the request passes through `ChatServlet`.

## Usage

### Customer Workflow

1. Register or login.
2. Browse products from the Products page.
3. Search and filter products.
4. Add products to the cart.
5. Checkout and place an order.
6. View orders from the Orders page.
7. Use the Chat page for quick support questions.

### Admin Workflow

1. Open:

   ```text
   http://localhost:8080/E-Commerce-Website/admin/dashboard
   ```

2. Login with the configured admin credentials.
3. Manage products, users, stock, and orders.

Default seeded admin credentials may be defined in `database/schema.sql`.

## Application Routes

### Public and Customer Routes

| Method | Route | Description |
|--------|-------|-------------|
| GET | `/` or `/index.jsp` | Home page |
| POST | `/register` | Register user |
| POST | `/login` | Login user |
| POST | `/logout` | Logout user |
| GET | `/products` | Product catalog |
| GET/POST | `/cart` | View and manage cart |
| GET/POST | `/checkout` | Checkout and place order |
| GET/POST | `/orders` | View/cancel orders |
| GET/POST | `/chat` | AI chatbot support |

### Admin Routes

| Method | Route | Description |
|--------|-------|-------------|
| GET/POST | `/admin/login` | Admin login |
| GET | `/admin/dashboard` | Admin dashboard |
| GET/POST | `/admin/products` | Product management |
| GET/POST | `/admin/orders` | Order management |
| GET/POST | `/admin/users` | User management |
| GET/POST | `/admin/change-password` | Change admin password |
| POST | `/admin/logout` | Admin logout |

## Testing Checklist

Before final submission, verify:

- Project compiles without Java errors.
- Tomcat starts successfully.
- Home page loads at `/E-Commerce-Website/`.
- Products page loads and displays database products.
- Login and registration pages open.
- Cart and checkout routes redirect unauthenticated users to login.
- Admin login page opens.
- Chatbot page opens at `/E-Commerce-Website/chat`.
- Chatbot returns replies for return, cancel, order, cart, product, checkout, delivery, login, and register prompts.
- Tomcat is restarted after any servlet or `web.xml` changes.

## Final Submission Notes

- Use `/chat`, not `/View/chat.jsp`, when demonstrating the AI chatbot.
- Keep `WEB-INF/classes` updated with compiled `.class` files if submitting the project as a plain Tomcat web application.
- Make sure MySQL is running and the schema has been imported before demonstrating product, cart, checkout, or admin features.
- Restart Tomcat after source code or `web.xml` changes.

## Future Enhancements

- Product recommendations based on browsing or purchase history
- Payment gateway integration
- Email notifications for orders
- User reviews and ratings
- Wishlist functionality
- Database-backed chatbot knowledge base
- API-based generative AI chatbot integration

## License

This project is licensed under the MIT License.

---

Last Updated: July 7, 2026
