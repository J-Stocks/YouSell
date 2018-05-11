<%@ Page Title="Register - You Sell" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2 class="flexCenter">Register</h2>
    <div class="flexCenter">
        <div id="registerGrid">
            <asp:RadioButtonList ID="buyerOrSeller" runat="server" RepeatLayout="Flow" CssClass="flexBetween gridColSpan2">
                <asp:ListItem Selected="True" Value="b">Register as a Buyer</asp:ListItem>
                <asp:ListItem Value="s">Register as a Seller</asp:ListItem>
            </asp:RadioButtonList>
            <asp:Label ID="LabelUserName" runat="server" Text="User Name:" AssociatedControlID="userName"></asp:Label>
            <asp:textbox ID="userName" runat="server" MaxLength="40"></asp:textbox>
            <asp:Label ID="LabeluserNameErrorMessage" runat="server" Text="" AssociatedControlID="userName" CssClass="gridColSpan2 errorMessage"></asp:Label>
            <asp:Label ID="LabelPassword" runat="server" Text="Password:" AssociatedControlID="password"></asp:Label>
            <asp:TextBox ID="password" runat="server" MaxLength="30" TextMode="Password"></asp:TextBox>
            <asp:Label ID="LabelpasswordConfirm" runat="server" Text="Confirm Password:" AssociatedControlID="passwordConfirm"></asp:Label>
            <asp:TextBox ID="passwordConfirm" runat="server" MaxLength="30" TextMode="Password"></asp:TextBox>
            <asp:Label ID="LabelPasswordErrorMessage" runat="server" Text="" AssociatedControlID="password" CssClass="gridColSpan2 errorMessage"></asp:Label>
            <asp:Label ID="LabelEmail" runat="server" Text="Email Address:" AssociatedControlID="email"></asp:Label>
            <asp:TextBox ID="email" runat="server" MaxLength="40"></asp:TextBox>
            <asp:Label ID="LabelEmailErrorMessage" runat="server" Text="" AssociatedControlID="email" CssClass="gridColSpan2 errorMessage"></asp:Label>
            <asp:Label ID="LabelPhone" runat="server" Text="Phone Number:" AssociatedControlID="phone"></asp:Label>
            <asp:TextBox ID="phone" runat="server" MaxLength="11"></asp:TextBox>
            <asp:Label ID="LabelPhoneErrorMessage" runat="server" Text="" AssociatedControlID="phone" CssClass="gridColSpan2 errorMessage"></asp:Label>
            <asp:Label ID="LabelAddressLine1" runat="server" Text="House Number or Name:" AssociatedControlID="addressLine1"></asp:Label>
            <asp:TextBox ID="addressLine1" runat="server" MaxLength="50"></asp:TextBox>
            <asp:Label ID="LabelAddressLine2" runat="server" Text="Street:" AssociatedControlID="addressLine2"></asp:Label>
            <asp:TextBox ID="addressLine2" runat="server" MaxLength="50"></asp:TextBox>
            <asp:Label ID="LabelCounty" runat="server" Text="Select a County:" AssociatedControlID="county"></asp:Label>
            <asp:DropDownList ID="county" runat="server" DataSourceID="SqlDataSourceCounty" DataTextField="countyName" DataValueField="countyId"></asp:DropDownList>
            <asp:Label ID="LabelPostcode" runat="server" Text="Postcode:" AssociatedControlID="postcode"></asp:Label>
            <asp:TextBox ID="postcode" runat="server" MaxLength="7"></asp:TextBox>
            <div class="flexCenter gridColSpan2">
                <asp:Button ID="ButtonRegister" runat="server" Text="Register" OnClick="ButtonRegister_Click"/>
            </div>
        </div>
    </div>
    <div>
        <asp:GridView ID="GridViewVerification" runat="server" DataSourceID="SqlDataSourceRegister" Visible="False"></asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceRegister" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringYouSell %>" SelectCommand="SELECT * FROM [user] WHERE ([userName] = @userName)" InsertCommand="INSERT INTO [user] (role, userName, password, email, phone, addressLine1, addressLine2, countyId, postCode) VALUES (@role, @userName, @password, @email, @phone, @addressLine1, @addressLine2, @countyId, @postcode)">
            <InsertParameters>
                <asp:ControlParameter ControlID="buyerOrSeller" Name="role" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="userName" Name="userName" PropertyName="Text" />
                <asp:ControlParameter ControlID="password" Name="password" PropertyName="Text" />
                <asp:ControlParameter ControlID="email" Name="email" PropertyName="Text" />
                <asp:ControlParameter ControlID="phone" Name="phone" PropertyName="Text" />
                <asp:ControlParameter ControlID="addressLine1" Name="addressLine1" PropertyName="Text" />
                <asp:ControlParameter ControlID="addressLine2" Name="addressLine2" PropertyName="Text" />
                <asp:ControlParameter ControlID="county" Name="countyId" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="postcode" Name="postcode" PropertyName="Text" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="userName" Name="userName" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceCounty" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringYouSell %>" SelectCommand="SELECT * FROM [county]"></asp:SqlDataSource>
    </div>
</asp:Content>

