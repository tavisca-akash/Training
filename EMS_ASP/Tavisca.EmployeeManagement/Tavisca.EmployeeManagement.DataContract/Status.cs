using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;

namespace Tavisca.EmployeeManagement.DataContract
{
    [DataContract]
    public class Status
    {
        [DataMember]
        public String StatusCode
        {
            get;
            set;
        }

        [DataMember]
        public string Message
        {
            get;
            set;
        }
        public Status()
        {
        }
        public Status(string statusCode, string message)
        {
            this.StatusCode = statusCode;
            this.Message = message;
        }
    }
}
