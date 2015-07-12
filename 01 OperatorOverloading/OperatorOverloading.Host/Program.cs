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
            string input = Console.ReadLine();
       
            string[] splitInput = input.Split(' ');
            sourceCurrency = GetValidCurrency(splitInput[0]);
            double temporaryAmount;

            if ((double.TryParse(splitInput[0], out temporaryAmount) == false))
                throw new Exception();

            Money money1 = new Money(temporaryAmount, splitInput[1]);


            Console.WriteLine("Enter Target Currency");
            targetCurrency = GetValidCurrency(Console.ReadLine());

            Money money2 = new Money(targetCurrency);

            double exchangedAmount = money.ConvertCurrency(money1.Amount,money1.Currency, money2.Currency);
            Console.WriteLine(exchangedAmount);
        }
        public static string GetValidCurrency(string currency)
        {
            string temporarySourceCurrency = currency;
            string Currency;
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
                    return Currency;
                }
            }
        }
    }
}