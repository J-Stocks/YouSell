using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ButtonRegister_Click(object sender, EventArgs e)
    {
        GridViewVerification.DataBind();

        int unusedPhoneNumber;
        bool validPhoneNumber = int.TryParse(phone.Text, out unusedPhoneNumber);

        bool validRegistrationDetails = GridViewVerification.Rows.Count == 0 && Validation.isAlphaNumeric(userName.Text) && Validation.isValidEmailAddress(email.Text) && password.Text == passwordConfirm.Text && validPhoneNumber;

        if (validRegistrationDetails)
        {
            SqlDataSourceRegister.Insert();
            Response.Redirect("login.aspx");
        }
        if (!(GridViewVerification.Rows.Count == 0))
        {
            LabeluserNameErrorMessage.Text = "That User Name is already in use.";
        }
        if (!Validation.isAlphaNumeric(userName.Text))
        {
            LabeluserNameErrorMessage.Text = "Usernames must be alphanumeric.";
        }
        if (password.Text != passwordConfirm.Text)
        {
            LabelPasswordErrorMessage.Text = "Those passwords didn't match.";
        }
        if (!Validation.isValidEmailAddress(email.Text))
        {
            LabelEmailErrorMessage.Text = "Please enter a valid email address.";
        }
        if (!validPhoneNumber)
        {
            LabelPhoneErrorMessage.Text = "Please enter a valid phone number.";
        }
    }
}