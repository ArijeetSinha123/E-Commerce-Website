[[README NOT COMPLETE]]
[[PUT E COMMERCE WEBSITE NAME HERE]]


### 📌 Overview -

We are building [[blank]] a Java-based e-commerce web application built using MVC architecture. It allows users to browse products, manage carts, and place orders.



### 🚀 Features -

-User Registration & Login <br>
-Product Browsing & Search <br>
-Cart Management <br>
-Order Placement <br>
-Admin Panel <br>



### 🛠️ Tech Stack -

Frontend: JSP, HTML, CSS, JS <br>
Backend: Java Servlets
Database: MySQL
Server: Apache Tomcat



### 📂 Project Structure (Tentative) -

```
E-Commerce-Website/
│
├── index.jsp                ← Home / entry page
│
├── jsp/                     ← ALL frontend (View)
│   ├── login.jsp
│   ├── register.jsp
│   ├── products.jsp
│   ├── cart.jsp
│   ├── checkout.jsp
│   └── orders.jsp
│
├── css/                     ← Stylesheets
│   └── style.css
│
├── js/                      ← JavaScript files
│   └── script.js
│
├── images/                  ← Product and UI images
│
├── WEB-INF/                 
│   ├── web.xml              ← Deployment Descriptor
│   └── lib/                 ← External Libraries
│       └── mysql-connector-j.jar
│
├── src/                     ← Backend Logic (Java)
│   ├── controller/          ← Servlets (Control Flow)
│   │   ├── AuthController.java
│   │   ├── ProductController.java
│   │   └── CartController.java
│   │
│   ├── dao/                 ← Data Access Objects (JDBC)
│   │   ├── UserDAO.java
│   │   ├── ProductDAO.java
│   │   └── CartDAO.java
│   │
│   ├── model/               ← POJOs / Entities
│   │   ├── User.java
│   │   ├── Product.java
│   │   └── Cart.java
│   │
│   └── util/                ← Utilities (DB Connection)
│       └── DBConnection.java
│
└── database/
    └── schema.sql           ← SQL script for DB setup

```


### ⚙️ Setup Instructions -

-Clone repo
-Import into VS Code
-Configure MySQL DB
-Run on Tomcat server
