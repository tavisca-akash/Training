using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OperatorOverloading.interfaces
{
    public interface IExchangeRateProvider
    {
        double GetExchangeRate(string sourceCurrency, string targetCurrency);
    }
}
