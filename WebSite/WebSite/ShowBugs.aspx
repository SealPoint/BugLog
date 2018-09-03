<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowBugs.aspx.cs" Inherits="WebSite.ShowBugs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Show Bugs</title>
    <style>
        .body
        {
            background-color: #7092BE;
            font-family: Times New Roman;
            font-size: 14pt;
            color: #FFFF00;
        }
        
        .headerPad
        {
            position: absolute;
            width: 500px;
            height: 100px;
            z-index: 15;
            top: 30%;
            left: 48%;
            margin: -100px 0 0 -150px;
            font-family: Edwardian Script ITC;
            font-size: 48pt;
        }
    </style>
</head>
<body class="body">
    <form id="form1" runat="server">
        <div class="headerPad">
            Your Bugs
        </div>
    </form>
</body>
</html>
