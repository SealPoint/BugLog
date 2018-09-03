<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebSite._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>BugLog Login</title>
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
        
        .loginPad
        {
            position: absolute;
            width: 300px;
            height: 200px;
            z-index: 15;
            top: 50%;
            left: 50%;
            margin: -100px 0 0 -150px;
        }
        
        .login
        {
            width: 256px;
        }
        
        .submit
        {
            width: 100px;
            font-family: Times New Roman;
            font-size: 14pt;
        }
        
        .errorText
        {
            font-family: Times New Roman;
            font-size: 14pt;
            color: #FF0000;
        }
    </style>
</head>
<body class="body">
    <form id="form1" runat="server">
        <div class="headerPad">
            Welcome to BugLog!
        </div>
        <div class="loginPad">
            <table border="0">
                <tr>
                    <td>
                        e-mail:
                    </td>
                    <td>
                        <asp:TextBox id="Email" runat="server" CssClass="login" />
                    </td>
                </tr>
                <tr>
                    <td>
                        password:
                    </td>
                    <td>
                        <asp:TextBox TextMode="Password" id="Password" runat="server" CssClass="login" />
                    </td>
                </tr>
                <tr align="center">
                    <td></td>
                    <td>
                        <asp:Button id="submit" runat="server" Text="Log In" CssClass="submit" OnClick="ValidateLogin" />
                    </td>
                </tr>
            </table>
            <table border="0">
                <tr>
                    <td>
                        <asp:Label id="ErrorText" runat="server" CssClass="errorText" Visible="false"/>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
