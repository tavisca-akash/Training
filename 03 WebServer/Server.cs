using Program.cs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace WebServer
{
    public class Server
    {
        // check for already running
        private bool _running = false;
        private int _timeout = 5;
        private Encoding _charEncoder = Encoding.UTF8;
        private Socket _serverSocket;
        private string _contentPath;
     
        private int _port;

        public Server(int port, string contentPath)
        {
            _serverSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            _serverSocket.Bind(new IPEndPoint(IPAddress.Any, _port));
            _serverSocket.Listen(10);    //no of request in queue
            _serverSocket.ReceiveTimeout = _timeout;
            _serverSocket.SendTimeout = _timeout;
            _running = true; //socket created

            _contentPath = contentPath;
            _port = port;
           

        }
        //create socket and initialization

        public void Start()
        {
          
            Socket clientSocket;
            clientSocket = _serverSocket.Accept();

            Listener listener = new Listener(_serverSocket, _contentPath);
            Dispatcher dispatcher = new Dispatcher(clientSocket, _contentPath);
           
            try
            {
                while (_running)
                {
                  
                    Task.Factory.StartNew(() =>
                    {
                        dispatcher.Disapach();
                    });
                    Task.Factory.StartNew(() =>
                    {
                        listener.AcceptRequest(clientSocket);
                    });  
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
