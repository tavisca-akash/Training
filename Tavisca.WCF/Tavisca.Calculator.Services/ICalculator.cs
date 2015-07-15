﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace Tavisca.WCF.Services
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface ICalculator
    {
        [OperationContract]
        int Addition(int firstNumber, int secondNumber);

        [OperationContract]
        int Subtraction(int firstNumber, int secondNumber);

        [OperationContract]
        int Multiplication(int firstNumber, int secondNumber);

        [OperationContract]
        int Division(int firstNumber, int secondNumber);

    }


}