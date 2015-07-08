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

            double amountTemporary;
            try
            {
                Money moneyObject = new Money();

                //Take input First Amount

                Console.WriteLine("Enter Amount");
                if (Double.TryParse(Console.ReadLine(), out amountTemporary))
                    moneyObject.Amount = amountTemporary;
                else
                    throw new System.FormatException("Invalid Input Format");
                Console.WriteLine("Enter Currency");

                while (true)
                {
                    moneyObject.Currency = Console.ReadLine();
                 
                    if (moneyObject.Currency.Length != 3)
                    {
                        Console.WriteLine("Enter Correct Currency");
                    }
                    else
                    {      
                        break;
                    }
                
                }
                Money moneyObject1 = new Money(moneyObject.Amount, moneyObject.Currency);
                ////Take input second Amount

                Console.WriteLine("Enter Amount");
                if (double.TryParse(Console.ReadLine(), out amountTemporary))
                    moneyObject.Amount = amountTemporary;
                else
                    throw new System.FormatException("Invalid Input");

                Console.WriteLine("Enter currency");
                while (true)
                {
                    moneyObject.Currency = Console.ReadLine();
                 
                    if (moneyObject.Currency.Length != 3)
                    {
                        Console.WriteLine("Enter Correct Currency");
                    }
                    else
                    {      
                        break;
                    }
                
                }

                Money moneyObject2 = new Money(moneyObject.Amount, moneyObject.Currency);

                //call to opeartor overloading
                
                Money moneyObject3 = moneyObject1 + moneyObject2;
                Console.WriteLine("First Amount :  {0}", moneyObject1);
                Console.WriteLine("Second Amount:  {0}", moneyObject2);
                Console.WriteLine("Total Money :  {0}", moneyObject3);
            }
            catch (ArgumentException e)
            {
                Console.WriteLine(e.Message);
            }
            catch (FormatException e)
            {
                Console.WriteLine("Input format is invalid....");
            }
            catch(NullReferenceException e)
            {
                Console.WriteLine("Object refering to null....");
            }
            
        }
    }
}
