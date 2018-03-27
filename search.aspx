<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="search.aspx.cs" Inherits="search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Search</h1>
    <div class="flexCenter">
        <div id="searchCriteria">

        </div>
        <div id="searchResults">
            <asp:GridView ID="GridViewSearchResults" runat="server" AutoGenerateColumns="False" DataKeyNames="lotId" DataSourceID="SqlDataSourceSearch" OnSelectedIndexChanged="GridViewSearchResults_SelectedIndexChanged">
                <Columns>
                    <asp:CommandField ButtonType="Button" ShowSelectButton="True" />
                    <asp:BoundField DataField="lotId" HeaderText="lotId" InsertVisible="False" ReadOnly="True" SortExpression="lotId" />
                    <asp:BoundField DataField="sellerId" HeaderText="sellerId" SortExpression="sellerId" />
                    <asp:BoundField DataField="categoryId" HeaderText="categoryId" SortExpression="categoryId" />
                    <asp:BoundField DataField="lotName" HeaderText="lotName" SortExpression="lotName" />
                    <asp:BoundField DataField="description" HeaderText="description" SortExpression="description" />
                    <asp:BoundField DataField="imageUrl" HeaderText="imageUrl" SortExpression="imageUrl" />
                    <asp:BoundField DataField="startingBid" HeaderText="startingBid" SortExpression="startingBid" />
                    <asp:BoundField DataField="startDate" HeaderText="startDate" SortExpression="startDate" />
                    <asp:BoundField DataField="endDate" HeaderText="endDate" SortExpression="endDate" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
    <div>
        <asp:SqlDataSource ID="SqlDataSourceSearch" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringYouSell %>" SelectCommand="SELECT * FROM [lot] WHERE ([endDate] &gt; @endDate)">
            <SelectParameters>
                <asp:SessionParameter Name="endDate" SessionField="now" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

