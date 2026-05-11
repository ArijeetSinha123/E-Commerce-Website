# E-Commerce Website [[NAME IS NOT FINAL]]<br>


[[README IS SUBJECT TO CHANGE AND NOT FINAL]] <br>

### Overview -

**We are building a Java-based e-commerce web application using MVC architecture. It allows users to browse products, manage carts, place orders, and lets admins manage products and order statuses.** <br>



### Features -

-**User Registration & Login** <br>
-**Product Browsing & Search** <br>
-**Cart Management** <br>
-**Order Placement** <br>
-**Order History & Cancellation** <br>
-**Admin Login** <br>
-**Admin Product Management** <br>
-**Admin Order Status Management** <br>



### Tech Stack -

**Backend**: Java (Servlets, JSP) <br>
**Frontend**: HTML, CSS, JavaScript <br>
**Server**: Apache Tomcat <br>
**Database**: MySQL <br>
**Architecture**: MVC <br>


### Project Structure -

```
E-Commerce-Website/
│
├── index.jsp                              ← Entry point / Home page
│
├── View/                                  ← View layer - JSP pages
│   ├── login.jsp                          ← User login page
│   ├── register.jsp                       ← User registration page
│   ├── products.jsp                       ← Product listing and search page
│   ├── cart.jsp                           ← Shopping cart page
│   ├── checkout.jsp                       ← Checkout / place order page
│   ├── orders.jsp                         ← User order history page
│   │
│   └── admin/                             ← Admin panel JSP pages
│       ├── login.jsp                      ← Admin login page
│       ├── dashboard.jsp                  ← Admin dashboard page
│       ├── products.jsp                   ← Admin product management page
│       ├── product-form.jsp               ← Add/Edit product form
│       └── orders.jsp                     ← Admin order management page
│
├── assets/                                ← Static files
│   ├── css/
│   │   └── style.css                      ← Main stylesheet
│   └── js/
│   │    └── script.js                     ← Main JavaScript file
│   └── images/
│
├── WEB-INF/
│   ├── web.xml                            ← Servlet configuration and URL mappings
│   ├── classes/                           ← Compiled .class files [AUTO-GENERATED/LOCAL]                        
│   └── lib/                               ← External JAR files
│       └── mysql-connector-j-9.7.0.jar    ← MySQL JDBC driver
│
├── src/                                   ← Backend Java source code
│   ├── controller/                        ← Servlet controllers
│   │   ├── LoginServlet.java              ← Handles user login requests
│   │   ├── RegisterServlet.java           ← Handles user registration requests
│   │   ├── LogoutServlet.java             ← Handles user logout requests
│   │   ├── ProductController.java         ← Handles product listing/search requests
│   │   ├── CartController.java            ← Handles cart add/update/remove requests
│   │   ├── CheckoutServlet.java           ← Handles checkout and order placement
│   │   ├── OrdersServlet.java             ← Handles user order history and cancellation
│   │   ├── AdminAuth.java                 ← Checks admin session authentication
│   │   ├── AdminLoginServlet.java         ← Handles admin login requests
│   │   ├── AdminLogoutServlet.java        ← Handles admin logout requests
│   │   ├── AdminDashboardServlet.java     ← Handles admin dashboard statistics
│   │   ├── AdminProductServlet.java       ← Handles admin product CRUD operations
│   │   └── AdminOrderServlet.java         ← Handles admin order status updates
│   │
│   ├── model/                             ← Model classes
│   │   ├── User.java                      ← User model
│   │   ├── Admin.java                     ← Admin model
│   │   ├── Product.java                   ← Product model
│   │   ├── CartItem.java                  ← Session cart item model
│   │   ├── Order.java                     ← Order model
│   │   │
│   │   └── dao/                           ← Database access classes
│   │       ├── UserDAO.java               ← User registration and login database logic
│   │       ├── AdminDAO.java              ← Admin login database logic
│   │       ├── ProductDAO.java            ← Product database CRUD/search logic
│   │       └── OrderDAO.java              ← Order creation, listing, cancellation, status logic
│   │
│   └── util/
│       └── DBConnection.java              ← MySQL database connection helper
│
├── database/
│   └── schema.sql                         ← Database schema and seed data
│
├── .vscode/                               ← VS Code / local Tomcat configuration (Local System Path)
│
├── .gitignore                             ← Git ignored files
└── README.md                              ← Project documentation
```

<br>

Note: WEB-INF/classes contains compiled .class files generated from the Java source files when the project is built or deployed.
The main source code is inside the src/ folder. <br>

Note: .vscode/ecommerce.xml may contain a local system path, so each developer should configure it according to their own machine. <br>


### Setup Instructions -

-**Clone repo** <br>
-**Import into VS Code** <br>
-**Configure MySQL DB** <br>
-**Run `database/schema.sql` in MySQL** <br>
-**Run on Tomcat server**<br>

---

### Current Development Update (9/5/26) -

- Product browsing, search, cart, checkout, and order history flow added. <br>
- Basic admin panel added for product management and order status updates. <br>
- Admin route starts at `/admin/dashboard`. <br>
- Default admin seed in `database/schema.sql`: `admin@example.com` / `admin123`. <br>
- Run `database/schema.sql` again before testing the product/order/admin features. <br>
