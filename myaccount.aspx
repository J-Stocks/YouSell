<%@ Page Title="My Account - You Sell" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="myaccount.aspx.cs" Inherits="myaccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>My Account</h2>
    <asp:PlaceHolder ID="PlaceHolderMyLots" runat="server">
        <div>
            <asp:GridView ID="GridViewMyLots" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceMyLots" OnRowCommand="GridViewMyLots_RowCommand1" CssClass="basicGridView noBorders2" Caption="My Lots">
                <Columns>
                    <asp:ButtonField ButtonType="Button" CommandName="viewDetails" Text="View Lot Details" />
	                <asp:ButtonField CommandName="deleteLot" Text="Delete Lot" ButtonType="Button"></asp:ButtonField>
                    <asp:BoundField DataField="lotId" HeaderText="lotId" ReadOnly="True" SortExpression="lotId" Visible="False"></asp:BoundField>
                    <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" SortExpression="Name" />
                    <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" ReadOnly="True"></asp:BoundField>
                    <asp:BoundField DataField="Start Date" HeaderText="Start Date" SortExpression="Start Date" ReadOnly="True" DataFormatString="{0:f}"></asp:BoundField>
                    <asp:BoundField DataField="End Date" HeaderText="End Date" SortExpression="End Date" ReadOnly="True" DataFormatString="{0:f}"></asp:BoundField>
                    <asp:BoundField DataField="Current Bid" HeaderText="Current Bid" SortExpression="Current Bid" ReadOnly="True" DataFormatString="{0:c}"></asp:BoundField>
                    <asp:BoundField DataField="imageUrl" HeaderText="imageUrl" SortExpression="imageUrl" ReadOnly="True" Visible="False"></asp:BoundField>
                    <asp:ImageField DataImageUrlField="imageUrl" HeaderText="Image"></asp:ImageField>
                </Columns>
            </asp:GridView>
        </div>
    </asp:PlaceHolder>
    <asp:PlaceHolder ID="PlaceHolderMyBids" runat="server">
        <div class="flexCenter">
            <asp:GridView ID="GridViewMyBids" runat="server" DataSourceID="SqlDataSourceMyBids" AutoGenerateColumns="False" OnRowCommand="GridViewMyBids_RowCommand1" CssClass="basicGridView noBorders2" Caption="My Bids">
                <Columns>
                    <asp:ButtonField ButtonType="Button" CommandName="viewDetails" Text="View Lot Details" />
                    <asp:ButtonField CommandName="deleteBid" Text="Delete Bid" ButtonType="Button"></asp:ButtonField>
                    <asp:BoundField DataField="lotId" HeaderText="lotId" SortExpression="lotId" Visible="False"></asp:BoundField>
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
                    <asp:BoundField DataField="Your Bid" HeaderText="Your Bid" SortExpression="Your Bid" DataFormatString="{0:c}"></asp:BoundField>
                    <asp:BoundField DataField="Bid Date" HeaderText="Bid Date" SortExpression="Bid Date" DataFormatString="{0:f}"></asp:BoundField>
                    <asp:BoundField DataField="EndDate" HeaderText="EndDate" SortExpression="EndDate" DataFormatString="{0:f}"></asp:BoundField>
                    <asp:BoundField DataField="Current Bid" HeaderText="Current Bid" SortExpression="Current Bid" ReadOnly="True" DataFormatString="{0:c}"></asp:BoundField>
                    <asp:BoundField DataField="Winning Bidder" HeaderText="Winning Bidder" SortExpression="Winning Bidder" ReadOnly="True" />
                </Columns>
            </asp:GridView>
        </div>
    </asp:PlaceHolder>
    <asp:Placeholder ID="addLot" runat="server" Visible="False">
        <div class="flexCenter">
            <div id="addLotGrid">
                <h3 class="flexCenter gridColSpan4">Add a Lot</h3>
                <asp:Label ID="LabelLotName" runat="server" Text="Name" AssociatedControlID="lotName"></asp:Label>
                <asp:TextBox ID="lotName" runat="server" MaxLength="50"></asp:TextBox>
                <asp:Label ID="LabelLotDescription" runat="server" Text="Description" AssociatedControlID="lotDescription"></asp:Label>
                <asp:TextBox ID="lotDescription" runat="server"></asp:TextBox>
                <asp:Label ID="LabelStartBid" runat="server" Text="Starting Bid" AssociatedControlID="startBid"></asp:Label>
                <asp:TextBox ID="startBid" runat="server"></asp:TextBox>
                <asp:Label ID="LabelEndDate" runat="server" Text="End Date" AssociatedControlID="endDate"></asp:Label>
                <asp:TextBox ID="endDate" runat="server"></asp:TextBox>
                <asp:Label ID="LabelStartBidErrorMessage" runat="server" Text="" AssociatedControlID="startBid" CssClass="gridColSpan2 errorMessage"></asp:Label>
                <asp:Label ID="LabelEndDateErrorMessage" runat="server" Text="" AssociatedControlID="endDate" CssClass="gridColSpan2to4 errorMessage"></asp:Label>
                <asp:Label ID="LabelUploadImage" runat="server" Text="Add an Image" AssociatedControlID="FileUploadImage"></asp:Label>
                <asp:FileUpload ID="FileUploadImage" runat="server" />
                <asp:Label ID="LabelCategory" runat="server" Text="Category" AssociatedControlID="DropDownListCategory"></asp:Label>
                <asp:DropDownList ID="DropDownListCategory" runat="server" DataSourceID="SqlDataSourceCategory" DataTextField="categoryName" DataValueField="categoryId"></asp:DropDownList>
                <asp:Label ID="LabelUploadImageErrorMessage" runat="server" Text="" AssociatedControlID="FileUploadImage" CssClass="gridColSpan4 errorMessage"></asp:Label>
                <div class="flexCenter gridColSpan4">
                    <asp:Button ID="ButtonAddLot" runat="server" Text="Add a Lot" OnClick="ButtonAddLot_Click" />
                </div>
            </div>
        </div>
    </asp:Placeholder>
    <div id="hiddenStuff">
        <asp:GridView ID="GridViewMyLotsHidden" runat="server" DataSourceID="SqlDataSourceMyLots" Visible="False" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="lotId" HeaderText="lotId" ReadOnly="True" SortExpression="lotId" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" ReadOnly="True" />
                <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" ReadOnly="True" />
                <asp:BoundField DataField="Start Date" HeaderText="Start Date" SortExpression="Start Date" ReadOnly="True" />
                <asp:BoundField DataField="End Date" HeaderText="End Date" SortExpression="End Date" ReadOnly="True" />
                <asp:BoundField DataField="Current Bid" HeaderText="Current Bid" SortExpression="Current Bid" ReadOnly="True" />
                <asp:BoundField DataField="imageUrl" HeaderText="imageUrl" ReadOnly="True" SortExpression="imageUrl"></asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:GridView ID="GridViewMyBidsHidden" runat="server" DataSourceID="SqlDataSourceMyBids" Visible="False" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="lotId" HeaderText="lotId" SortExpression="lotId"></asp:BoundField>
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
                <asp:BoundField DataField="Your Bid" HeaderText="Your Bid" SortExpression="Your Bid"></asp:BoundField>
                <asp:BoundField DataField="Bid Date" HeaderText="Bid Date" SortExpression="Bid Date"></asp:BoundField>
                <asp:BoundField DataField="EndDate" HeaderText="EndDate" SortExpression="EndDate"></asp:BoundField>
                <asp:BoundField DataField="Current Bid" HeaderText="Current Bid" ReadOnly="True" SortExpression="Current Bid"></asp:BoundField>
                <asp:BoundField DataField="Winning Bidder" HeaderText="Winning Bidder" ReadOnly="True" SortExpression="Winning Bidder"></asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceCategory" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringYouSell %>" SelectCommand="SELECT * FROM [category]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceAddLot" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringYouSell %>" SelectCommand="SELECT * FROM [lot]" InsertCommand="INSERT INTO lot(sellerId, categoryId, lotName, description, imageUrl, startingBid, startDate, endDate) VALUES (@sellerId, @categoryId, @lotName, @description, @imageUrl, @startingBid, @startDate, @endDate)">
            <InsertParameters>
                <asp:SessionParameter Name="sellerId" SessionField="userId" />
                <asp:ControlParameter ControlID="DropDownListCategory" Name="categoryId" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="lotName" Name="lotName" PropertyName="Text" />
                <asp:ControlParameter ControlID="lotDescription" Name="description" PropertyName="Text" />
                <asp:SessionParameter Name="imageUrl" SessionField="imageUrl" />
                <asp:SessionParameter Name="startingBid" SessionField="startingBid" />
                <asp:SessionParameter Name="startDate" SessionField="startDate" />
                <asp:SessionParameter Name="endDate" SessionField="endDate" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceMyLots" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionStringYouSell %>' DeleteCommand="DELETE FROM [lot] WHERE [lotId] = @lotId" InsertCommand="INSERT INTO [lot] ([sellerId], [categoryId], [lotName], [description], [imageUrl], [startingBid], [startDate], [endDate]) VALUES (@sellerId, @categoryId, @lotName, @description, @imageUrl, @startingBid, @startDate, @endDate)" SelectCommand="SELECT lot.lotId, lot.lotName AS 'Name', category.categoryName AS 'Category', lot.startDate AS 'Start Date', lot.endDate AS 'End Date', (SELECT TOP 1 amount FROM bid WHERE bid.lotId = lot.lotId ORDER BY amount DESC) AS 'Current Bid', lot.imageUrl AS 'imageUrl' FROM lot INNER JOIN category ON lot.categoryId = category.categoryId WHERE ([sellerId] = @sellerId) AND lot.lotId IN (SELECT lotId FROM bid) UNION SELECT lot.lotId, lot.lotName AS 'Name', category.categoryName AS 'Category', lot.startDate AS 'Start Date', lot.endDate AS 'End Date', lot.startingBid AS 'Current Bid', lot.imageUrl AS 'imageUrl' FROM lot
