<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowBugs.aspx.cs" Inherits="WebSite.ShowBugs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Show Bugs</title>
    <style type="text/css">
        .body
        {
            background-color: #A0B6D4;
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
            width: 80%;
            height: 200px;
            z-index: 15;
            top: 42%;
            left: 20%;
            margin: -100px 0 0 -150px;
        }
        table.blueTable
        {
            border: 1px solid #1C6EA4;
            background-color: #EEEEEE;
            width: 100%;
            text-align: left;
            border-collapse: collapse;
        }
        table.blueTable td, table.blueTable th
        {
            border: 1px solid #AAAAAA;
            padding: 3px 2px;
            font-family: Calibri;
        }
        table.blueTable tbody td
        {
            font-size: 15px;
        }
        table.blueTable tr:nth-child(even)
        {
            background: #D0E4F5;
        }
        table.blueTable thead
        {
            background: #1C6EA4;
            background: -moz-linear-gradient(top, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
            background: -webkit-linear-gradient(top, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
            background: linear-gradient(to bottom, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
            border-bottom: 2px solid #444444;
        }
        table.blueTable thead th
        {
            font-size: 15px;
            font-weight: bold;
            color: #FFFFFF;
            border-left: 2px solid #D0E4F5;
        }
        table.blueTable thead th:first-child
        {
            border-left: none;
        }

        table.blueTable tfoot
        {
            font-size: 14px;
            font-weight: bold;
            color: #FFFFFF;
            background: #D0E4F5;
            background: -moz-linear-gradient(top, #dcebf7 0%, #d4e6f6 66%, #D0E4F5 100%);
            background: -webkit-linear-gradient(top, #dcebf7 0%, #d4e6f6 66%, #D0E4F5 100%);
            background: linear-gradient(to bottom, #dcebf7 0%, #d4e6f6 66%, #D0E4F5 100%);
            border-top: 2px solid #444444;
        }
        table.blueTable tfoot td
        {
            font-size: 14px;
        }
        table.blueTable tfoot .links
        {
            text-align: right;
        }
        table.blueTable tfoot .links a
        {
            display: block;
            background: #1C6EA4;
            color: #FFFFFF;
            padding: 2px 8px;
            border: 5px;
        }
        .button
        {
            width: 150px;
        }
        a{
  text-decoration: none;
  background-color: #EEEEEE;
  color: #333333;
  padding: 2px 6px 2px 6px;

}
        .reportedStatus
        {
            background-color: #FF5050;
        }
    </style>
</head>
<body class="body">
    <form id="form1" runat="server">
        <div class="headerPad">
            Your Bugs
        </div>
        <div class="centralPad">
            <table id="BugTable" class="blueTable">
                <thead>
                    <tr>
                        <th>Bug ID</th>
                        <th>Title/Description</th>
                        <th>Status</th>
                        <th></th>
                    </tr>
                </thead>
                <%
                    string errorStr = "";
                    System.Collections.Generic.List<WebSite.BugInfo> bugs
                        = WebSite.DBUtility.Instance().GetRecentBugs(Session["userID"].ToString(),
                                                                     ref errorStr);

                    for (int i = 0; i < bugs.Count; ++i)
                    {
                        Response.Write("<tr>"
                                       + "<td width=\"50\">Bug" + bugs[i].ID + "</td>"
                                       + "<td>" + bugs[i].Title + "</td>"
                                       + "<td class=\"reportedStatus\" width=\"70\">" + bugs[i].Status + "</td>"
                                       + "<td padding=\"2px\" width=\"50\"><a href=\"ReportBug.aspx?BugID="
                                       + bugs[i].ID + "\">View/Edit</a></td>"
                                       + "</tr>");
                    } 
                %>
            </table>
            <table border="0">
                <tr>
                    <td align="center">
                        <asp:Button ID="ReportBug" runat="server" Text="Report Bug" OnClick="ReportNewBug" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
