<<<<<<< HEAD
﻿﻿using System;
=======
﻿using System;
>>>>>>> 76ad9eeceace4bef0963169efbc89ec7ecfea4c3
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
<<<<<<< HEAD
using OperatorOverloading.dbl;
=======
>>>>>>> 76ad9eeceace4bef0963169efbc89ec7ecfea4c3
using OperatorOverloading.Model;
namespace OperatorOverloading.Host
{
    class Program
    {
        public static void Main(string[] args)
        {
<<<<<<< HEAD
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
=======
           // Program programObject=new Program();
            string amountTemporary;
            string currencyTemporary;
            try
            {
                Money moneyObject = new Money();

                //Take input First Amount

                Console.WriteLine("Enter Amount");
                moneyObject.Amount =ValidateInputAmount();
                
                Console.WriteLine("Enter Currency");
                moneyObject.Currency = ValidateInputCurrency();
               
                Money moneyObject1 = new Money(moneyObject.Amount, moneyObject.Currency);

                Console.WriteLine("Enter Amount");
                moneyObject.Amount =ValidateInputAmount();

                Console.WriteLine("Enter Currency");
                moneyObject.Currency =ValidateInputCurrency();
              
                Money moneyObject2 = new Money(moneyObject.Amount, moneyObject.Currency);

                //call to opeartor overloading

                Money moneyObject3 = moneyObject1 + moneyObject2;
                Console.WriteLine("First Amount :  {0}", moneyObject1);
                Console.WriteLine("Second Amount:  {0}", moneyObject2);
                Console.WriteLine("Total Money :  {0}", moneyObject3);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
           
            
        }
        public static double ValidateInputAmount()
        {
            double amountTemporary;
            if (Double.TryParse(Console.ReadLine(), out amountTemporary)==false)       
            {
                Console.WriteLine("Please Enter Correct Amount");
                return ValidateInputAmount();

            }
            else
                return amountTemporary;
        }
        public static string ValidateInputCurrency()
        {
           string currencyTemporary = Console.ReadLine();
            if (currencyTemporary.Length != 3)
            {
                Console.WriteLine("Enter Correct Currency");
                return ValidateInputCurrency();
            }
            else
            {
                return currencyTemporary;
            }
        }

>>>>>>> 76ad9eeceace4bef0963169efbc89ec7ecfea4c3
    }
}