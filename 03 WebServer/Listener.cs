using Program.cs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

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

        public void AcceptRequest()
        {
            Socket clientSocket = null;
            try
            {
                // Create new thread to handle the request and continue to listen the socket.
                
                clientSocket = _serverSocket.Accept();
                Decoder1 decoder = new Decoder1(clientSocket,_contentPath);
                string requestString =decoder.DecodeRequest(clientSocket);
                Console.WriteLine(requestString);
                RequestParser requestParser = new RequestParser();
                requestParser.Parser(requestString);
                Console.WriteLine(requestParser.HttpProtocolVersion);
                Processor processor = new Processor(clientSocket,_contentPath);
                processor.RequestUrl(requestParser.HttpUrl);
                Console.WriteLine("Client Connected To Serversss");
                

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
