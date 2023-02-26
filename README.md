# Basic-Online-Cafeteria-Management-System☕
This repo contains a project of online cafeteria management system where the user can order food or book tables and the admin can approve or settle orders and table bookings. This is built using Java Servlets and JSP. The client and admin sites are developed in two different projects and can be run in different servers if required.

> ## How to spin up 🚀 the Server & get the application running🏃‍♂️?
> - Import the projects in your workspace in eclipse
> - "TheCafeShop" is the client site project directory
> - "MCASEM-1 Project" is the admin site project directory
> - Set tomcat ***client port*** to **```8082```**
> - Import the .sql file in your MySQL client, whichever you are using, be it workbench or phpmyadmin or just the CLI. In case you want a different database name, in the client site project change the database name in the servlet context in web.xml having the name 'DB_NAME' and in the admin site project change the value of the variable ```MCASEM-1_Project.Main.DBConnect.database```. Otherwise you are good to go.
> - We have currently not used a separate media server for the images and we are not storing the images the database as well. The images the stored in the ```MCASEM-1 Project/src/webapp/resources/```. In the admin site code it requires absolute path of the images. So, before running the project in your machine, change the value of the variable ```MCASEM-1_Project.Main.DBConnect.mediaBasePath``` with the absolute base path of the images in your machine.
> - You are all set, now start tomcat.
>   - navigate to ```http://localhost:8082/TheCafeShop/login``` for client site
>   - and to ```http://localhost:8082/MCASEM-1_Project/admin0.jsp``` for admin site