﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OperatorOverloading.dbl
{
    public class Conversion : IParser
    {
        static string[] initialseperatedData;
        static string[] currencySeperatedData;

        public double GetConversion(string sourceCurrency, string targetCurrency)
        {
           
            string line;
            string completeData = "";

            System.IO.StreamReader file =
               new System.IO.StreamReader("D:\\Training\\01 OperatorOverloading\\OperatorOverloading.dbl\\Data.txt");
            while ((line = file.ReadLine()) != null)
            {
                completeData += line;
                
            }
            completeData = completeData.Replace('}','\0').Replace('\"','\0').Replace("USD","");
          
            file.Close();

            initialseperatedData = completeData.Split('{');
            initialseperatedData[0] = "";
            initialseperatedData[1] = "";


            currencySeperatedData = initialseperatedData[2].Split(',');

            double multiplier1 = getMultiplier(sourceCurrency);
            double multiplier2 = getMultiplier(targetCurrency);

            return (multiplier2 / multiplier1);

        }

        public static double getMultiplier(string currency)
        {

            if (currency.Equals("USD"))
                return 1;
            int j;
            for (j = 0; j < currencySeperatedData.Length; j++)
            {
                if (currencySeperatedData[j].Contains(currency) == true)
                    break;
            }
          
            string[] finalSplit = currencySeperatedData[j].Split(':');
            double multiplier = 0.0;
            if (double.TryParse(currencySeperatedData[1], out multiplier) == false)
                throw new Exception(Messages.InvalidParsing);

            return multiplier;
        }
       
    }

}
