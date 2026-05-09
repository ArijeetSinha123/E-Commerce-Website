# [[PUT E COMMERCE WEBSITE NAME HERE]]<br>


[[README NOT COMPLETE]] <br>

### 📌 Overview -

**We are building [[blank]] a Java-based e-commerce web application built using MVC architecture. It allows users to browse products, manage carts, and place orders.** <br>



### 🚀 Features -

-**User Registration & Login** <br>
-**Product Browsing & Search** <br>
-**Cart Management** <br>
-**Order Placement** <br>
-**Admin Panel** <br>



### 🛠️ Tech Stack -

**Backend**: Java (Servlets, JSP) <br>
**Frontend**: HTML, CSS, JavaScript <br>
**Server**: Apache Tomcat <br>
**Database**: MySQL <br>
**Architecture**: MVC <br>
**AI (Optional)**: Python / Java-based logic (separate module) <br>


### 📂 Project Structure (Tentative) -

```
E-Commerce-Website/
│
├── index.jsp                     ← Entry point / Home page 
│
├── View/                         ← View layer - JSP pages
│   ├── login.jsp                 ← Login page 
│   ├── register.jsp              ← Registration page 
│   ├── products.jsp              ← Product listing page [PLANNED]
│   ├── cart.jsp                  ← Shopping cart page [PLANNED]
│   ├── checkout.jsp              ← Checkout page [PLANNED]
│   └── orders.jsp                ← Order history page [PLANNED]
│
├── assets/                       ← Static files [PLANNED]
│   ├── css/
│   │   └── style.css             ← Main stylesheet [PLANNED]
│   ├── js/
│   │   └── script.js             ← Main JavaScript file [PLANNED]
│   └── images/                   ← Product/UI images [PLANNED]
│
├── WEB-INF/
│   ├── web.xml                   ← Servlet configuration [CURRENT]
│   ├── classes/                  ← Compiled .class files [AUTO-GENERATED]
│   │   ├── controller/
│   │   │   ├── LoginServlet.class
│   │   │   └── RegisterServlet.class
│   │   └── model/
│   │       ├── User.class
│   │       └── dao/
│   │           └── UserDAO.class
│   └── lib/                      ← External JAR files 
│       └── mysql-connector-j.jar ← MySQL JDBC driver 
│
├── src/                          ← Backend Java source code
│   ├── controller/
│   │   ├── LoginServlet.java     ← Handles login requests 
│   │   ├── RegisterServlet.java  ← Handles registration requests 
│   │   ├── ProductController.java← Handles product requests
│   │   └── CartController.java   ← Handles cart requests [PLANNED]
│   │
│   ├── model/
│   │   ├── User.java             ← User model 
│   │   ├── Product.java          ← Product model [PLANNED]
│   │   ├── Cart.java             ← Cart model [PLANNED]
│   │   └── dao/
│   │       ├── UserDAO.java      ← User data/login logic 
│   │       ├── ProductDAO.java   ← Product database logic [PLANNED]
│   │       └── CartDAO.java      ← Cart database logic [PLANNED]
│   │
│   └── util/
│       └── DBConnection.java     ← Database connection helper 
│
├── .vscode/
│   ├── settings.json             ← VS Code Java/Tomcat library 
│   ├── launch.json               ← Local browser launch config 
│   └── ecommerce.xml             ← Local Tomcat context confi
│
├── database/
│   └── schema.sql                ← Database schema [CURRENT]
│
├── .gitignore                    ← Git ignored files 
└── README.md                     ← Project documentation 

<br>

Note: WEB-INF/classes contains compiled .class files generated from the Java source files. 
The main source code is inside the src/ folder. <br>

Note: .vscode/ecommerce.xml may contain a local system path, so each developer should configure it according to their own machine. <br>

```

### ⚙️ Setup Instructions -

-**Clone repo** <br>
-**Import into VS Code** <br>
-**Configure MySQL DB** <br>
-**Run on Tomcat server**<br>

---

### Current Additions (9/5/26)-

- Product listing, cart, checkout, and order history pages have been added. <br>
- Product, cart item, and order model/DAO/controller classes have been added. <br>
- `database/schema.sql` now includes product, order, and order item tables with sample products. <br>
- `WEB-INF/web.xml` now includes servlet mappings for products, cart, checkout, and orders. <br>

### Immediate Next Steps -

- Run `database/schema.sql` in MySQL. <br>
- Start Tomcat and test: Register/Login -> Products -> Add to Cart -> Checkout -> Orders. <br>
- After this, add product images, admin product CRUD, password hashing, and stock reduction during checkout. <br>
