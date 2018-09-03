using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Web.Configuration;

using System.Data.SqlClient;

namespace WebSite
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object aSender, EventArgs aEventArgs)
        {

        }

        //==============================================================
        /// <summary>
        /// Gets the value of aConfigParamName from Web.config.
        /// </summary>
        /// <param name="aConfigParamName">The name of the parameter
        /// in WebConfig.xml</param>
        /// <returns>The value of the config parameter if it is
        /// defined in WebConfig.xml, otherwise null </returns>
        private string getConfigValue (string aConfigParamName)
        {
            Configuration webConfig
                = WebConfigurationManager.OpenWebConfiguration("/");

            if (webConfig.AppSettings.Settings.Count > 0)
            {
                KeyValueConfigurationElement customSetting
                    = webConfig.AppSettings.Settings[aConfigParamName];

                if (customSetting != null)
                {
                    return customSetting.Value;
                }
            }

            return null;
        }

        //==============================================================
        /// <summary>
        /// A helper method that generates a permanent hash string.
        /// </summary>
        /// <param name="aString"></param>
        /// <returns>The hash as a string</returns>
        private string getHashCode (string aString)
        {
            int hash1 = 5381;
            int hash2 = hash1;

            for (int i = 0;
                 i < aString.Length &&
                 aString[i] != '\0';
                 i += 2)
            {
                hash1 = ((hash1 << 5) + hash1) ^ aString[i];
                if (i == aString.Length - 1 ||
                    aString[i + 1] == '\0')
                {
                    break;
                }

                hash2 = ((hash2 << 5) + hash2) ^ aString[i + 1];
            }

            return (hash1 + (hash2 * 1566083941)).ToString();
        }

        //==============================================================
        /// <summary>
        /// Checks if a user with aEmail and aPassword exists in the DB.
        /// </summary>
        /// <param name="aEmail">The e-mail</param>
        /// <param name="aPassword">The password</param>
        /// <returns>True if the user exists in the DB, false otherwise
        /// </returns>
        private bool ValidateUserInDB(string aEmail, string aPassword)
        {
            string connStr = getConfigValue("ConnString");

            if (connStr == null)
            {
                Response.Write("No connection string");
                return false;
            }

            SqlConnection connection = new SqlConnection(connStr);
            bool result = false;

            try
            {
                connection.Open();

                string query = "SELECT * FROM Users WHERE Email LIKE '"
                    + aEmail
                    + "' AND Password LIKE '" 
                    + getHashCode(aPassword) 
                    + "'";
                SqlCommand command = new SqlCommand(query, connection);
                SqlDataReader dataReader = command.ExecuteReader();

                // The user exists in the DB
                if (dataReader.Read())
                {
                    result = true;
                }

                dataReader.Close();
                command.Dispose();


            }
            catch (Exception ex)
            {
                Response.Write("Cannot open connection!");
            }
            finally
            {
                try
                {
                    connection.Close();
                }
                catch (Exception ex)
                {
                }
            }

            return result;
        }

        //==============================================================
        /// <summary>
        /// Checks the values of e-mail and password to make sure that
        /// the user exists in the DB.
        /// </summary>
        /// <param name="aSender">The log in button</param>
        /// <param name="aEventArgs">The optional event arguments</param>
        public void ValidateLogin (object aSender, EventArgs aEventArgs)
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
    }
}
