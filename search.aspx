<%@ Page Title="Search - You Sell" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="search.aspx.cs" Inherits="search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="flexStart">
        <div id="searchCriteria" class="flexStart flexCol">
            <asp:Label ID="LabelLotName" runat="server" Text="Search:" AssociatedControlID="TextBoxLotName"></asp:Label>
            <asp:TextBox ID="TextBoxLotName" runat="server"></asp:TextBox>
            <asp:Label ID="LabelCategory" runat="server" Text="Select a category:" AssociatedControlID="DropDownListCategory"></asp:Label>
            <asp:DropDownList ID="DropDownListCategory" runat="server" DataSourceID="SqlDataSourceCategory" DataTextField="categoryName" DataValueField="categoryId" AppendDataBoundItems="True">
                <asp:ListItem Selected="True" Value="0">Select a category</asp:ListItem>
            </asp:DropDownList>
            <asp:Button ID="ButtonSearch" runat="server" Text="Search" OnClick="ButtonSearch_Click" />
        </div>
        <div id="searchResults">
            <asp:GridView ID="GridViewSearchResults" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceSearch" OnSelectedIndexChanged="GridViewSearchResults_SelectedIndexChanged" CssClass="basicGridView noBorders1" Caption="Search Results">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" ButtonType="Button" SelectText="View Details"></asp:CommandField>
                    <asp:BoundField DataField="lotId" HeaderText="lotId" ReadOnly="True" SortExpression="lotId" Visible="False"></asp:BoundField>

                    <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" SortExpression="Name" />
                    <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" ReadOnly="True" />
                    <asp:BoundField DataField="Start Date" HeaderText="Start Date" SortExpression="Start Date" ReadOnly="True" DataFormatString="{0:f}" />
                    <asp:BoundField DataField="End Date" HeaderText="End Date" SortExpression="End Date" ReadOnly="True" DataFormatString="{0:f}" />
                    <asp:BoundField DataField="Current Bid" HeaderText="Current Bid" SortExpression="Current Bid" ReadOnly="True" DataFormatString="{0:c}" />
                    <asp:BoundField DataField="imageUrl" HeaderText="imageUrl" SortExpression="imageUrl" ReadOnly="True" Visible="False" />
                    <asp:ImageField DataImageUrlField="imageUrl" HeaderText="Image"></asp:ImageField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
    <div>
        <asp:GridView ID="GridViewSearchResultsHidden" runat="server" DataSourceID="SqlDataSourceSearch" AutoGenerateColumns="False" Visible="False">
            <Columns>
                <asp:BoundField DataField="lotId" HeaderText="lotId" ReadOnly="True" SortExpression="lotId"></asp:BoundField>
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="Start Date" HeaderText="Start Date" SortExpression="Start Date" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="End Date" HeaderText="End Date" SortExpression="End Date" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="Current Bid" HeaderText="Current Bid" SortExpression="Current Bid" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="imageUrl" HeaderText="imageUrl" ReadOnly="True" SortExpression="imageUrl"></asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceSearch" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringYouSell %>" SelectCommand="SELECT lot.lotId, lot.lotName AS 'Name', category.categoryName AS 'Category', lot.startDate AS 'Start Date', lot.endDate AS 'End Date', (SELECT TOP 1 amount FROM bid WHERE bid.lotId = lot.lotId ORDER BY amount DESC) AS 'Current Bid', lot.imageUrl AS 'imageUrl' FROM lot INNER JOIN category ON lot.categoryId = category.categoryId WHERE lot.endDate > @endDate AND lot.lotId IN (SELECT lotId FROM bid) UNION SELECT lot.lotId, lot.lotName AS 'Name', category.categoryName AS 'Category', lot.startDate AS 'Start Date', lot.endDate AS 'End Date', lot.startingBid AS 'Current Bid', lot.imageUrl AS 'imageUrl' FROM lot INNER JOIN category ON lot.categoryId = category.categoryId WHERE lot.endDate > @endDate AND lot.lotId NOT IN (SELECT lotId FROM bid)">
            <SelectParameters>
                <asp:SessionParameter Name="endDate" SessionField="now" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceCategory" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionStringYouSell %>' SelectCommand="SELECT * FROM [category]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceTest" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionStringYouSell %>' SelectCommand="SELECT lot.lotId, lot.lotName AS 'Name', category.categoryName AS 'Category', lot.startDate AS 'Start Date', lot.endDate AS 'End Date', (SELECT TOP 1 amount FROM bid WHERE bid.lotId = lot.lotId ORDER BY amount DESC) AS 'Current Bid', lot.imageUrl AS 'imageUrl' FROM lot INNER JOIN category ON lot.categoryId = category.categoryId WHERE lot.endDate > @endDate AND lot.lotId IN (SELECT lot.lotId FROM lot INNER JOIN bid ON lot.lotId = bid.lotId) UNION SELECT lot.lotId, lot.lotName AS 'Name', category.categoryName AS 'Category', lot.startDate AS 'Start Date', lot.endDate AS 'End Date', lot.startingBid AS 'Current Bid', lot.imageUrl AS 'imageUrl' FROM lot INNER JOIN category ON lot.categoryId = category.categoryId WHERE lot.endDate > @endDate AND lot.lotId NOT IN (SELECT lot.lotId FROM lot INNER JOIN bid ON lot.lotId = bid.lotId)">
            <SelectParameters>
                <asp:SessionParameter SessionField="now" Name="endDate"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

