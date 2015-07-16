using Program.cs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Program.cs;
namespace WebServer
{
    class Listener
    {
        private Socket _serverSocket;
        private int _timeout;
        private string _contentPath;
        private Encoding _charEncoder = Encoding.UTF8;

        public Listener(Socket serverSocket, String contentPath)
        {
            _serverSocket = serverSocket;
            _timeout = 15;
            _contentPath = contentPath;
        }

        public void AcceptRequest(Socket clientSocket)
        {
            Console.WriteLine("in listen");
            try
            {
                // Create new thread to handle the request and continue to listen the socket.
                
                //clientSocket = _serverSocket.Accept();

                DecodeRequest decoder = new DecodeRequest(clientSocket,_contentPath);

                string requestString = decoder.RequestDecoder(clientSocket);

                RequestParser requestParser = new RequestParser();

                requestParser.Parser(requestString);

                if (Queueue.queue.Count < 10)
                {
                    Queueue.queue.Enqueue(requestParser.HttpUrl);
                    Console.WriteLine("in liten if");
                }
                /*Dispatcher dispatcher = new Dispatcher(clientSocket,_contentPath);
                dispatcher.Disapach();*/
              
                

            }
            catch(Exception e)
            {
                Console.WriteLine(e.StackTrace);
                Console.WriteLine("Error in accepting client request");
                Console.ReadLine();
                if (clientSocket != null)
                    clientSocket.Close();
            }
        }


    }
}
