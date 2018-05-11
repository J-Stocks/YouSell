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
        Session["lotId"] = GridViewSearchResultsHidden.Rows[rowNum].Cells[0].Text;
        Response.Redirect("lot.aspx");
    }

    protected void ButtonSearch_Click(object sender, EventArgs e)
    {
        string tempQueryWithBids = "SELECT lot.lotId, lot.lotName AS 'Name', category.categoryName AS 'Category', lot.startDate AS 'Start Date', lot.endDate AS 'End Date', (SELECT TOP 1 amount FROM bid WHERE bid.lotId = lot.lotId ORDER BY amount DESC) AS 'Current Bid', lot.imageUrl AS 'imageUrl' FROM lot INNER JOIN category ON lot.categoryId = category.categoryId WHERE lot.endDate > @endDate AND lot.lotId IN (SELECT lot.lotId FROM lot INNER JOIN bid ON lot.lotId = bid.lotId)";
        string tempQueryNoBids = "SELECT lot.lotId, lot.lotName AS 'Name', category.categoryName AS 'Category', lot.startDate AS 'Start Date', lot.endDate AS 'End Date', lot.startingBid AS 'Current Bid', lot.imageUrl AS 'imageUrl' FROM lot INNER JOIN category ON lot.categoryId = category.categoryId WHERE lot.endDate > @endDate AND lot.lotId NOT IN (SELECT lot.lotId FROM lot INNER JOIN bid ON lot.lotId = bid.lotId)";

        if (DropDownListCategory.SelectedValue != "0")
        {
            tempQueryWithBids += " AND lot.categoryId = " + DropDownListCategory.SelectedValue;
            tempQueryNoBids += " AND lot.categoryId = " + DropDownListCategory.SelectedValue;
        }

        string[] searchTerms = Search.getSearchTerms(TextBoxLotName.Text);
        if (searchTerms.Length > 0)
        {
            foreach (string term in searchTerms)
            {
                tempQueryWithBids += " AND ( lot.lotName LIKE '%" + term + "%' OR lot.description LIKE '%" + term + "%' )";
                tempQueryNoBids += " AND ( lot.lotName LIKE '%" + term + "%' OR lot.description LIKE '%" + term + "%' )";
            }
            //for (int i = 0; i < searchTerms.Length; i++)
            //{
            //    tempQuery += " AND ( lot.lotName LIKE '%" + searchTerms[i] + "%' OR lot.description LIKE '%" + searchTerms[i] + "%' )";
            //}
        }

        string finalQuery = tempQueryWithBids + " UNION " + tempQueryNoBids + ";";

        SqlDataSourceSearch.SelectCommand = finalQuery;
        GridViewSearchResults.DataBind();
        GridViewSearchResultsHidden.DataBind();
    }
}