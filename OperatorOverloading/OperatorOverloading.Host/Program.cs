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


            Money monyObject = new Money();
            
            //Take input Frst ammount
            Console.WriteLine("Enter Ammount and currency");
           
            //split given line

           String inputLine =(Console.ReadLine());
           string[] inputSplit = inputLine.Split(' ');
           monyObject.Ammount = Convert.ToDouble(inputSplit[0]);
           monyObject.Currency = inputSplit[1];
            
            Money moneyObject1 = new Money(monyObject.Ammount, monyObject.Currency);

            ////Take input Frst ammount
            Console.WriteLine("Enter Ammount and currency to add");
             inputLine = (Console.ReadLine());
             inputSplit = inputLine.Split(' ');

            monyObject.Ammount = Convert.ToDouble(inputSplit[0]);
            monyObject.Currency = inputSplit[1];
        

            Money moneyObject2 = new Money(monyObject.Ammount, monyObject.Currency);

            //call to opeartor overloading
            Money moneyObject3 = moneyObject1 + moneyObject2;

            Console.WriteLine("First Ammount :  {0}", moneyObject1);
            Console.WriteLine("Second Ammount:  {0}", moneyObject2);
            Console.WriteLine("Total Money :  {0}", moneyObject3);
        }
    }
}
