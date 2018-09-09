using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Drawing;

namespace WebSite
{
    public partial class SaveBug : System.Web.UI.Page
    {
        Dictionary<string, Color> statusColorData;

        protected void Page_Load (object aSender, EventArgs aEventArgs)
        {
            statusColorData = new Dictionary<string, Color>();
            statusColorData.Add("Reported", Color.FromArgb(0xff, 0x50, 0x50));
            statusColorData.Add("In Progress", Color.FromArgb(0xff, 0xff, 0x66));
            statusColorData.Add("Fixed", Color.FromArgb(0x66, 0xff, 0x66));
            string selectedStatus = "Reported";

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
                    selectedStatus = bug.Status;
                }
            }

            BugStatus.Text = selectedStatus;
            BugStatus.BackColor = statusColorData[selectedStatus];

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
                                               BugStatus.Text,
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
