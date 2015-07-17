﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
<<<<<<< HEAD
<<<<<<< HEAD

=======
using OperatorOverloading.dbl;
>>>>>>> currencyconvertor
=======
using OperatorOverloading.dbl;
>>>>>>> OperatorOverloading
namespace OperatorOverloading.Model
{
    public class Money
    {
        private string _currency;

        //constructor to assign values
        public Money(double amount, string currency)
        {
            Amount = amount;
            Currency = currency;
        }
        public Money() { }

<<<<<<< HEAD
<<<<<<< HEAD
        //properties 
        public double Amount { 
            get; 
=======
        public Money(String s)
        {
            Currency = s;
        }

        //properties 
        public double Amount
        {
            get;
>>>>>>> currencyconvertor
=======
        public Money(String s) {
            Currency = s;
        }

        //properties 
        public double Amount
        {
            get;
>>>>>>> OperatorOverloading
            set;
        }

        public string Currency
        {
            get
            {
                return _currency;
            }
            set
            {
                if (string.IsNullOrWhiteSpace(value) || value.Length != 3)
                    throw new Exception();
                else
                    _currency = value;
            }
        }
<<<<<<< HEAD
<<<<<<< HEAD
        
=======
>>>>>>> OperatorOverloading

        public double ConvertCurrency(string currency1, string currency2)
        {
            Conversion conversion=new Conversion();
            return conversion.Converts(currency1,currency2);
        }
        //constructor just to initalize object
        //operator overloading  
        public static Money operator +(Money money1, Money money2)
        {
            //If Object s null
            if (Object.ReferenceEquals(money1, null) || Object.ReferenceEquals(money2, null))
                throw new NullReferenceException(Messages.NullReference);
            if (money1.Equals("") || money2.Equals(""))
            {
                throw new ArgumentNullException(Messages.NullArgument);
            }

            if (String.Equals(money1.Currency, money2.Currency, StringComparison.OrdinalIgnoreCase) == false)
            {
                throw new Exception(Messages.CurrencyMismatch);
            }
            if (double.IsInfinity(money1.Amount + money2.Amount))
                throw new Exception(Messages.DoubleOverflow);
            return new Money(money1.Amount + money2.Amount, money1.Currency);
        }

        public override string ToString()
<<<<<<< HEAD
       {
          return (String.Format("{0}  {1}", Amount, Currency));
       }
  }
=======

        public double ConvertCurrency(double amount,string sourceCurrency, string targetCurrency)
        {
            CurrencyConversion conversion = new CurrencyConversion();
            double exchangeRate = conversion.GetExchangeRate(sourceCurrency, targetCurrency);
            return (amount * exchangeRate);
        }
       
        //constructor just to initalize object
        //operator overloading  
        public static Money operator +(Money money1, Money money2)
        {
            //If Object s null
            if ((money1==null) || (money2==null))
                throw new NullReferenceException(Message.NullObject);
         

            if (String.Equals(money1.Currency, money2.Currency, StringComparison.OrdinalIgnoreCase) == false)
            {
                throw new Exception(Message.MoneyMismatch);
            }

            if (double.IsInfinity(money1.Amount + money2.Amount))
                throw new Exception(Message.ValueOverflow);
            return new Money(money1.Amount + money2.Amount, money1.Currency);
        }

        public override string ToString()
=======
>>>>>>> OperatorOverloading
        {
            return (String.Format("{0}  {1}", Amount, Currency));
        }
    }
<<<<<<< HEAD
>>>>>>> currencyconvertor
=======
>>>>>>> OperatorOverloading
}