INNER JOIN category ON lot.categoryId = category.categoryId WHERE ([sellerId] = @sellerId) AND lot.lotId NOT IN (SELECT lotId FROM bid);"
            UpdateCommand="UPDATE [lot] SET [sellerId] = @sellerId, [categoryId] = @categoryId, [lotName] = @lotName, [description] = @description, [imageUrl] = @imageUrl, [startingBid] = @startingBid, [startDate] = @startDate, [endDate] = @endDate WHERE [lotId] = @lotId">
            <DeleteParameters>
                <asp:SessionParameter Name="lotId" SessionField="lotId" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="sellerId" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="categoryId" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="lotName" Type="String"></asp:Parameter>
                <asp:Parameter Name="description" Type="String"></asp:Parameter>
                <asp:Parameter Name="imageUrl" Type="String"></asp:Parameter>
                <asp:Parameter Name="startingBid" Type="Decimal"></asp:Parameter>
                <asp:Parameter Name="startDate" Type="DateTime"></asp:Parameter>
                <asp:Parameter Name="endDate" Type="DateTime"></asp:Parameter>
            </InsertParameters>
            <SelectParameters>
                <asp:SessionParameter SessionField="userId" Name="sellerId" Type="Int32"></asp:SessionParameter>
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="sellerId" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="categoryId" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="lotName" Type="String"></asp:Parameter>
                <asp:Parameter Name="description" Type="String"></asp:Parameter>
                <asp:Parameter Name="imageUrl" Type="String"></asp:Parameter>
                <asp:Parameter Name="startingBid" Type="Decimal"></asp:Parameter>
                <asp:Parameter Name="startDate" Type="DateTime"></asp:Parameter>
                <asp:Parameter Name="endDate" Type="DateTime"></asp:Parameter>
                <asp:Parameter Name="lotId" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceCleanUpBids" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionStringYouSell %>' SelectCommand="SELECT * FROM [bid]" DeleteCommand="DELETE FROM bid WHERE lotId = @lotId">
            <DeleteParameters>
                <asp:SessionParameter Name="lotId" SessionField="lotId" />
            </DeleteParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceMyBids" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionStringYouSell %>' SelectCommand="SELECT bid.lotId, lot.lotName AS 'Name', bid.amount AS 'Your Bid', bid.bidDate AS 'Bid Date', lot.endDate AS 'EndDate', (SELECT TOP 1 amount FROM bid WHERE bid.lotId = lot.lotId ORDER BY amount DESC) AS 'Current Bid', (SELECT TOP 1 [user].username FROM bid INNER JOIN [user] ON bid.buyerId = [user].userId WHERE bid.lotId = lot.lotId ORDER BY bid.amount DESC) AS 'Winning Bidder' FROM [bid] INNER JOIN lot ON bid.lotId = lot.lotID 
WHERE bid.buyerId = @buyerId;"
            DeleteCommand="DELETE FROM bid WHERE buyerId = @buyerId and lotId = @lotId">
            <DeleteParameters>
                <asp:SessionParameter SessionField="userId" Name="buyerId" Type="Int32"></asp:SessionParameter>
                <asp:SessionParameter SessionField="lotId" Name="lotId" Type="Int32"></asp:SessionParameter>
            </DeleteParameters>
            <SelectParameters>
                <asp:SessionParameter SessionField="userId" Name="buyerId" Type="Int32"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

