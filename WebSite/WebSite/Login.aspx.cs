using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace WebSite
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object aSender, EventArgs aEventArgs)
        {

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
                string errorStr = "";
                int userID = DBUtility.Instance().GetUserID(Email.Text,
                                                            Password.Text,
                                                            ref errorStr);

                if (userID > 0)
                {
                    Session["UserID"] = userID.ToString();
                    Response.Redirect("ShowBugs.aspx");

                }
                else
                {
                    if (errorStr.Length > 0)
                    {
                        ErrorText.Text = errorStr;
                    }
                    else
                    {
                        ErrorText.Text = "User " + Email.Text + " does not exist.";
                    }

                    ErrorText.Visible = true;
                }
            }
        }
    }
}
