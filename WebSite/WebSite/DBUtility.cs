﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Configuration;
using System.Web.Configuration;
using System.Web.Hosting;

using System.Data.SqlClient;


namespace WebSite
{
    public class DBUtility
    {
        private static DBUtility _instance = null;

        //==============================================================
        /// <summary>
        /// Returns the only instance of this class
        /// </summary>
        /// <returns></returns>
        public static DBUtility Instance()
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
        private string GetConfigValue (string aConfigParamName)
        {
            string physDir = HostingEnvironment.ApplicationPhysicalPath;
            string virtPath = HostingEnvironment.ApplicationVirtualPath;

            Configuration webConfig
                = WebConfigurationManager.OpenWebConfiguration("~/web.config");

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
        private string GetHashCode (string aString)
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
            string connStr = GetConfigValue("ConnString");
            int userID = -1;

            if (connStr == null)
            {
                aErrorStr = "No connection string specified";
                return userID;
            }

            SqlConnection connection = new SqlConnection(connStr);

            try
            {
                connection.Open();

                string query = "SELECT [ID] FROM Users WHERE Email LIKE '"
                    + aEmail
                    + "' AND Password LIKE '"
                    + GetHashCode(aPassword)
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
                    aErrorStr += ex.Message;
                }
            }

            return userID;
        }

        //==============================================================
        /// <summary>
        /// Returns top recent bugs reported by the given user.
        /// </summary>
        /// <param name="aUserID">The ID of the user</param>
        /// <param name="aErrorStr">The description of a DB error</param>
        /// <returns>
        /// </returns>
        public List<BugInfo> GetRecentBugs (string aUserID,
                                            ref string aErrorStr)
        {
            List<BugInfo> bugs = new List<BugInfo>();
            string connStr = GetConfigValue("ConnString");

            if (connStr == null)
            {
                aErrorStr = "No connection string specified";
                return bugs;
            }

            SqlConnection connection = new SqlConnection(connStr);

            try
            {
                connection.Open();

                string query = "SELECT TOP 10 [ID], Title, Description, Status"
                               + " FROM Bugs"
                               + " WHERE UserID = "
                               + aUserID
                               + " ORDER BY [ID] DESC";
                SqlCommand command = new SqlCommand(query, connection);
                SqlDataReader dataReader = command.ExecuteReader();

                // Fill the bug info
                while (dataReader.Read())
                {
                    int bugID = dataReader.GetInt32(0);
                    string bugTitle = dataReader.GetString(1);
                    string bugDescription = dataReader.GetString(2);
                    string bugStatus = dataReader.GetString(3);
                    BugInfo bugInfo = new BugInfo(bugID, bugTitle, bugDescription, bugStatus);
                    bugs.Add(bugInfo);
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
                    aErrorStr += ex.Message;
                }
            }

            return bugs;
        }

        //==============================================================
        /// <summary>
        /// Returns the bug data, given a bug ID.
        /// </summary>
        /// <param name="aBugId">The ID of the bug</param>
        /// <param name="aErrorStr">The description of a DB error</param>
        /// <returns>
        /// The bug title, dscription, etc. if the bug is in the DB,
        /// null otherwise.
        /// </returns>
        public BugInfo GetBugInfo (string aBugID,
                                   ref string aErrorStr)
        {
            BugInfo bug = null;
            string connStr = GetConfigValue("ConnString");

            if (connStr == null)
            {
                aErrorStr = "No connection string specified";
                return bug;
            }

            SqlConnection connection = new SqlConnection(connStr);

            try
            {
                connection.Open();

                string query = "SELECT [ID], Title, Description, Status"
                               + " FROM Bugs"
                               + " WHERE [ID] = " + aBugID;
                               
                SqlCommand command = new SqlCommand(query, connection);
                SqlDataReader dataReader = command.ExecuteReader();

                // Fill the bug info
                if (dataReader.Read())
                {
                    int bugID = dataReader.GetInt32(0);
                    string bugTitle = dataReader.GetString(1);
                    string bugDescription = dataReader.GetString(2);
                    string bugStatus = dataReader.GetString(3);
                    bug = new BugInfo(bugID, bugTitle, bugDescription, bugStatus);
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
                    aErrorStr += ex.Message;
                }
            }

            return bug;
        }

        //==============================================================
        /// <summary>
        /// Adds a new bug to the DB.
        /// </summary>
        /// <param name="aUserID">The ID of the user who reported the bug</param>
        /// <param name="aTitle">The brief description of the bug</param>
        /// <param name="aDescription">The steps to reproduce.</param>
        /// <param name="aBugStatus">Reported, In Progress or Fixed</param>
        /// <param name="aErrorStr">The description of a DB error</param>
        public void ReportBug(string aUserID,
                              string aTitle,
                              string aDescription,
                              string aBugStatus,
                              ref string aErrorStr)
        {
            string connStr = GetConfigValue("ConnString");

            if (connStr == null)
            {
                aErrorStr = "No connection string specified";
                return;
            }

            SqlConnection connection = new SqlConnection(connStr);

            try
            {
                connection.Open();

                string query = "INSERT INTO Bugs(Title, Description, Status, UserID)"
                    + " VALUES('" + aTitle.Replace("'", "''")
                    + "', '"
                    + aDescription.Replace("'", "''")
                    + "', '"
                    + aBugStatus + "', " + aUserID + ")";
 
                SqlCommand command = new SqlCommand(query, connection);
                command.ExecuteNonQuery();

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
                    aErrorStr += ex.Message;
                }
            }
        }

        //==============================================================
        /// <summary>
        /// Modifies the data for the existing bug in the DB.
        /// </summary>
        /// <param name="aBugInfo">The data about the bug</param>
        /// <param name="aErrorStr">The description of a DB error</param>
        public void SaveBugInfo(BugInfo aBugInfo,
                                ref string aErrorStr)
        {
            string connStr = GetConfigValue("ConnString");

            if (connStr == null)
            {
                aErrorStr = "No connection string specified";
                return;
            }

            SqlConnection connection = new SqlConnection(connStr);

            try
            {
                connection.Open();

                string query = "UPDATE Bugs SET Title = '"
                    + aBugInfo.Title.Replace("'", "''")
                    + "', Description = '"
                    + aBugInfo.Description.Replace("'", "''")
                    + "', Status = '"
                    + aBugInfo.Status + "' WHERE [ID] = " + aBugInfo.ID;

                SqlCommand command = new SqlCommand(query, connection);
                command.ExecuteNonQuery();

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
                    aErrorStr += ex.Message;
                }
            }
        }

        //==============================================================
        /// <summary>
        /// Deletes a bug from the DB.
        /// </summary>
        /// <param name="aBugIS">The ID of the bug</param>
        /// <param name="aErrorStr">The description of a DB error</param>
        public void DeleteBug(string aBugID,
                              ref string aErrorStr)
        {
            string connStr = GetConfigValue("ConnString");

            if (connStr == null)
            {
                aErrorStr = "No connection string specified";
                return;
            }

            SqlConnection connection = new SqlConnection(connStr);

            try
            {
                connection.Open();

                string query = "DELETE FROM Bugs WHERE [ID] = " + aBugID;

                SqlCommand command = new SqlCommand(query, connection);
                command.ExecuteNonQuery();

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
                    aErrorStr += ex.Message;
                }
            }
        }
    }
}
