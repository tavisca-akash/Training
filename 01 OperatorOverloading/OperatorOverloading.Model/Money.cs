using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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

        //properties 
        public double Amount { 
            get; 
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
       {
          return (String.Format("{0}  {1}", Amount, Currency));
       }
  }
}