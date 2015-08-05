using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
namespace AuthenticationForm.Model
{
        [DataContract]
        public  class Employee
        {
            //internal Employee()
            //{
            //    JoiningDate = DateTime.UtcNow;
            //}

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

            //[DataMember]
            //public DateTime JoiningDate { get; set; }

            [DataMember]
            public string Password{ get; set; }

            //[DataMember]
            //public string Username { get; set; }
            
            [DataMember]
            public string Designation { get; set; }
            
            [DataMember]
            public List<Remark> Remarks { get; set; }

            public void Validate()
            {
                if (string.IsNullOrWhiteSpace(this.FirstName))
                    throw new Exception("FirstName cannot be null or empty.");

                if (string.IsNullOrWhiteSpace(this.Email))
                    throw new Exception("Email cannot be null or empty.");

                //  if (this.JoiningDate == DateTime.MinValue || this.JoiningDate == DateTime.MinValue)
                //   throw new Exception("Invalid joining date provided.");


            }

            public void PasswordValidate()
            {
                if (string.IsNullOrWhiteSpace(this.Password))
                    throw new Exception("password cannot be null or empty.");
            }

            //public Session.Employee ToSession()
            //{
            //    return new Session.Employee
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