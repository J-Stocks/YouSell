using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Functions to assist the search feature on search.aspx
/// </summary>
public class Search
{

    public static string acceptableCharacters = "abcdefghijklmnopqrstuvwxyz ";

    public static bool isAcceptableChar(char input)
    {
        int inputValue = Convert.ToInt32(input);
        if (inputValue == 32 || (inputValue >= 97 && inputValue <= 122))
        {
            return true;
        }
        return false;
    }

    public static string cleanSearchString(string input)
    {
        char[] tempArray = input.ToLower().ToCharArray();
        tempArray = tempArray.Where(character => Search.isAcceptableChar(character)).ToArray();
        return new string(tempArray);
    }

    public static bool isAcceptableTerm(string input)
    {
        if (input == "" || input == " ")
        {
            return false;
        }
        return true;
    }

    public static string[] getSearchTerms(string input)
    {
        string tempInput = cleanSearchString(input);
        string[] tempInputArray = tempInput.Split(' ');
        tempInputArray = tempInputArray.Where(term => Search.isAcceptableTerm(term)).ToArray();
        return tempInputArray;
    }
}