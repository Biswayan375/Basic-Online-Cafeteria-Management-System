<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<!DOCTYPE html>
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
            border-radius: 50px;
            border:2px solid  #3D3242;
            padding: 5px 25px 8px 25px;
            margin: 0;
            font-family:Tahoma;
            color: #3D3242;
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
            height: 100%;
			padding:1vh;
            border:2px solid rgba(255,255,255,0);
            border-right:2px solid #B95835;
        }
        .navitem:nth-child(1){
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
            padding: 10px 5px;
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
        .sub{
            display: block;
            position: relative;
            float: left;
            width:49.5%;
            height:99%;
            border:2px solid #B95835;
            border-radius: 5px;
            margin-left:2px;
            overflow-y: auto;
        }
        .sub form{
            display: inline-block;
            position: absolute;
            width:60%;
            left:50%;
            top:50%;
            transform: translate(-50%,-50%);
            background-color: #B95835;
            padding: 5px;
            border-radius: 5px;
            box-shadow: 0px 1px 6px 2px #a64f2f;
        }
        label{
            font-size: 1.5em;;
        }
        form input{
            width:100%;
            font-size: 1.5em;
            border:2px solid #7A3E48;
            border-radius: 5px;
            background-color: #EECD86;
        }
        input[type="file"]{
            display: none;
        }
        label[for="image"]{
            display: block;
            background-color:  #EECD86;
            text-align: center;
            border-radius: 4px;
            padding: 5px;
            border:2px solid #7A3E48;
        }
        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        input[type=number] {
            -moz-appearance: textfield;
        }
        input[type="submit"]{
            background-color: #E18942;
            color:#000000;
            border:2px solid #3D3242;
        }
        .preview{
            display: inline-block;
            position:absolute;
            left:50%;
            top:50%;
            transform: translate(-50%,-50%);
            width:50%;
            background-color: #E18942;
            padding:5px;
            box-shadow: 0px 1px 6px 2px #B95835;
            border-radius: 5px;
            padding-bottom:10%;
        }
        .preview img{
            display: inline-block;
            position: relative;
            width:100%;
            border-radius: 5px;
        }
        .preview h1,h2,h4{
            color:#3D3242;
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
    <div class="content">
        <div class="sub">
            <h1 style="color:#3D3242;text-align:center;border:2px solid #3D3242; border-radius:5px;background-color:#E18942;margin:10px;">Product Details</h1>
            <form action="insertProduct" method="POST" enctype="multipart/form-data">
                <label for="image">Add Image (Ideal : 4 * 2.5)</label><br>
                <input type="file" name="image" id="image" onchange="previewImg(event)">
                <label for="name">Product Name</label><br>
                <input type="text" name="name" id="name" onkeyup="previewText(event)" required><br>
                <label for="price">Rs./-</label><br>
                <input type="number" name="price" id="price" min="0" onkeyup="previewText(event)" required><br>
                <label for="quantity">Quantity</label><br>
                <input type="number" name="quantity" id="quantity" min="0" onkeyup="previewText(event)"><br><br>
                <input type="submit" value="Add Product">
            </form>
        </div>
        <div class="sub">
            <h1 style="color:#3D3242;text-align:center;border:2px solid #3D3242; border-radius:5px;background-color:#E18942;margin:10px;">Preview</h1>
            <div class="preview" >
                <img src="resource/coffee.jpeg" id="preimg">
                <h1 id="pname" value="">Test Name</h1>
                <h2 id="pprice" value="Rs./- ">Test Price</h2>
                <h4 id="pquantity" value="In Stock : ">Test Quantity</h4>
            </div>
        </div>
    </div>
</div>
<script>
    function previewImg(e){
        var pre=document.querySelector("#preimg");
        pre.src=URL.createObjectURL(e.target.files[0]);
    }
    function previewText(e){
        var field=document.querySelector("#p"+e.target.name);
        var value=field.attributes.getNamedItem("value").value+e.target.value;
        if(value=="")
        field.innerHTML="--------";
        else{
            if(field.value!=undefined)
            field.innerHTML=field.attributes.getNamedItem("value")+value;
            else
            field.innerHTML=value;
        }
    }
</script>
</body>
</html>