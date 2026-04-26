[[README NOT COMPLETE]]
[[PUT E COMMERCE WEBSITE NAME HERE]]


📌 Overview -

We are building [[blank]] a Java-based e-commerce web application built using MVC architecture. It allows users to browse products, manage carts, and place orders.


🚀 Features -

User Registration & Login
Product Browsing & Search
Cart Management
Order Placement
Admin Panel


🛠️ Tech Stack -

Frontend: JSP, HTML, CSS, JS
Backend: Java Servlets
Database: MySQL
Server: Apache Tomcat


📂 Project Structure (Tentative) -

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
│   ├── orders.jsp
│
├── css/                     ← styles
│   └── style.css
│
├── js/                      ← scripts
│   └── script.js
│
├── images/                  ← product images
│
├── WEB-INF/
│   ├── web.xml              ← config
│   └── lib/
│       └── mysql-connector-j.jar
│
├── src/                     ← ALL Java code (backend)
│   ├── controller/
│   │   ├── AuthController.java
│   │   ├── ProductController.java
│   │   ├── CartController.java
│
│   ├── dao/
│   │   ├── UserDAO.java
│   │   ├── ProductDAO.java
│   │   ├── CartDAO.java
│
│   ├── model/
│   │   ├── User.java
│   │   ├── Product.java
│   │   ├── Cart.java
│
│   ├── util/
│   │   ├── DBConnection.java
│
├── database/
│   └── schema.sql



⚙️ Setup Instructions -

Clone repo
Import into NetBeans/Eclipse
Configure MySQL DB
Run on Tomcat server
