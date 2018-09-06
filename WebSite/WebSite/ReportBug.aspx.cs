using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite
{
    public partial class ReportBug : System.Web.UI.Page
    {
        protected void Page_Load (object aSender, EventArgs aEventArgs)
        {

        }

        protected void CreateNewBug (object aSender, EventArgs aEventArgs)
        {
            string errorStr = "";
            DBUtility.Instance().ReportBug(Request["userid"],
                                           BugTitle.Text,
                                           BugDescription.Text,
                                           ref errorStr);
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
