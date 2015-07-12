﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OperatorOverloading.interfaces;
namespace OperatorOverloading.dbl
{
    public class CurrencyConversion : IExchangeRateProvider
    {
        static string[] currencySeperatedString;
        public double GetExchangeRate(string sourceCurrency, string targetCurrency)
        {
            string completeData = "";
            System.IO.StreamReader file =
               new System.IO.StreamReader(@"C:\Users\abhandwalkar\Desktop\01 OperatorOverloading\OperatorOverloading.dbl\Data.txt");

            if (file == null)
                throw new Exception(Message.InvalidCurrency);
            completeData = file.ReadToEnd();
            currencySeperatedString = Parser.GetParsingData(completeData);
            double sourceExchangeRate = GetUSDExchangeRate(sourceCurrency);
            double targetExchangeRate = GetUSDExchangeRate(targetCurrency);
            return (targetExchangeRate / sourceExchangeRate);
        }
        public static double GetUSDExchangeRate(string currency)
        {
            currency = currency.ToUpper();

            if (currency.Equals("USD"))
                return 1;
            int j;
            for (j = 0; j < currencySeperatedString.Length; j++)
            {
                if (currencySeperatedString[j].Contains(currency) == true)
                    break;
            }
            string[] finalSplit = currencySeperatedString[j].Split(':');
            double multiplier = Convert.ToDouble(finalSplit[1]);
            return multiplier;
        }
    }

}
