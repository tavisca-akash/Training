using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MSTest.Model;
using System.Reflection;
using System.Reflection.Emit;
namespace MSTest.cs
{
    class Program
    {
        static void Main(string[] args)
        {
            List<string> listTestMethods = new List<string>();
            List<string> listIgnoreMethods = new List<string>();
            try
            {
                Assembly assembly = Assembly.LoadFrom(args[0]);

                foreach (Type type in assembly.GetTypes())
                {
                    if (type.IsClass && TestClassAttribute.Exists(type))
                    {
                        Console.WriteLine("The name of class is :{0}\n", type.FullName);
                        foreach (MethodInfo method in (type.GetMethods()))
                        {

                            if (TestMethodAttribute.Exists(method))
                            {
                                if (IgnoreMethodAttribute.Exists(method))
                                    listTestMethods.Add(method.Name);
                                else if (TestMethodAttribute.Exists(method))
                                    listIgnoreMethods.Add(method.Name);
                                }

                        }
                    }
                }
            }
            catch (Exception exception)
            {
                Console.WriteLine(exception.StackTrace);
            }

            Console.WriteLine("Ignored Methods");
            for (int i = 0; i < listIgnoreMethods.Count; i++)
            {
                Console.WriteLine("{0}", listIgnoreMethods[i]);           
            }
            Console.WriteLine("Methods To Be Tested");
            for (int i = 0; i < listTestMethods.Count; i++)
            {
                Console.WriteLine("{0}", listTestMethods[i]);
            }
            Console.ReadKey();
        }
    }
}
