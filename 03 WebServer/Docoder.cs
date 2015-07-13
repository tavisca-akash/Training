using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Sockets;
using WebServer;
namespace Program.cs
{
    public class Decoder1
    {
        private Socket _clientSocket;
        private string _contentPath;
        private Encoding _charEncoder = Encoding.UTF8;

        public Decoder1(Socket clientSocket,string contentPath)
        {
            _clientSocket = clientSocket;
            _contentPath = contentPath;
        }
       
        public string DecodeRequest(Socket clientSocket)
        {
            var receivedBufferlen = 0;
            var buffer = new byte[10240];
            try
            {
                receivedBufferlen = clientSocket.Receive(buffer);
            }
            catch (Exception)
            {
                //Console.WriteLine("buffer full");
                Console.ReadLine();
            }
            return _charEncoder.GetString(buffer, 0, receivedBufferlen);
        }
        public void StopClientSocket(Socket clientSocket)
        {
            if (clientSocket != null)
                clientSocket.Close();
        }
    }
}
