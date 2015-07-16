using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
namespace MSTest.Model
{
   
    [AttributeUsage(AttributeTargets.Method)]
    public class TestMethodAttribute : Attribute
    {
        public TestMethodAttribute()
        {
        }
        public static bool Exists(MethodInfo type)
        {
            //Console.WriteLine(type);
            foreach (object attribute in type.GetCustomAttributes(true))
            {
                if (attribute is TestMethodAttribute)
                {
                    return true;
                }
            }
            return false;
        }
    }
}
