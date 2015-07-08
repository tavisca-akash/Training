using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OperatorOverloading.Model
{
    public class Money
    {

      

        //constructor to assign values
        public Money(double amount, string currency)
        {
           Amount = amount;
            Currency = currency;
        }

        //properties 
        public double Amount { get; set; }

        public string Currency { get; set; }
        

        //constructor just to initalize object
        public Money()
        {

        }

        //operator overloading  
        public static Money operator +(Money money1, Money money2)
        {

            if (!string.Equals( money1.Currency,money2.Currency,StringComparison.CurrentCultureIgnoreCase))
            {
                throw new ArgumentException(Messages.InvalidCurrency);
            }
            
            return new Money(money1.Amount + money2.Amount, money1.Currency);


        }
        public override string ToString()
        {
            return (String.Format("{0}  {1}", Amount, Currency));
        }
    }
}
