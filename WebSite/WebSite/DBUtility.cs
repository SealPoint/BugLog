using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Configuration;
using System.Web.Configuration;

using System.Data.SqlClient;

namespace WebSite
{
    public class DBUtility
    {
        private static DBUtility _instance = null;

        public static DBUtility instance ()
        {
            if (_instance == null)
            {
                _instance = new DBUtility();
            }

            return _instance;
        }

        //==============================================================
        /// <summary>
        /// Gets the value of aConfigParamName from Web.config.
        /// </summary>
        /// <param name="aConfigParamName">The name of the parameter
        /// in WebConfig.xml</param>
        /// <returns>The value of the config parameter if it is
        /// defined in WebConfig.xml, otherwise null </returns>
        private string getConfigValue(string aConfigParamName)
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
        /// <param name="aErrorStr">The description of a DB error</param>
        /// <returns>The user ID if the user exists in the DB, -1 otherwise
        /// </returns>
        public int GetUserID (string aEmail,
                              string aPassword,
                              ref string aErrorStr)
        {
            string connStr = getConfigValue("ConnString");
            int userID = -1;

            if (connStr == null)
            {
                aErrorStr = "No connection string specified";
                return userID;
            }

            SqlConnection connection = new SqlConnection(connStr);
            bool result = false;

            try
            {
                connection.Open();

                string query = "SELECT [ID] FROM Users WHERE Email LIKE '"
                    + aEmail
                    + "' AND Password LIKE '"
                    + getHashCode(aPassword)
                    + "'";
                SqlCommand command = new SqlCommand(query, connection);
                SqlDataReader dataReader = command.ExecuteReader();

                // The user exists in the DB
                if (dataReader.Read())
                {
                    userID = dataReader.GetInt32(0);
                }

                dataReader.Close();
                command.Dispose();


            }
            catch (Exception ex)
            {
                aErrorStr = ex.Message;
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

            return userID;
        }
    }
}
