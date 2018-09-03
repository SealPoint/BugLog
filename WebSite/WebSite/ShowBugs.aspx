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
        .centralPad
        {
            position: absolute;
            width: 300px;
            height: 200px;
            z-index: 15;
            top: 50%;
            left: 50%;
            margin: -100px 0 0 -150px;
        }
        
        .button
        {
            width: 150px;
            font-family: Times New Roman;
            font-size: 14pt;
        }
    </style>
</head>
<body class="body">
    <form id="form1" runat="server">
        <div class="headerPad">
            Your Bugs
        </div>
        <div class="centralPad">
            <table border="0">
                <tr>
                    <td>
                        <asp:Label id="NoBugs" runat="server" />
                    </td>
                </tr>
                <tr align="center">
                    <td>
                        <asp:Button id="submit" runat="server" Text="Report a Bug" CssClass="button" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
