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

               Console.WriteLine("Enter Source Currency in \"100 USD\" Format");
               string temporaryString = Console.ReadLine();

               string[] splitInput = temporaryString.Split(' ');
                double temporaryAmount;
                 if((double.TryParse(splitInput[0],out temporaryAmount)==false))
                     throw new Exception(Messages.InvalidParsing);

                 Money money1=new Money( temporaryAmount,splitInput[1]);
                

            Console.WriteLine("Enter Target Currency");
            if (IsValidCurrency(Console.ReadLine().ToUpper(), out targetCurrency) == false)
                throw new Exception(Messages.InvalidCurrency);
            Money money2 = new Money(targetCurrency);

            double multiplier = money.ConvertCurrency(money1.Currency, money2.Currency);
            Console.WriteLine(multiplier*money1.Amount);
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
        }
    }
}