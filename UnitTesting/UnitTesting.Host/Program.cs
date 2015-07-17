﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using TestCLass;
using TestAttribute;
namespace Host
{
    class Program
    {
        public static void Main(string[] args)
        {
            Console.WriteLine("Enter the Category type: SmokeTest/LoadTest");
            var category = Console.ReadLine();
            try
            {
                if (string.IsNullOrWhiteSpace(args[0]) || string.IsNullOrWhiteSpace(category))
                {
                    throw new ArgumentException("");
                }
            }

            catch (ArgumentException e)
            {
                Console.WriteLine(e.Message);
            }

            Assembly assembly = Assembly.LoadFrom(args[0]);

            foreach (Type type in assembly.GetTypes())
            {
                if (type.IsClass && TestClassAttribute.Exists(type))
                {
                    Console.WriteLine("Class:{0}",type.Name);
                    foreach (MethodInfo method in (type.GetMethods()))
                    {
                        
                        if (TestMethodAttribute.Exists(method))
                        {
                            if (IgnoreAttribute.Exists(method))
                                Console.WriteLine("IgnoredMethod is :{0}()", method.Name);
                            else if (string.IsNullOrWhiteSpace(category) || TestCategoryAttribute.Exists(method, category))
                                Console.WriteLine("TestMethod :{0}()\n", method.Name);
                        }
                    }
                }
            }
            Console.ReadKey();
        }
    }
}