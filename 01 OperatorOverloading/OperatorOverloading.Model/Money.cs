using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OperatorOverloading.Model
{
    public class Money
    {

        double ammount;
        string currency;

        //constructor to assign values
        public Money(double real, string imaginary)
        {
            this.ammount = real;
            this.currency = imaginary;
        }

        //properties 
        public double Ammount
        {
            get
            {
                return ammount;
            }
            set
            {
                ammount = value;
            }

        }
        public string Currency
        {
            get
            {
                return currency;
            }
            set
            {
                currency = value;
            }

        }

        //constructor just to initalize object
        public Money()
        {

        }

        //operator overloading  
        public static Money operator +(Money m1, Money m2)
        {

            if (m1.currency != m2.currency)
            {
                return new Money(0,"Msmatch currency");
            }
            if (m2.ammount<0)
            {
                return new Money(0, "Negatve number can not be added");
            }
            return new Money(m1.ammount + m2.ammount, m1.currency);


        }
        public override string ToString()
        {
            return (String.Format("{0}  {1}", ammount, currency));
        }
    }
}
