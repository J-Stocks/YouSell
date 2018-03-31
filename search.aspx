<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="search.aspx.cs" Inherits="search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Search</h1>
    <div class="flexCenter">
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
            <asp:GridView ID="GridViewSearchResults" runat="server" AutoGenerateColumns="False" DataKeyNames="lotId" DataSourceID="SqlDataSourceSearch" OnSelectedIndexChanged="GridViewSearchResults_SelectedIndexChanged">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" ButtonType="Button" SelectText="View Details"></asp:CommandField>
                    <asp:BoundField DataField="lotId" HeaderText="lotId" InsertVisible="False" ReadOnly="True" SortExpression="lotId" Visible="False" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" />
                    <asp:BoundField DataField="Start Date" HeaderText="Start Date" SortExpression="Start Date" DataFormatString="{0:f}" />
                    <asp:BoundField DataField="End Date" HeaderText="End Date" SortExpression="End Date" DataFormatString="{0:f}" />
                    <asp:BoundField DataField="imageUrl" HeaderText="imageUrl" SortExpression="imageUrl" Visible="False" />
                    <asp:ImageField DataImageUrlField="imageUrl" HeaderText="Image"></asp:ImageField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
    <div>
        <asp:GridView ID="GridViewSearchResultsHidden" runat="server" DataSourceID="SqlDataSourceSearch" AutoGenerateColumns="False" DataKeyNames="lotId" Visible="False">
            <Columns>
                <asp:BoundField DataField="lotId" HeaderText="lotId" ReadOnly="True" InsertVisible="False" SortExpression="lotId"></asp:BoundField>
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
                <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category"></asp:BoundField>
                <asp:BoundField DataField="Start Date" HeaderText="Start Date" SortExpression="Start Date"></asp:BoundField>
                <asp:BoundField DataField="End Date" HeaderText="End Date" SortExpression="End Date"></asp:BoundField>
                <asp:BoundField DataField="imageUrl" HeaderText="imageUrl" SortExpression="imageUrl"></asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceSearch" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringYouSell %>" SelectCommand="SELECT lot.lotId, lot.lotName AS 'Name', category.categoryName AS 'Category', lot.startDate AS 'Start Date', lot.endDate AS 'End Date', lot.imageUrl AS 'imageUrl' FROM lot INNER JOIN category ON lot.categoryId = category.categoryId WHERE lot.endDate > @endDate;">
            <SelectParameters>
                <asp:SessionParameter Name="endDate" SessionField="now" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceCategory" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionStringYouSell %>' SelectCommand="SELECT * FROM [category]"></asp:SqlDataSource>
    </div>
</asp:Content>

