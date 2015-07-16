using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Sockets;
using WebServer;
namespace Program.cs
{
    class Dispatcher
    {
        private string _contentPath;
        private Socket _clientSocket;
        public Dispatcher(Socket clientSocket, string contentPath)
        {
            _contentPath = contentPath;
            _clientSocket = clientSocket;
        }
        public void Disapach()
        {
            Console.WriteLine("in dispatch");
            Processor processor = new Processor(_clientSocket, _contentPath);
            if (Queueue.queue.Count > 0)
            {
                processor.RequestUrl(Queueue.queue.Dequeue());
                Console.WriteLine("in dispatch if");
            }
           
        }
    }
}
