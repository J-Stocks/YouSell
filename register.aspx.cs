using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ButtonRegister_Click(object sender, EventArgs e)
    {
        GridViewVerification.DataBind();
        if (GridViewVerification.Rows.Count == 0)
        {
            SqlDataSourceRegister.Insert();
            Response.Redirect("login.aspx");
        }
        else
        {

            LabelRegisterErrorMessage.Text = "That User Name is already in use.";
        }
    }
}