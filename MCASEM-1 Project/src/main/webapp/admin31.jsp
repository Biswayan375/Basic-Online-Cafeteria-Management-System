<!DOCTYPE html>
<%@page import="java.sql.ResultSet"%>
<%@page import="Main.Data"%>
<%
HttpSession s=request.getSession();
boolean f=false;
try{
f=(boolean) s.getAttribute("status");
}catch(Exception e){
	f=false;
}
if(!f)
	response.sendRedirect("adminlogin.html");
%>
<html lang="en" style="padding:0;">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Coffee Shop</title>
    <style>
        *{  
            box-sizing: border-box;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color:black;
        }
        /* width */
            ::-webkit-scrollbar {
            width: 10px;
        }

        /* Track */
        ::-webkit-scrollbar-track {
             border-radius: 15px;
             background-color:#B95835;
        }
 
        /* Handle */
        ::-webkit-scrollbar-thumb {
            background:#7A3E48; 
            border-radius: 10px;
        }
        .head{
            display: block;
            position: fixed;
            left:0px;
            top:0px;
            width:100%;
            height: 12vh;
            z-index: 1;
            border-bottom:2px solid #B95835;
            background-color: #7A3E48;        
        }
        .heading{
            position: absolute;
            left:20px;
            top:50%;
            transform: translate(0,-50%);
            font-size:4em;
            font-family: "Segeo Script";
            color:#EECD86;
            border-bottom: 2px solid #EECD86;
        }
        .logout{
            position: absolute;
            text-decoration: none;
            right:20px;
            top:50%;
            transform: translate(0,-50%);
            background-color:  #E18942;
            font-size: 1.2em;
            color: #3D3242;;
            border-radius: 50px;
            border:2px solid  #3D3242;;
            padding: 5px 25px 8px 25px;
            margin: 0;
            font-family:Tahoma;
        }
        .nav{
            display: block;
            position: fixed;
            top:12vh;
            background-color:#EECD86;
            width:100%;
            height: 5vh;
            z-index: 1;
        }
        .navitem{
            display: inline-block;
            position: relative;
            text-decoration: none;
            width:24.5%;
            text-align: center;
            padding:1vh;
            height: 100%;
            border:2px solid rgba(255,255,255,0);
            border-right:2px solid #B95835;
        }
        .navitem:nth-child(4){
            border-radius: 15px 15px 0px 0px;
            top:2px;
            border:2px solid #3D3242;
            border-bottom:0;
            background-color:#E18942;
            color:#3D3242;
        }
        .main{
            display: block;
            position: fixed;
            top:17vh;
            background-color:#E18942;
            width:100%;
            height: 83vh;
            padding: 10px 10px;
            border: 2px solid #3D3242;
        }
        .menu{
            display: flex;
            flex-direction: column;
            position:absolute;
            width:10%;
            height: 98%;
            background-color:#EECD86;
            padding:5px;
            box-shadow: 0px 0px 10px 2px #B95835;
            border-radius: 5px;
        }
        .menuitem{
            text-decoration: none;
            width: 100%;
            border:2px solid #B95835;
            text-align: center;
            padding: 5px 0px 5px 0px;
            margin-bottom: 5px;
            border-radius: 5px;;
            font-size: 1.2em;
            color:black;
            background-color:#E18942;

        }
        .menuitem:hover{
            background-color:#B95835;
            border:2px solid #3D3242;
        }
        .menuitem:nth-child(2){
            background-color:#B95835;
            border:2px solid #3D3242;
        }
        .content{
            display: block;
            position: absolute;
            left:11%;
            width:88%;
            height: 98%;
            overflow-y: auto;
            background-color:#EECD86;
            padding: 5px;
            box-shadow: 0px 0px 10px 2px #B95835;
            border-radius: 5px;
        }
        .booking{
            width:100%;
            background-color: #E18942;
            border:2px solid #3D3242;
            border-collapse: collapse;
        }
        .booking tr{
            background-color: #B95835;
        }
        th,td{
            border: 2px solid #3D3242;
        }
        td a{
            display: inline-block;
            width: 50%;
            text-align: center;
            text-decoration: none;
            background-color: #7A3E48;
            color:#EECD86;
            border:2px solid #3D3242;
        }
        tr:nth-child(even){
            background-color: #E18942;
        }
    </style>
</head>
<body>

<div class="head">
    <h1 class="heading">The Cafe Shop</h1>
    <a href="logout" class="logout">Logout</a>
</div>

<div class="nav">
    <a href="admin0.jsp" class="navitem">Add Item</a>
    <a href="admin1.jsp" class="navitem">Items</a>
    <a href="admin2.jsp" class="navitem">Orders</a>
    <a href="admin3.jsp" class="navitem">Reservation</a>
</div>

<div class="main">
    <div class="menu">
        <a href="admin3.jsp" class="menuitem">PENDING</a>
        <a href="admin31.jsp" class="menuitem">SETTELED</a>
        <a href="admin32.jsp" class="menuitem">CANCELLED</a>
    </div>
    <div class="content">
        <table class="booking">
            <tr>
            	<th>ID</th>
                <th>Name</th>
                <th>Table No.</th>
                <th>Capacity</th>
                <th>Date</th>
                <th>Time</th>
                <th>Remarks</th>
            </tr>
            <%
            ResultSet rs=Data.getSetteledBookings();
            while(rs.next()){
            %>
            <tr>
            	<td><%= rs.getString("bid") %></td>
                <td><%= rs.getString(1)%></td>
                <td><%= rs.getInt(2)%></td>
                <td><%= rs.getInt(3)%></td>
                <td><%= rs.getString(4)%></td>
                <td><%= rs.getString(5)%></td>
                <td>Settled</td>
            </tr>
            <%
            }
            %>
        </table>
          
    </div>
</div>

</body>
</html>