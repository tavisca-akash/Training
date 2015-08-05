using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;

namespace Tavisca.EmployeeManagement.Model
{
    
  public class ChangePassword
    {
        
       public string OldPassword { get; set; }

       public string NewPassword { get; set; }

       public string EmailId { get; set; }
   
    }
}
