<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="Main.DBConnect"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
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
<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader ("Expires", -1);
%>
<!DOCTYPE html>
<html lang="en" style="padding:0;">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE"> 
	<META HTTP-EQUIV="Expires" CONTENT="-1">
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
        a{
        	text-decoration: none;
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
        .navitem:nth-child(2){
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
        .content{
            display: block;
            position: absolute;
            width:99%;
            height: 98%;
            overflow-y: auto;
            background-color:#EECD86;
            padding: 5px;
            box-shadow: 0px 0px 10px 2px #B95835;
            border-radius: 5px;
        }
        .item{
            display: flex;
            position: relative;
            width: 100%;
            margin-top: 10px;
            background-color:#E18942;
            float: left;
            min-height: 100px;
            padding: 5px;
            transition: 500ms;
            border: 2px solid #B95835;
            border-radius: 5px;
           /* box-shadow: 0px 0px 5px 4px #a64f2f;*/
        }
        .item:hover{
            border: 2px solid 	#3D3242;
            box-shadow: 0px 0px 5px 1px #a64f2f;
        }
        .itemimg{
            display:inline-block;
            position: relative;
            width:20%;
            border-radius: 7px;
        }
        .iteminfo{
            display:inline-block;
            position: relative;
            width:70%;
            padding-left: 20px;
        }
        .iteminfo h2{
            border-left: 2px solid #7A3E48;
            padding-left: 5px;
            color:rgb(10,10,10)
        }
        .iteminfo h2:nth-child(1){
            font-weight: 500;
            font-size: 2.2em;
        }
        .iteminfo h2:nth-child(2){
            font-weight: 500;
            font-size: 1.4em;
        }
        .iteminfo h2:nth-child(3){
            font-weight: 500;
            font-size: 1.1em;
        }
        .itemop{
            display:flex;
            position: relative;
            width:10%;
            flex-direction: column;
            justify-content: center;
        }
        .itemop button{
            width: 100%;
            height: 50%;
            font-size: 1.1em;
            border-radius: 40px;
            border:2px solid #7A3E48;
            max-height: 40px;
            margin: 2px 0px;
            background-color: #B95835;
        }
        .refillform{
            display:none;
            position:absolute;
            width:50%;
            background-color: #EECD86;
            left:50%;
            top:50%;
            transform: translate(-50%,-100%);
            z-index: 2;
            padding: 10px;
            box-shadow: 0px 0px 8px 1px #7A3E48;
            border:2px solid #7A3E48;
            border-radius: 5px;
            
        }
        .refillform input{
            display: inline-block;
            position: relative;
            width: 100%;
            margin-bottom: 4px;;
            font-size: 1.5em;
            background-color:#E18942;
            border: 2px solid #7A3E48;
            border-radius: 4px;
        }
        .refillform button{
            background-color: #7A3E48;
            color:#E18942;
            border-radius: 5px;
            font-size: 1em;;
        }
        .updateform{
            display:none;
            position:absolute;
            width:50%;
            background-color: #EECD86;
            left:50%;
            top:50%;
            transform: translate(-50%,-100%);
            z-index: 2;;
            padding: 10px;
            box-shadow: 0px 0px 8px 1px #7A3E48;
            border:2px solid #7A3E48;
            border-radius: 5px;
            
        }
        .updateform input{
            display: inline-block;
            position: relative;
            width: 100%;
            margin-bottom: 4px;;
            font-size: 1.5em;
            background-color:#E18942;
            border: 2px solid #7A3E48;
            border-radius: 4px;
        }
        .updateform button{
            background-color: #7A3E48;
            color:#E18942;
            border-radius: 5px;
            font-size: 1em;;
        }
        button:active{
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
    <a href="" class="navitem">Reservation</a>
</div>

<div class="main">
    <div class="content">
    <%
     Connection con= DBConnect.getConnection(DBConnect.database, DBConnect.user,DBConnect.password);
     String query="select * from product";
     ResultSet rs=con.createStatement().executeQuery(query);
     String temp="",del="deleteProduct?name=";
     while(rs.next()){
    	 temp=rs.getString(4);
    	 del+=rs.getString(1);
    %>
    
        <div class="item">
            <img src= <%= "resource/"+temp %> class="itemimg">
            <span class="iteminfo">
                <h2><%=rs.getString(1) %></h2>
                <h2>Price : Rs. <%=rs.getString(2) %>/-</h2>
                <h2>Available : <%=rs.getString(3) %></h2>
            </span>
            <div class="itemop">
                <button name="<%= rs.getString(1)%>" onclick="RefillForm(event)">Refill</button>
                <button name="<%= rs.getString(1)%>" price=<%= rs.getString(2)%> onclick="UpdateForm(event)">Update</button>
                <button><a href="<%=del%>">Delete</a></button>
            </div>
        </div>
      <%
      del="deleteProduct?name=";
      	}
      	rs.close();
      	con.close();
      %>
    </div>
</div>
<div class="refillform" id="refillform">
    <form action="refillProduct" method="POST">
    <input type="text" id="name" name="name" readonly>
    <input type="number" id="quantity" name="quantity" placeholder="Enter Refill Amount">
    <input type="submit" value="Refill" onsubmit="SubmitRefill()">
    </form>
    <button onclick="CloseRefill()">Close</button>
</div>
<div class="updateform" id="updateform">
    <form action="updateProduct" method="POST" enctype="multipart/form-data">
    <input type="text" id="cname" name="cname" readonly>
    <input type="file" id="image" name="image" placeholder="New Image">
    <input type="number" id="price" name="price" placeholder="Enter New Amount">
    <input type="submit" value="Update" onsubmit="SubmitUpdate(event)">
    </form>
    <button onclick="CloseUpdate()">Close</button>
</div>
<script>
function RefillForm(e){
    document.querySelector("#refillform").style="display:block;";
    document.querySelector("#name").value=e.target.getAttribute("name");
    console.log("ok");
}
function CloseRefill(){
    document.querySelector("#refillform").style="display:none;";
}

function UpdateForm(e){
    document.querySelector("#updateform").style="display:block;";
    document.querySelector("#cname").value=e.target.getAttribute("name");
}
function CloseUpdate(){
    document.querySelector("#updateform").style="display:none;";
}
</script>
</body>
</html>