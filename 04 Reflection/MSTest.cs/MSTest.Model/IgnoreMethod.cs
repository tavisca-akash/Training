using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using MSTest.Model;
namespace MSTest.Model
{
    
    [AttributeUsage(AttributeTargets.Method)]
    public class IgnoreMethodAttribute : Attribute
    {
        public IgnoreMethodAttribute()
        {
        }
        public static bool Exists(MethodInfo type)
        {
            foreach (object attribute in type.GetCustomAttributes(true))
            {
                if (attribute is IgnoreMethodAttribute)
                {
                    return true;
                }
            }
            return false;
        }
    }
}

