using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
namespace AuthenticationForm.Model.Session
{
    [DataContract]
    internal class Employee
    {

        [DataMember]
        public string Id { get; set; }

        [DataMember]
        public string Title { get; set; }

        [DataMember]
        public string FirstName { get; set; }

        [DataMember]
        public string LastName { get; set; }

        [DataMember]
        public string Email { get; set; }

        [DataMember]
        public string Phone { get; set; }

        [DataMember]
        public string Designation { get; set; }

        [DataMember]
        public List<Remark> Remarks { get; set; }

        //[DataContract]
        //internal Model.Employee ToServer()
        //{
        //    return new Model.Employee
        //    {
        //        Id = this.Id,
        //        FirstName = this.FirstName,
        //        LastName = this.LastName,
        //        Title = this.Title,
        //        Email = this.Email
        //    };
        //}

    }

}