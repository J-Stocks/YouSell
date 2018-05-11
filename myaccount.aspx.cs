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
        double userStartBid;
        bool validStartBid = double.TryParse(startBid.Text, out userStartBid);
        if (validStartBid)
        {
            validStartBid = validStartBid && userStartBid >= 0;
        }

        DateTime userEndDate;
        bool validEndDate = DateTime.TryParse(endDate.Text, out userEndDate);
        if (validEndDate)
        {
            validEndDate = validEndDate && DateTime.Compare(userEndDate, DateTime.Now) > 0;
        }

        FileUpload userImage = FileUploadImage;
        string imageFileExtention = userImage.FileName.ToLower().Substring(userImage.FileName.IndexOf(".") + 1);
        bool validFileExtention = imageFileExtention.IndexOf("jpg") >= 0 || imageFileExtention.IndexOf("png") >= 0 || imageFileExtention.IndexOf("jpeg") >= 0;
        bool validFilenameLength = true;
        if (userImage.HasFile)
        {
            validFilenameLength = userImage.FileName.Length <= 200;
        }

        if (validStartBid && validEndDate && ((validFileExtention && validFilenameLength) || !userImage.HasFile))
        {
            Session["startingBid"] = userStartBid;
            Session["startDate"] = DateTime.Now;
            Session["endDate"] = userEndDate;
            if (userImage.HasFile)
            {
                string imageFilepath = "~/images/user/" + userImage.FileName;
                Session["imageUrl"] = imageFilepath;
                string serverFilepath = Server.MapPath(imageFilepath);
                userImage.PostedFile.SaveAs(serverFilepath);
            }
            else
            {
                Session["imageUrl"] = "~/images/static/imageunavailable.png";
            }
            SqlDataSourceAddLot.Insert();
            GridViewMyLots.DataBind();
            GridViewMyLotsHidden.DataBind();
            PlaceHolderMyLots.Visible = true;
        }
        if (!validStartBid)
        {
            LabelStartBidErrorMessage.Text = "Please enter a valid Starting bid.";
        }
        if (!validEndDate)
        {
            LabelEndDateErrorMessage.Text = "Please enter a valid End Date";
        }
        if (userImage.HasFile)
        {
            if (!validFileExtention && !validFilenameLength)
            {
                LabelUploadImageErrorMessage.Text = "Please upload a .jpg or .png image with a filename less than 200 characters long.";
            }
            else if (!validFileExtention)
            {
                LabelUploadImageErrorMessage.Text = "Please upload a .jpg or .png image.";
            }
            else if (!validFilenameLength)
            {
                LabelUploadImageErrorMessage.Text = "Filename must be less than 200 characters.";
            }
        }
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
                GridViewMyLots.DataBind();
                GridViewMyLotsHidden.DataBind();
                GridViewMyBids.DataBind();
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
                GridViewMyLots.DataBind();
                GridViewMyLotsHidden.DataBind();
                GridViewMyBids.DataBind();
                break;
            default:
                System.Diagnostics.Debug.WriteLine("Invalid Command Name");
                break;
        }
    }
}