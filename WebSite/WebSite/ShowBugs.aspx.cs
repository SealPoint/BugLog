using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite
{
    public partial class ShowBugs : System.Web.UI.Page
    {
        private string _userIDStr;

        protected void Page_Load (object aSender, EventArgs aEventArgs)
        {
            _userIDStr = Request["userid"];
            string errorStr = "";
            List<BugInfo> bugs = DBUtility.Instance().GetRecentBugs(_userIDStr,
                                                                    ref errorStr);

            if (errorStr.Length > 0)
            {
                NoBugs.Text = errorStr;
            }
            else if (bugs.Count == 0)
            {
                NoBugs.Text = "You didn't report any bugs yet.";
            }
        }

        protected void ReportBug (object aSender, EventArgs aEventArgs)
        {
            Response.Redirect("ReportBug.aspx?userid=" + _userIDStr);
        }
    }
}
