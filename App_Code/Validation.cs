using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Input validation methods.
/// </summary>
public class Validation
{

    public static bool isLoggedIn(object login)
    {
        if (login == null)
        {
            return false;
        }
        else
        {
            if (login.Equals(true))
            {
                return true;
            }
            return false;
        }
    }

    public static bool isAlphaNumeric(string input)
    {
        char[] nameArray = (input.ToLower()).ToCharArray();
        foreach (char letter in nameArray)
        {
            int charNum = Convert.ToInt32(letter);
            if (!((charNum <= 90 && charNum >= 65) || (charNum <= 122 && charNum >= 97) || (charNum <= 57 && charNum >= 48)))
            {
                return false;
            }
            
        }
        return true;
    }

    public static bool isValidEmailAddress(string input)
    {
        try
        {
            System.Net.Mail.MailAddress addr = new System.Net.Mail.MailAddress(input);
        }
        catch
        {
            return false;
        }
        return true;
    }

    public static bool isValidDateTime(string input)
    {
        DateTime unused;
        bool result = DateTime.TryParse(input, out unused);
        return result;
    }
}