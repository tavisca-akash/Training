﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OperatorOverloading.dbl
{
   public class  Parser
    {
        static string[] parsedData;
        public static string[] GetParsingData(string data)
        {        
            parsedData = data.Split('{', ',', '}');
            return parsedData;            
        }
    }
}