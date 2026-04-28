[[README NOT COMPLETE]] <br>
[[PUT E COMMERCE WEBSITE NAME HERE]]<br>



### 📌 Overview -

We are building [[blank]] a Java-based e-commerce web application built using MVC architecture. It allows users to browse products, manage carts, and place orders. <br>



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
├── index.jsp                     ← Entry point (Home)
│
<<<<<<< HEAD
├── view/                    ← ALL frontend (jsp/view)
=======
├── view/                          ← Jsp layer 
>>>>>>> 4ff4e08de08c9f35e5847d531db0329afdbe6f67
│   ├── login.jsp
│   ├── register.jsp
│   ├── products.jsp
│   ├── cart.jsp
│   ├── checkout.jsp
│   └── orders.jsp
│
├── assets/                       ← Static files 
│   ├── css/
│   │   └── style.css
│   ├── js/
│   │   └── script.js
│   └── images/
│
├── WEB-INF/
│   ├── web.xml                  ← Deployment descriptor
│   ├── classes/                 ← compiled .class files (AUTO)
│   └── lib/
│       ├── mysql-connector-j.jar
│       └── servlet-api.jar      (IMPORTANT for VS Code)
│
├── src/                         ← Backend (Java code)
│   ├── controller/
│   │   ├── LoginServlet.java
│   │   ├── ProductController.java
│   │   └── CartController.java
│   │
│   ├── model/
│   │   ├── User.java
│   │   ├── Product.java
│   │   ├── Cart.java
│   │
│   │   └── dao/
│   │       ├── UserDAO.java
│   │       ├── ProductDAO.java
│   │       └── CartDAO.java
│   │
│   └── util/
│       └── DBConnection.java
│
├── .vscode/
│   └── settings.json           ← (for library linking)
│
└── database/
    └── schema.sql

``` 
<br>


### ⚙️ Setup Instructions -

-**Clone repo** <br>
-**Import into VS Code** <br>
-**Configure MySQL DB** <br>
-**Run on Tomcat server**<br>
