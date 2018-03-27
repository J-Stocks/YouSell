using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ButtonLogin_Click(object sender, EventArgs e)
    {
        GridViewLogin.DataBind();
        if (GridViewLogin.Rows.Count == 1)
        {
            Session["login"] = true;
            Session["userID"] = GridViewLogin.Rows[0].Cells[0].Text;
            Session["userRole"] = GridViewLogin.Rows[0].Cells[1].Text;
            System.Diagnostics.Debug.WriteLine(Session["userRole"]);
            Response.Redirect("myaccount.aspx");
        }
        else
        {

            LabelLoginErrorMessage.Text = "Plase enter a valid User Name and Password.";
        }
    }
}