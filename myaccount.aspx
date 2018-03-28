<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="myaccount.aspx.cs" Inherits="myaccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>My Account</h1>
    <asp:Placeholder ID="addLot" runat="server" Visible="False">
        <h2 class="flexCenter">Add a Lot</h2>
        <div class="flexCenter">
            <div id="addLotGrid">
                <asp:Label ID="LabelLotName" runat="server" Text="Name" AssociatedControlID="lotName"></asp:Label>
                <asp:TextBox ID="lotName" runat="server"></asp:TextBox>
                <asp:Label ID="LabelLotDescription" runat="server" Text="Description" AssociatedControlID="lotDescription"></asp:Label>
                <asp:TextBox ID="lotDescription" runat="server"></asp:TextBox>
                <asp:Label ID="LabelStartBid" runat="server" Text="Starting Bid" AssociatedControlID="startBid"></asp:Label>
                <asp:TextBox ID="startBid" runat="server"></asp:TextBox>
                <asp:Label ID="LabelEndDate" runat="server" Text="End Date" AssociatedControlID="endDate"></asp:Label>
                <asp:TextBox ID="endDate" runat="server"></asp:TextBox>
                <asp:Label ID="LabelUploadImage" runat="server" Text="Add an Image" AssociatedControlID="FileUploadImage"></asp:Label>
                <asp:FileUpload ID="FileUploadImage" runat="server" />
                <asp:Label ID="LabelCategory" runat="server" Text="Category" AssociatedControlID="DropDownListCategory"></asp:Label>
                <asp:DropDownList ID="DropDownListCategory" runat="server" DataSourceID="SqlDataSourceCategory" DataTextField="categoryName" DataValueField="categoryId"></asp:DropDownList>
                <div class="flexCenter gridColSpan2">
                    <asp:Button ID="ButtonAddLot" runat="server" Text="Add a Lot" OnClick="ButtonAddLot_Click" />
                </div>
            </div>
        </div>
    </asp:Placeholder>
    <asp:PlaceHolder ID="PlaceHolderMyLots" runat="server">
        <div>
            <h2>My Lots</h2>
            <asp:GridView ID="GridViewMyLots" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceMyLots" DataKeyNames="lotId" OnRowCommand="GridViewMyLots_RowCommand1">
                <Columns>
                    <asp:ButtonField ButtonType="Button" CommandName="viewDetails" Text="View Lot Details" />
                    <asp:ButtonField CommandName="deleteLot" Text="Delete Lot" ButtonType="Button"></asp:ButtonField>
                    <asp:BoundField DataField="lotId" HeaderText="lotId" InsertVisible="False" ReadOnly="True" SortExpression="lotId" Visible="False" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
                    <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category"></asp:BoundField>
                    <asp:BoundField DataField="Start Date" HeaderText="Start Date" SortExpression="Start Date" DataFormatString="{0:f}"></asp:BoundField>
                    <asp:BoundField DataField="End Date" HeaderText="End Date" SortExpression="End Date" DataFormatString="{0:f}"></asp:BoundField>
                    <asp:BoundField DataField="imageUrl" HeaderText="imageUrl" SortExpression="imageUrl" Visible="False"></asp:BoundField>
                    <asp:ImageField DataImageUrlField="imageUrl" HeaderText="Image">
                    </asp:ImageField>
                </Columns>
            </asp:GridView>
        </div>
    </asp:PlaceHolder>
    <asp:PlaceHolder ID="PlaceHolderMyBids" runat="server">
        <div>
            <h2>My Bids</h2>
            <asp:GridView ID="GridViewMyBids" runat="server" DataSourceID="SqlDataSourceMyBids" AutoGenerateColumns="False" OnRowCommand="GridViewMyBids_RowCommand1">
                <Columns>
                    <asp:ButtonField ButtonType="Button" CommandName="viewDetails" Text="View Lot Details" />
                    <asp:ButtonField CommandName="deleteBid" Text="Delete Bid" ButtonType="Button"></asp:ButtonField>
                    <asp:BoundField DataField="lotId" HeaderText="lotId" SortExpression="lotId" Visible="False"></asp:BoundField>
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
                    <asp:BoundField DataField="Your Bid" HeaderText="Your Bid" SortExpression="Your Bid" DataFormatString="{0:c}"></asp:BoundField>
                    <asp:BoundField DataField="Bid Date" HeaderText="Bid Date" SortExpression="Bid Date" DataFormatString="{0:f}"></asp:BoundField>
                    <asp:BoundField DataField="EndDate" DataFormatString="{0:f}" HeaderText="EndDate" SortExpression="EndDate" />
                </Columns>
            </asp:GridView>
        </div>
    </asp:PlaceHolder>
    <div id="hiddenStuff">
        <asp:GridView ID="GridViewMyLotsHidden" runat="server" DataSourceID="SqlDataSourceMyLots" Visible="False" AutoGenerateColumns="False" DataKeyNames="lotId">
            <Columns>
                <asp:BoundField DataField="lotId" HeaderText="lotId" InsertVisible="False" ReadOnly="True" SortExpression="lotId" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" />
                <asp:BoundField DataField="Start Date" HeaderText="Start Date" SortExpression="Start Date" />
                <asp:BoundField DataField="End Date" HeaderText="End Date" SortExpression="End Date" />
                <asp:BoundField DataField="imageUrl" HeaderText="imageUrl" SortExpression="imageUrl" />
            </Columns>
        </asp:GridView>
        <asp:GridView ID="GridViewMyBidsHidden" runat="server" DataSourceID="SqlDataSourceMyBids" Visible="False" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="lotId" HeaderText="lotId" SortExpression="lotId"></asp:BoundField>
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
                <asp:BoundField DataField="Your Bid" HeaderText="Your Bid" SortExpression="Your Bid"></asp:BoundField>
                <asp:BoundField DataField="Bid Date" HeaderText="Bid Date" SortExpression="Bid Date"></asp:BoundField>
                <asp:BoundField DataField="EndDate" HeaderText="EndDate" SortExpression="EndDate"></asp:BoundField>
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
                <%--<asp:ControlParameter ControlID="startBid" Name="startingBid" PropertyName="Text" />--%>
                <asp:SessionParameter Name="startDate" SessionField="startDate" />
                <asp:SessionParameter Name="endDate" SessionField="endDate" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceMyLots" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionStringYouSell %>' DeleteCommand="DELETE FROM [lot] WHERE [lotId] = @lotId" InsertCommand="INSERT INTO [lot] ([sellerId], [categoryId], [lotName], [description], [imageUrl], [startingBid], [startDate], [endDate]) VALUES (@sellerId, @categoryId, @lotName, @description, @imageUrl, @startingBid, @startDate, @endDate)" SelectCommand="SELECT 
                lot.lotId,
	lot.lotName AS 'Name',
	category.categoryName AS 'Category',
	lot.startDate AS 'Start Date',
	lot.endDate AS 'End Date',
	lot.imageUrl AS 'imageUrl'
FROM lot
INNER JOIN category ON lot.categoryId = category.categoryId 
WHERE ([sellerId] = @sellerId);" UpdateCommand="UPDATE [lot] SET [sellerId] = @sellerId, [categoryId] = @categoryId, [lotName] = @lotName, [description] = @description, [imageUrl] = @imageUrl, [startingBid] = @startingBid, [startDate] = @startDate, [endDate] = @endDate WHERE [lotId] = @lotId">
            <DeleteParameters>
                <%--<asp:Parameter Name="lotId" Type="Int32"></asp:Parameter>--%>
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
        <asp:SqlDataSource ID="SqlDataSourceMyBids" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionStringYouSell %>' SelectCommand="SELECT 
    bid.lotId, 
    lot.lotName AS 'Name', 
    bid.amount AS 'Your Bid', 
    bid.bidDate AS 'Bid Date', 
    lot.endDate AS 'EndDate' 
FROM [bid]
INNER JOIN lot ON bid.lotId = lot.lotID 
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

