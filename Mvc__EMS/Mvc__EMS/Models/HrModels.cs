using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Globalization;
using System.Web.Mvc;
using System.Web.Security;

namespace Mvc__EMS.Models
{
    public class AddEmployee
    {
        [Required]
        [Display(Name = "FirstName")]
        public string FirstName { get; set; }

        [Required]
        [Display(Name = "LastName")]
        public string LastName { get; set; }

        [Required]
        [Display(Name = "Title")]
        public string Title { get; set; }

        [Required]
        [Display(Name = "Email")]
        public string Email { get; set; }

        [Required]
        [Display(Name = "Phone")]
        public string Phone { get; set; }
    }

    public class AddRemark
    {

        [Required]
        [Display(Name = "Select Employee")]
        public string EmployeeName { get; set; }

        [Required]
        [Display(Name = "Remark")]
        public string Remark { get; set; }

    
    }

    public class HRProfile
    {
        public string label { get; set; }
    }


}