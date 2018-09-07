<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SaveBug.aspx.cs" Inherits="WebSite.SaveBug" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Report a Bug</title>
    <style type="text/css">
        .body
        {
            background-color: #A0B6D4;
            font-family: Calibri;
            color: #222222;
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
            top: 42%;
            left: 40%;
            margin: -100px 0 0 -150px;
        }
        .title
        {
            width: 500px;
        }
        .subtitle
        {
            font-family: Calibri;
            font-size: 12pt;
        }
        .gap
        {
            height: 10px;
        }
        .description
        {
            font-family: Calibri;
            font-size: 12pt;
            width: 500px;
            height: 300px;
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
                    <td>
                    Bug Title:&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox runat="server" id="BugTitle" CssClass="title" />
                    </td>
                </tr>
                <tr>
                    <td class="subtitle">Please provide a brief description</td>
                </tr>
                <tr class="gap" />
                <tr>
                    <td valign="top">Steps to reproduce the bug:&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox TextMode="MultiLine" id="BugDescription" runat="server" CssClass="description" />
                    </td>
                </tr>
                <tr align="center">
                    <td>
                        <asp:Button ID="CreateBug" runat="server" Text="Save" OnClick="SaveBugInfo" />
                        <asp:Button ID="Cancel" runat="server" Text="Cancel" OnClick="CancelBug" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
