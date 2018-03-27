using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class lot : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Validation.isLoggedIn(Session["login"]))
        {
            Response.Redirect("login.aspx");
        }
        if (Session["lotID"] == null)
        {
            Response.Redirect("search.aspx");
        }
        if (GridViewBidHistory.Rows.Count == 0)
        {
            PlaceHolderBidHistory.Visible = false;
        }
        
    }

    protected void ButtonBid_Click(object sender, EventArgs e)
    {
        LabelBidErrorMessage.Text = "";
        double userBid;
        bool validBid = Double.TryParse(bidBox.Text, out userBid);
        Session["buyerBid"] = userBid;
        Session["now"] = DateTime.Now;
        bool exitingBids = GridViewBidHistory.Rows.Count != 0;

        string startingBidText = GridViewLotDetails.Rows[0].Cells[3].Text;
        double startingBid = Convert.ToDouble(startingBidText.Substring(6));
        double highestBid = startingBid;
        if (exitingBids)
        {
            string highestBidText = GridViewBidHistory.Rows[0].Cells[1].Text;
            highestBid = Convert.ToDouble(highestBidText.Substring(6));
        }

        if (!validBid)
        {
            LabelBidErrorMessage.Text = "Please enter you bid as a number.";
        }
        else if (userBid <= highestBid)
        {
            LabelBidErrorMessage.Text = "New bids must be higher than the current highest bid.";
        }
        else
        {
            if (GridViewAddBid.Rows.Count == 0)
            {
                SqlDataSourceBid.Insert();
                GridViewBidHistory.DataBind();
            }
            else
            {
                SqlDataSourceBid.Update();
            }

            if (!exitingBids)
            {
                PlaceHolderBidHistory.Visible = true;
            }

            GridViewBidHistory.DataBind();
            GridViewAddBid.DataBind();
        }
    }
}