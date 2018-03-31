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
        string tempQuery = "SELECT lot.lotId, lot.lotName AS 'Name', category.categoryName AS 'Category', lot.startDate AS 'Start Date', lot.endDate AS 'End Date', lot.imageUrl AS 'imageUrl' FROM lot INNER JOIN category ON lot.categoryId = category.categoryId WHERE lot.endDate > @endDate";

        if (DropDownListCategory.SelectedValue != "0")
        {
            tempQuery += " AND lot.categoryId = " + DropDownListCategory.SelectedValue;
        }

        string[] searchTerms = Search.getSearchTerms(TextBoxLotName.Text);
        if (searchTerms.Length > 0)
        {
            for (int i = 0; i < searchTerms.Length; i++)
            {
                tempQuery += " AND ( lot.lotName LIKE '%" + searchTerms[i] + "%' OR lot.description LIKE '%" + searchTerms[i] + "%' )";
            }
        }

        tempQuery += ";";

        SqlDataSourceSearch.SelectCommand = tempQuery;
        GridViewSearchResults.DataBind();
        GridViewSearchResultsHidden.DataBind();
    }
}