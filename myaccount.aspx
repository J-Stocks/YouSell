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
    <div>
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
    </div>
</asp:Content>

