<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebSite._Default" %>
<script runat="server">
    
public string getHashCode (string str)
{
    int hash1 = 5381;
    int hash2 = hash1;

    for (int i = 0; i < str.Length && str[i] != '\0'; i += 2)
    {
        hash1 = ((hash1 << 5) + hash1) ^ str[i];
        if (i == str.Length - 1 || str[i + 1] == '\0')
            break;
        hash2 = ((hash2 << 5) + hash2) ^ str[i + 1];
    }

    return (hash1 + (hash2 * 1566083941)).ToString();
}

public bool ValidateUserInDB(string email, string password)
{
    string connStr = "Data Source=Julia-Laptop\\JULIA;Initial Catalog=BugLog;User ID=Julia;Password=quBa&4up";

    System.Data.SqlClient.SqlConnection cnn;
    cnn = new System.Data.SqlClient.SqlConnection(connStr);
    bool result = false;
    
    try
    {
        cnn.Open();

        string query = "SELECT * FROM Users WHERE Email LIKE '"
            + email + "' AND Password LIKE '" + getHashCode(password) + "'";
        System.Data.SqlClient.SqlCommand command = new System.Data.SqlClient.SqlCommand(query, cnn);
        System.Data.SqlClient.SqlDataReader dataReader = command.ExecuteReader();
        if (dataReader.Read())
        {
            result = true;
        }
        dataReader.Close();
        command.Dispose();

        cnn.Close();
    }
    catch (Exception ex)
    {
        Response.Write("Cannot open connection ! ");
    }

    return result;
}
    
public void ValidateLogin (object sender, EventArgs e)
{
    if (Email.Text.Length == 0)
    {
        ErrorText.Text = "Please enter your e-mail.";
        ErrorText.Visible = true;
    }
    else if (Password.Text.Length == 0)
    {
        ErrorText.Text = "Please enter the password.";
        ErrorText.Visible = true;
    }
    else
    {
        // Connect to DB and search for the user.
        if (!ValidateUserInDB(Email.Text, Password.Text))
        {
            ErrorText.Text = "User " + Email.Text + " does not exist.";
            ErrorText.Visible = true;
        }
    }
}
</script>

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
