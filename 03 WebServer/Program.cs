using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebServer
{
    class Program
    {
        static void Main(string[] args)
        {
            WebServer webServer = new WebServer();
            webServer.Start(8080, @"C:\Users\abhandwalkar\Downloads\startbootstrap-sb-admin-1.0.3\startbootstrap-sb-admin-1.0.3");
        }
    }
}
