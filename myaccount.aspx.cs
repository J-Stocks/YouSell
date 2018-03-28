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
        if (GridViewMyLots.Rows.Count == 0)
        {
            PlaceHolderMyLots.Visible = false;
        }
        if (GridViewMyBids.Rows.Count == 0)
        {
            PlaceHolderMyBids.Visible = false;
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
        GridViewMyLots.DataBind();
        GridViewMyLotsHidden.DataBind();
        PlaceHolderMyLots.Visible = true;
    }

    protected void GridViewMyLots_RowCommand1(object sender, GridViewCommandEventArgs e)
    {
        int rowNum = Convert.ToInt32(e.CommandArgument);
        Session["lotId"] = GridViewMyLotsHidden.Rows[rowNum].Cells[0].Text;
        switch (e.CommandName)
        {
            case "viewDetails":
                Response.Redirect("lot.aspx");
                break;
            case "deleteLot":
                SqlDataSourceCleanUpBids.Delete();
                SqlDataSourceMyLots.Delete();
                break;
            default:
                System.Diagnostics.Debug.WriteLine("Invalid Command Name");
                break;
        }
    }

    protected void GridViewMyBids_RowCommand1(object sender, GridViewCommandEventArgs e)
    {
        int rowNum = Convert.ToInt32(e.CommandArgument);
        Session["lotId"] = GridViewMyBidsHidden.Rows[rowNum].Cells[0].Text;
        switch (e.CommandName)
        {
            case "viewDetails":
                Response.Redirect("lot.aspx");
                break;
            case "deleteBid":
                SqlDataSourceMyBids.Delete();
                break;
            default:
                System.Diagnostics.Debug.WriteLine("Invalid Command Name");
                break;
        }
    }

    protected void GridViewMyBids_SelectedIndexChanged(object sender, EventArgs e)
    {
        int rowNum = GridViewMyBids.SelectedIndex;
        Session["lotId"] = GridViewMyBidsHidden.Rows[rowNum].Cells[0].Text;
        Response.Redirect("lot.aspx");
    }
}