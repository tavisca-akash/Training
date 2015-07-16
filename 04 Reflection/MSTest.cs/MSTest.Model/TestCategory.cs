using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
namespace MSTest.Model
{
    [AttributeUsage(AttributeTargets.Method)]
   public class TestCategoryAttribute : Attribute
    {
        public TestCategoryAttribute()
        {
        }
        public static bool Exists(MethodInfo type)
        {
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
