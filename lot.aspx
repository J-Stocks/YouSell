<%@ Page Title="Lot Details - You Sell" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="lot.aspx.cs" Inherits="lot" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="lotPageGrid">
        <div class="gridColSpan2">
            <asp:GridView ID="GridViewLotDetails" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceLot" CssClass="basicGridView" Caption="Lot Details">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" />
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                    <asp:BoundField DataField="Starting Bid" HeaderText="Starting Bid" SortExpression="Starting Bid" DataFormatString="{0:c}" />
                    <asp:BoundField DataField="Start Date" HeaderText="Start Date" SortExpression="Start Date" DataFormatString="{0:f}" />
                    <asp:BoundField DataField="End Date" HeaderText="End Date" SortExpression="End Date" DataFormatString="{0:f}" />
                    <asp:BoundField DataField="Seller" HeaderText="Seller" SortExpression="Seller" />
                    <asp:BoundField DataField="imageUrl" HeaderText="imageUrl" SortExpression="imageUrl" Visible="False" />
                    <asp:ImageField DataImageUrlField="imageUrl" HeaderText="Image"></asp:ImageField>
                </Columns>
            </asp:GridView>
        </div>
        <div class="flexStart flexCol">
            <div class="flexStart vertCenter">
                <asp:Label ID="LabelBidBox" runat="server" Text="Make A Bid:" AssociatedControlID="bidBox"></asp:Label>
                <asp:TextBox ID="bidBox" runat="server"></asp:TextBox>
                <asp:Button ID="ButtonBid" runat="server" Text="Confirm" OnClick="ButtonBid_Click" />
            </div>
            <asp:Label ID="LabelBidErrorMessage" runat="server" Text="" AssociatedControlID="bidBox" CssClass="errorMessage"></asp:Label>
        </div>
        <div>
            <asp:PlaceHolder ID="PlaceHolderBidHistory" runat="server">
                <asp:GridView ID="GridViewBidHistory" runat="server" DataSourceID="SqlDataSourceBidHistory" AutoGenerateColumns="False" CssClass="basicGridView" Caption="Bid History">
                    <Columns>
                        <asp:BoundField DataField="Buyer" HeaderText="Buyer" SortExpression="Buyer"></asp:BoundField>
                        <asp:BoundField DataField="Bid" HeaderText="Bid" SortExpression="Bid" DataFormatString="{0:c}"></asp:BoundField>
                        <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" DataFormatString="{0:f}"></asp:BoundField>
                    </Columns>
                </asp:GridView>
            </asp:PlaceHolder>
        </div>
    </div>
    <div>
        <asp:GridView ID="GridViewAddBid" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceBid" Visible="False" DataKeyNames="buyerId,lotId">
            <Columns>
                <asp:BoundField DataField="buyerId" HeaderText="buyerId" SortExpression="buyerId" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="lotId" HeaderText="lotId" SortExpression="lotId" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="amount" HeaderText="amount" SortExpression="amount"></asp:BoundField>
                <asp:BoundField DataField="bidDate" HeaderText="bidDate" SortExpression="bidDate"></asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceLot" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionStringYouSell %>' SelectCommand="SELECT 
	lot.lotName AS 'Name',
	category.categoryName AS 'Category',
	lot.description AS 'Description',
	lot.startingBid AS 'Starting Bid',
	lot.startDate AS 'Start Date',
	lot.endDate AS 'End Date',
	[user].userName AS 'Seller',
	lot.imageUrl AS 'imageUrl'
FROM lot
INNER JOIN category ON lot.categoryId = category.categoryId 
INNER JOIN [user] ON lot.sellerId = [user].userId
WHERE lot.lotId = @lotId;">
            <SelectParameters>
                <asp:SessionParameter Name="lotId" SessionField="lotId" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceBid" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionStringYouSell %>' SelectCommand="SELECT * FROM [bid] WHERE (([lotId] = @lotId) AND ([buyerId] = @buyerId))" InsertCommand="INSERT INTO bid(buyerId, lotId, amount, bidDate) VALUES (@buyerId, @lotId, @amount, @bidDate)" UpdateCommand="UPDATE bid SET amount = @amount, bidDate = @bidDate WHERE (buyerId = @userId) AND (lotId = @lotId)">
            <InsertParameters>
                <asp:SessionParameter Name="buyerId" SessionField="userId" />
                <asp:SessionParameter Name="lotId" SessionField="lotId" />
                <asp:SessionParameter Name="amount" SessionField="buyerBid" />
                <%--<asp:ControlParameter ControlID="bidBox" Name="amount" PropertyName="Text" />--%>
                <asp:SessionParameter Name="bidDate" SessionField="now" />
            </InsertParameters>
            <SelectParameters>
                <asp:SessionParameter SessionField="lotId" Name="lotId" Type="Int32"></asp:SessionParameter>
                <asp:SessionParameter Name="buyerId" SessionField="userId" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <%--<asp:ControlParameter ControlID="bidBox" Name="amount" PropertyName="Text" />--%>
                <asp:SessionParameter Name="amount" SessionField="buyerBid" />
                <asp:SessionParameter Name="bidDate" SessionField="now" />
                <asp:SessionParameter Name="userId" SessionField="userId" />
                <asp:SessionParameter Name="lotId" SessionField="lotId" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceBidHistory" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionStringYouSell %>' SelectCommand="SELECT [user].userName AS 'Buyer', bid.amount AS 'Bid', bid.bidDate AS 'Date' FROM [bid] INNER JOIN [user] ON bid.buyerId = [user].userId WHERE ([lotId] = @lotId) ORDER BY amount DESC;">
            <SelectParameters>
                <asp:SessionParameter SessionField="lotId" Name="lotId" Type="Int32"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

