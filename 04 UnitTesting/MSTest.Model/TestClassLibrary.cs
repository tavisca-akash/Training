using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Reflection;

namespace MSTest.Model
{
    [TestClass]
    public class TestClassLibrary
    {
        
       [TestMethod]
        public void Add()
        {
        }
       
        [TestMethod]
        public void Substract()
        {
        }


        [IgnoreMethod]
        public void Multiplication()
        {
        }

        [IgnoreMethod]
        public void Division()
        {
        }

        [IgnoreMethod]
        public void MakeSquare()
        {
        }

        [IgnoreMethod]
        public void ToBinary()
        {
        }


    }
}
