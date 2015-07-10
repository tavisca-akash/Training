﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OperatorOverloading.dbl;
using OperatorOverloading.Model;
namespace OperatorOverloading.Host
{
    class Program
    {
        public static void Main(string[] args)
        {
            Money money = new Money();
            string sourceCurrency;
            string targetCurrency;
            try
            {

                Console.WriteLine("Enter Source Currency");

                if (IsValidCurrency(Console.ReadLine().ToUpper(), out sourceCurrency) == false)
                    throw new Exception();

                    Console.WriteLine("Enter Target Currency");
                if(IsValidCurrency(Console.ReadLine().ToUpper(), out targetCurrency)==false)
                    throw new Exception();

                double ans = money.ConvertCurrency(sourceCurrency, targetCurrency);
                Console.WriteLine(ans);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }
        
        public static bool IsValidCurrency(string currency, out string Currency)
        {
            string temporarySourceCurrency = currency;
            while (true)
            {

                if (temporarySourceCurrency.Length != 3)
                {
                     Console.WriteLine("Please Enter Correct Currency");
                     temporarySourceCurrency = Console.ReadLine().ToUpper();
                }
                else
                {
                      Currency = temporarySourceCurrency;
                      return true;
                }
           }
            //Currency = temporarySourceCurrency;
            return false;
        }
    }
}