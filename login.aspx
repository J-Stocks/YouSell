<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1 class="flexCenter">Login</h1>
    <div class="flexCenter">
        <div id="loginGrid">
            <asp:Label ID="LabelUserName" runat="server" Text="User Name:" AssociatedControlID="userName"></asp:Label>
            <asp:textbox ID="userName" runat="server"></asp:textbox>
            <asp:Label ID="LabelPassword" runat="server" Text="Password:" AssociatedControlID="password"></asp:Label>
            <asp:TextBox ID="password" runat="server"></asp:TextBox>
            <div class="flexCenter gridColSpan2">
                <asp:Button ID="ButtonLogin" runat="server" Text="Login" OnClick="ButtonLogin_Click"/>
            </div>
            <div class="flexCenter gridColSpan2">
                <asp:Label ID="LabelLoginErrorMessage" runat="server" Text=""></asp:Label>
            </div>
        </div>
    </div>
    <div>
        <asp:GridView ID="GridViewLogin" runat="server" AutoGenerateColumns="False" DataKeyNames="userId" DataSourceID="SqlDataSourceLogin" Visible="False">
            <Columns>
                <asp:BoundField DataField="userId" HeaderText="userId" InsertVisible="False" ReadOnly="True" SortExpression="userId" />
                <asp:BoundField DataField="role" HeaderText="role" SortExpression="role" />
                <asp:BoundField DataField="userName" HeaderText="userName" SortExpression="userName" />
                <asp:BoundField DataField="password" HeaderText="password" SortExpression="password" />
                <asp:BoundField DataField="email" HeaderText="email" SortExpression="email" />
                <asp:BoundField DataField="phone" HeaderText="phone" SortExpression="phone" />
                <asp:BoundField DataField="addressLine1" HeaderText="addressLine1" SortExpression="addressLine1" />
                <asp:BoundField DataField="addressLine2" HeaderText="addressLine2" SortExpression="addressLine2" />
                <asp:BoundField DataField="countyId" HeaderText="countyId" SortExpression="countyId" />
                <asp:BoundField DataField="postCode" HeaderText="postCode" SortExpression="postCode" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceLogin" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringYouSell %>" SelectCommand="SELECT * FROM [user] WHERE (([userName] = @userName) AND ([password] = @password))">
            <SelectParameters>
                <asp:ControlParameter ControlID="userName" Name="userName" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="password" Name="password" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

