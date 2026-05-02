# BACKUP FOR MAIN BRANCH (LAST UPDATED ON 1/5/26)



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
├── index.jsp                     ← Entry point / Home page [CURRENT]
│
├── View/                         ← View layer - JSP pages
│   ├── login.jsp                 ← Login page [CURRENT]
│   ├── register.jsp              ← Registration page [CURRENT]
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
│   └── lib/                      ← External JAR files [PLANNED]
│       └── mysql-connector-j.jar ← MySQL JDBC driver [PLANNED]
│
├── src/                          ← Backend Java source code
│   ├── controller/
│   │   ├── LoginServlet.java     ← Handles login requests [CURRENT]
│   │   ├── RegisterServlet.java  ← Handles registration requests [CURRENT]
│   │   ├── ProductController.java← Handles product requests [PLANNED]
│   │   └── CartController.java   ← Handles cart requests [PLANNED]
│   │
│   ├── model/
│   │   ├── User.java             ← User model [CURRENT]
│   │   ├── Product.java          ← Product model [PLANNED]
│   │   ├── Cart.java             ← Cart model [PLANNED]
│   │   └── dao/
│   │       ├── UserDAO.java      ← User data/login logic [CURRENT]
│   │       ├── ProductDAO.java   ← Product database logic [PLANNED]
│   │       └── CartDAO.java      ← Cart database logic [PLANNED]
│   │
│   └── util/
│       └── DBConnection.java     ← Database connection helper [PLANNED]
│
├── .vscode/
│   ├── settings.json             ← VS Code Java/Tomcat library setup [CURRENT]
│   ├── launch.json               ← Local browser launch config [LOCAL]
│   └── ecommerce.xml             ← Local Tomcat context config [LOCAL]
│
├── database/
│   └── schema.sql                ← Database schema [CURRENT]
│
├── .gitignore                    ← Git ignored files [CURRENT]
└── README.md                     ← Project documentation [CURRENT]

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
