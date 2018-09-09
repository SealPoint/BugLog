using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite
{
    public partial class SaveBug : System.Web.UI.Page
    {
        protected void Page_Load (object aSender, EventArgs aEventArgs)
        {
      
            if (Request["BugId"] != null)
            {
                string errorMsg = "";
                BugInfo bug = DBUtility.Instance().GetBugInfo(Request["BugID"], ref errorMsg);

                if (errorMsg.Length > 0)
                {
                    Response.Write(errorMsg);
                }

                if (bug != null)
                {
                    BugTitle.Text = bug.Title;
                    BugDescription.Text = bug.Description;
                }
            }

            BugTitle.Focus();
        }

        protected void SaveBugInfo (object aSender, EventArgs aEventArgs)
        {
            string errorStr = "";

            if (Request["BugId"] == null)
            {
                DBUtility.Instance().ReportBug(Session["UserID"].ToString(),
                                               BugTitle.Text,
                                               BugDescription.Text,
                                               ref errorStr);
            }
            if (errorStr.Length > 0)
            {
                Response.Write(errorStr);
            }
            else
            {
                Response.Redirect("ShowBugs.aspx?userid=" + Request["userid"]);
            }
        }

        protected void CancelBug(object aSender, EventArgs aEventArgs)
        {
            Response.Redirect("ShowBugs.aspx?userid=" + Request["userid"]);
        }
    }
}
