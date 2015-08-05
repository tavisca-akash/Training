using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;

namespace AuthenticationForm.Model
{
    [DataContract]
    public class RemarkCount:Result
    {
        [DataMember]
        public string totalRemark
        {
            get;
            set;
        }
    }
}
