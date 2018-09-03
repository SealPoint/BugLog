<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportBug.aspx.cs" Inherits="WebSite.ReportBug" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Report a Bug</title>
    <style type="text/css">
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
            width: 700px;
            height: 200px;
            z-index: 15;
            top: 45%;
            left: 40%;
            margin: -100px 0 0 -150px;
        }
        .title
        {
            width: 500px;
        }
        .subtitle
        {
            font-size: 12pt;
        }
        .gap
        {
            height: 30px;
        }
        .description
        {
            width: 500px;
            height: 300px;
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
            Report a Bug
        </div>
        <div class="centralPad">
            <table border="0">
                <tr>
                    <td align="right">
                    Bug Title:&nbsp;
                    </td>
                    <td>
                        <asp:TextBox runat="server" id="BugTitle" CssClass="title" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td class="subtitle">Please provide a brief description</td>
                </tr>
                <tr class="gap" />
                <tr>
                    <td valign="top">Steps to reproduce:&nbsp;</td>
                    <td>
                        <asp:TextBox TextMode="MultiLine" id="BugDescription" runat="server" CssClass="description" />
                    </td>
                </tr>
                <tr align="center">
                    <td></td>
                    <td>
                        <asp:Button ID="CreateBug" runat="server" Text="Report Bug" CssClass="button" OnClick="CreateNewBug" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
