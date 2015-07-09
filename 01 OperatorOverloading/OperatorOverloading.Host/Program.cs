using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OperatorOverloading.Model;
namespace OperatorOverloading.Host
{
    class Program
    {
        public static void Main(string[] args)
        {
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

    }
}