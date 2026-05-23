# NexCart - A Java based E-Commerce Website

A dynamic, full-featured Java-based e-commerce web application built with Servlets, JSP, and JDBC. This application provides a complete shopping experience for users and comprehensive management tools for administrators.

## Overview

This project implements a robust e-commerce platform using the Model-View-Controller (MVC) architecture. It enables customers to browse and search products, manage shopping carts, place orders, and track purchase history, while providing administrators with tools to manage inventory and order fulfillment.

## Features

### Customer Features
- **User Authentication** – Secure registration and login system
- **Product Catalog** – Browse and search products with filtering capabilities
- **Shopping Cart** – Add, update, and remove items from cart
- **Order Management** – Place orders and view order history
- **Order Tracking** – Cancel orders and track order status

### Admin Features
- **Admin Dashboard** – View key statistics and metrics
- **Product Management** – Create, read, update, and delete products
- **Inventory Control** – Manage product stock and availability
- **Order Management** – Update order statuses and track fulfillment

## Tech Stack

| Component | Technology |
|-----------|------------|
| **Backend** | Java (Servlets, JSP) |
| **Frontend** | HTML, CSS, JavaScript |
| **Server** | Apache Tomcat |
| **Database** | MySQL |
| **Architecture** | MVC (Model-View-Controller) |
| **JDBC Driver** | MySQL Connector/J 9.7.0 |

## Project Structure

```
E-Commerce-Website/
│
├── index.jsp                              # Entry point / Home page
│
├── View/                                  # View layer - JSP pages
│   ├── login.jsp                          # User login page
│   ├── register.jsp                       # User registration page
│   ├── products.jsp                       # Product listing and search page
│   ├── cart.jsp                           # Shopping cart page
│   ├── checkout.jsp                       # Checkout / order placement page
│   ├── orders.jsp                         # User order history page
│   │
│   └── admin/                             # Admin panel JSP pages
│       ├── login.jsp                      # Admin login page
│       ├── dashboard.jsp                  # Admin dashboard page
│       ├── products.jsp                   # Admin product management page
│       ├── product-form.jsp               # Add/Edit product form
│       └── orders.jsp                     # Admin order management page
│
├── assets/                                # Static files
│   ├── css/
│   │   └── style.css                      # Main stylesheet
│   ├── js/
│   │   └── script.js                      # Main JavaScript file
│   └── images/                            # Image assets
│
├── WEB-INF/
│   ├── web.xml                            # Servlet configuration and URL mappings
│   ├── classes/                           # Compiled .class files (auto-generated)
│   └── lib/                               # External JAR files
│       └── mysql-connector-j-9.7.0.jar    # MySQL JDBC driver
│
├── src/                                   # Backend Java source code
│   │
│   ├── controller/                        # Servlet controllers
│   │   ├── LoginServlet.java              # Handles user login requests
│   │   ├── RegisterServlet.java           # Handles user registration requests
│   │   ├── LogoutServlet.java             # Handles user logout requests
│   │   ├── ProductController.java         # Handles product listing/search requests
│   │   ├── CartController.java            # Handles cart add/update/remove requests
│   │   ├── CheckoutServlet.java           # Handles checkout and order placement
│   │   ├── OrdersServlet.java             # Handles user order history and cancellation
│   │   ├── AdminAuth.java                 # Admin session authentication
│   │   ├── AdminLoginServlet.java         # Handles admin login requests
│   │   ├── AdminLogoutServlet.java        # Handles admin logout requests
│   │   ├── AdminDashboardServlet.java     # Handles admin dashboard statistics
│   │   ├── AdminProductServlet.java       # Handles admin product CRUD operations
│   │   └── AdminOrderServlet.java         # Handles admin order status updates
│   │
│   ├── model/                             # Model classes
│   │   ├── User.java                      # User model
│   │   ├── Admin.java                     # Admin model
│   │   ├── Product.java                   # Product model
│   │   ├── CartItem.java                  # Session cart item model
│   │   ├── Order.java                     # Order model
│   │   │
│   │   └── dao/                           # Database access objects (DAO)
│   │       ├── UserDAO.java               # User database operations
│   │       ├── AdminDAO.java              # Admin database operations
│   │       ├── ProductDAO.java            # Product database CRUD/search operations
│   │       └── OrderDAO.java              # Order database operations
│   │
│   └── util/
│       └── DBConnection.java              # MySQL database connection utility
│
├── database/
│   └── schema.sql                         # Database schema and seed data
│
├── .vscode/                               # VS Code/Tomcat configuration
├── .gitignore                             # Git ignored files
└── README.md                              # Project documentation
```

### Notes

- **WEB-INF/classes**: Contains compiled `.class` files generated during the build process. Source code is located in the `src/` directory.
- **.vscode/ecommerce.xml**: Contains local system paths and should be configured individually for each developer's machine.

## Getting Started

### Prerequisites

- Java Development Kit (JDK) 8 or higher
- Apache Tomcat 9 or higher
- MySQL 5.7 or higher
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ArijeetSinha123/E-Commerce-Website.git
   cd E-Commerce-Website
   ```

2. **Import into IDE**
   - Open the project in VS Code or your preferred Java IDE

3. **Configure Database**
   - Create a new MySQL database
   - Execute the SQL schema:
     ```bash
     mysql -u root -p < database/schema.sql
     ```
   - Update database credentials in `src/util/DBConnection.java` if needed

4. **Deploy to Tomcat**
   - Copy the project to Tomcat's `webapps` directory
   - Start Tomcat server
   - Access the application at `http://localhost:8080/E-Commerce-Website`

## Usage

### User Workflow
1. Register a new account or login with existing credentials
2. Browse products and use the search feature
3. Add items to your shopping cart
4. Proceed to checkout and place your order
5. View order history and manage orders in your profile

### Admin Workflow
1. Navigate to `/admin/dashboard` to access the admin panel
2. Login with the default credentials:
   - **Email**: `admin@example.com`
   - **Password**: `admin123`
3. Manage products, update inventory, and process orders

## Development Status

### Future Enhancements

- Payment gateway integration
- AI-powered product recommendations
- Email notifications for orders
- Advanced analytics and reporting
- User reviews and ratings
- Wishlist functionality

## API Endpoints

### User Routes
- `POST /register` – User registration
- `POST /login` – User login
- `GET /products` – List all products
- `GET /products/search` – Search products
- `POST /cart/add` – Add to cart
- `POST /cart/update` – Update cart
- `POST /checkout` – Place order
- `GET /orders` – View order history
- `POST /logout` – User logout

### Admin Routes
- `POST /admin/login` – Admin login
- `GET /admin/dashboard` – Admin dashboard
- `GET /admin/products` – List products
- `POST /admin/products/add` – Add product
- `POST /admin/products/edit` – Edit product
- `POST /admin/products/delete` – Delete product
- `GET /admin/orders` – View orders
- `POST /admin/orders/update-status` – Update order status
- `POST /admin/logout` – Admin logout

## Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

For questions or support, please open an issue on the repository or contact the project maintainer.

---

**Last Updated**: September 5, 2026
