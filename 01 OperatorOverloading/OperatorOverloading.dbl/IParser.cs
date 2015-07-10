﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OperatorOverloading.dbl
{
    public interface IParser
    {
        double Converts(string currency1, string currency2);

    }
}