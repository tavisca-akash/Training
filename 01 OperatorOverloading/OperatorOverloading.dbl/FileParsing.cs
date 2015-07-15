﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OperatorOverloading.dbl
{
   public class FileParsing
    {
        static string[] initialData;
        static string[] finalData;
        public static string[] ParsingData()
        {
            string line;
            string completeData = "";
            System.IO.StreamReader file =
               new System.IO.StreamReader(@"D:\Training\01 OperatorOverloading\OperatorOverloading.dbl\Data.txt");
            if (file == null)
                throw new Exception(Messages.FileNotFound);
            completeData = file.ReadToEnd();
            file.Close();
            finalData = completeData.Split('{', ',', '}');
            
            return finalData;
        }
    }
}