﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using WebServer;
namespace webserver.Model
{
    class Program
    {
        static void Main(string[] args)
        {
            int port;

            if(int.TryParse(ConfigurationManager.AppSettings["webserver-port"],out port)==false)
                throw new Exception();

            string path = ConfigurationManager.AppSettings["virtual-directory"];
            Server server = new Server(port, path);

            server.Start();
        }
    }
}
