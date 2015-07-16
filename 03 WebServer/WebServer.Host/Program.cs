using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

namespace WebServer.Host
{
    class Program
    {
        static void Main(string[] args)
        {
            int port;

            if (int.TryParse(ConfigurationManager.AppSettings["webserver-port"], out port) == false)
                throw new Exception();

            string path = ConfigurationManager.AppSettings["virtual-directory"];
            Server server = new Server();

            server.Start(port, path);
        }
    }
}
