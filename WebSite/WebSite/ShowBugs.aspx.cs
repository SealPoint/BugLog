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
        protected void Page_Load (object sender, EventArgs e)
        {
            string userIDStr = Request["userid"];
            string errorStr = "";
            List<BugInfo> bugs = DBUtility.instance().GetRecentBugs(userIDStr,
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
    }
}
