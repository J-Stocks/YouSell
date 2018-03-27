using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Input validation methods.
/// </summary>
public class Validation
{
    public Validation()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static bool isValidUserName(string userName)
    {
        if (userName.Length > 40)
        {
            return false;
        }
        //char[] nameArray = (userName.ToLower()).ToCharArray();
        //foreach (char letter in nameArray)
        //{
        //    int charNum = Convert.ToInt32(letter);
        //    if (!((charNum <= 90 && charNum >= 65) || ))
        //    {

        //    }
        //}
        return true;
    }

    public static bool isLoggedIn(Object login)
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

    //public static void errorMessage(string message)
    //{
    //    System.Diagnostics.Debug.WriteLine(message);
    //}
}