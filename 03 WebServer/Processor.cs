﻿using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace WebServer
{
    public class Processor
    {
        RegistryKey registryKey = Registry.ClassesRoot;

        public Socket ClientSocket = null;
        private Encoding _charEncoder = Encoding.UTF8;
        private string _contentPath;
        public FileHandler FileHandler;
        private int _timeout = 10;
        public Processor(Socket clientSocket, string contentPath)
        {
            _contentPath = contentPath;
            ClientSocket = clientSocket;
            FileHandler = new FileHandler(_contentPath);
        }
        public void processRequest(string requestedFile )
        {
            var handler = new System.Threading.Thread(() =>
            {
                ClientSocket.ReceiveTimeout = _timeout;
                ClientSocket.SendTimeout = _timeout;
                RequestUrl(requestedFile);
            });
        }
        public void RequestUrl(string requestedFile)
        {
            int dotIndex = requestedFile.LastIndexOf('.') + 1;
            if (dotIndex > 0)
            {
                if (FileHandler.DoesFileExists(requestedFile))    //If yes check existence of the file
                    SendResponse(ClientSocket, FileHandler.ReadFile(requestedFile), "200 Ok", GetTypeOfFile(registryKey, (_contentPath + requestedFile)));
                else
                    SendErrorResponce(ClientSocket);      // We don't support this extension.
            }
            else   //find default file as index .html of index.html
            {
                if (FileHandler.DoesFileExists("\\index.htm"))
                    SendResponse(ClientSocket, FileHandler.ReadFile("\\index.htm"), "200 Ok", "text/html");
                else if (FileHandler.DoesFileExists("\\index.html"))
                    SendResponse(ClientSocket, FileHandler.ReadFile("\\index.html"), "200 Ok", "text/html");
                else
                    SendErrorResponce(ClientSocket);
            }
        }

        private string GetTypeOfFile(RegistryKey registryKey, string fileName)
        {
            RegistryKey fileClass = registryKey.OpenSubKey(Path.GetExtension(fileName));
            return fileClass.GetValue("Content Type").ToString();
        }

        private void SendErrorResponce(Socket clientSocket)
        {
            byte[] emptyByteArray = new byte[0];
            SendResponse(clientSocket, emptyByteArray, "404 Not Found", "text/html");
        }


        private void SendResponse(Socket clientSocket, byte[] byteContent, string responseCode, string contentType)
        {
            try
            {
                byte[] byteHeader = CreateHeader(responseCode, byteContent.Length, contentType);
                clientSocket.Send(byteHeader);
                clientSocket.Send(byteContent);

                clientSocket.Close();
            }
            catch
            {
            }
        }

        private byte[] CreateHeader(string responseCode, int contentLength, string contentType)
        {
            return _charEncoder.GetBytes("HTTP/1.1 " + responseCode + "\r\n"
                                  + "Server: Simple Web Server\r\n"
                                  + "Content-Length: " + contentLength + "\r\n"
                                  + "Connection: close\r\n"
                                  + "Content-Type: " + contentType + "\r\n\r\n");
        }
    }
}
