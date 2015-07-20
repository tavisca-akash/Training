﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OperatorOverloading.dbl
{
    public class Conversion : IParser
    {
        static string[] initialseperatedString;
        static string[] currencySeperatedString;

        public double Converts(string sourceCurrency, string targetCurrency)
        {
            currencySeperatedString = FileParsing.ParsingData();

            double multiplier1 = getMultiplier(sourceCurrency);
            double multiplier2 = getMultiplier(targetCurrency);

            return (multiplier2 / multiplier1);

        }

        public static double getMultiplier(string currency)
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
