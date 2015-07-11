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
        
        static string[] parsedData;
        string data = "";
        public double GetExchangeRate(string sourceCurrency, string targetCurrency)
        {
            System.IO.StreamReader file =
              new System.IO.StreamReader(@"D:\Training\01 OperatorOverloading\OperatorOverloading.dbl\Data.txt");

            if (file == null)
                throw new Exception(Messages.FileNotFound);

            data = file.ReadToEnd();
            file.Close();

            parsedData = Parser.GetParsingData(data);

            double sourceExchangeRate = GetUSDExchangeRate(sourceCurrency);
            double targetExchangeRate= GetUSDExchangeRate(targetCurrency);
           
            return ( targetExchangeRate / sourceExchangeRate);

        }

        public static double GetUSDExchangeRate(string currency)
        {
            double exchangeRate;
            
            currency = currency.ToUpper();
           
            if (currency.Equals("USD"))
                return 1;
            int j;
            for (j = 0; j < parsedData.Length; j++)
            {
                if (parsedData[j].Contains(currency) == true)
                    break;
            }
            string[] seperateAmountAndCurrency = parsedData[j].Split(':');
            

            if (double.TryParse((seperateAmountAndCurrency[1]),out exchangeRate) == false)
                throw new Exception(Messages.InvalidParsing);
            return exchangeRate;
        }
    }

}
