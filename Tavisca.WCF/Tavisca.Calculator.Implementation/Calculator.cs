using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using Tavisca.WCF.Services;

namespace Tavisca.WCF.Implementation
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in both code and config file together.
    public class Calculator : ICalculator
    {
        public int Addition(int firstNumber, int secondNumber)
        {
            int answer = firstNumber + secondNumber;
            return answer;
        }
        public int Subtraction(int firstNumber, int secondNumber)
        {
            int answer = firstNumber - secondNumber;
            return answer;
        }
        public int Multiplication(int firstNumber, int secondNumber)
        {
            int answer = firstNumber * secondNumber;
            return answer;
        }
        public int Division(int firstNumber, int secondNumber)
        {
            int answer = firstNumber - secondNumber;
            return answer;
        }
    }
}