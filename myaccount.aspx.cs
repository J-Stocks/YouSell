using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class myaccount : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Validation.isLoggedIn(Session["login"]))
        {
            Response.Redirect("login.aspx");
        }
        if (Session["userRole"].ToString() == "s")
        {
            addLot.Visible = true;
        }
    }

    protected void ButtonAddLot_Click(object sender, EventArgs e)
    {
        Session["startingBid"] = Convert.ToDouble(startBid.Text);
        Session["startDate"] = DateTime.Now;
        Session["endDate"] = Convert.ToDateTime(endDate.Text);
        FileUpload userImage = FileUploadImage;
        string imageFilepath = "~/images/user/" + userImage.FileName;
        if (imageFilepath != "~/images/user/")
        {
            Session["imageUrl"] = imageFilepath;
            string serverFilepath = Server.MapPath(imageFilepath);
            userImage.PostedFile.SaveAs(serverFilepath);
        }
        else
        {
            Session["imageUrl"] = "";
        }
        SqlDataSourceAddLot.Insert();
    }
}