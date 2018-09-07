using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace WebSite
{
    public partial class ShowBugs : System.Web.UI.Page
    {
        protected void Page_Load (object aSender, EventArgs aEventArgs)
        {
        }

        protected void ReportNewBug (object aSender, EventArgs aEventArgs)
        {
            Response.Redirect("ReportBug.aspx");
        }
    }
}
