using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace WebServer
{
    public class WebServer
    {
        // check for already running
        private bool _running = false;
        private int _timeout = 5;
        private Encoding _charEncoder = Encoding.UTF8;
        private Socket _serverSocket;
        private string _contentPath;
        public string HttpMethod;
        public string HttpUrl;
        public string HttpProtocolVersion;
        private int _port;
        public void InitializeSocket(int port, string contentPath)
        {
            _serverSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            _serverSocket.Bind(new IPEndPoint(IPAddress.Any, port));
            _serverSocket.Listen(10);    //no of request in queue
            _serverSocket.ReceiveTimeout = _timeout;
            _serverSocket.SendTimeout = _timeout;
            _running = true; //socket created
            _contentPath = contentPath;
            _port = port;

        }
        //create socket and initialization

        public void Start(int port, string contentPath)
        {
            try
            {
               
                InitializeSocket(port, contentPath);
                while (_running)
                {
                    Listener listener = new Listener(_serverSocket, _contentPath);
                    Console.WriteLine("Server is created");
                    listener.AcceptRequest();
                }
            }
            catch
            {
                Console.WriteLine("Error in creating server socket");
                Console.ReadLine();

            }
          
        }

       public  void Stop()
        {
            _running = false;
            try
            {
                _serverSocket.Close();
            }
            catch
            {
                Console.WriteLine("Error in closing server or server already closed");
                Console.ReadLine();

            }
            _serverSocket = null;
        }

    }
}
