using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class search : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["now"] = DateTime.Now;
    }

    protected void GridViewSearchResults_SelectedIndexChanged(object sender, EventArgs e)
    {
        int rowNum = GridViewSearchResults.SelectedIndex;
        Session["lotId"] = GridViewSearchResults.Rows[rowNum].Cells[1].Text;
        Response.Redirect("lot.aspx");
    }
}