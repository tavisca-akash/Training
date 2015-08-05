using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AuthenticationForm
{
    public partial class PasswordChange : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string oldPassword, newPassword, confirmPassword;
            oldPassword = TextBoxOldPassword.Text;
            newPassword = TextBoxNewPassword.Text;
            confirmPassword = TextBoxConfirmPassword.Text;
            int Id = int.Parse(string.Format("{0}", Session["Idd"]));
            try
            {
                using (SqlConnection conn = new SqlConnection())
                {
                    conn.ConnectionString = "Data Source=TRAINING3;Initial Catalog=EmployeeDataBase;User ID=sa;Password=test123!@#";
                    SqlCommand commandRemark = new SqlCommand("ChangePassword", conn);
                    commandRemark.CommandType = CommandType.StoredProcedure;
                    commandRemark.Parameters.Add(new SqlParameter("@Id", Id));
                    commandRemark.Parameters.Add(new SqlParameter("@Password", oldPassword));
                    commandRemark.Parameters.Add(new SqlParameter("@changedPassword", newPassword));
                    conn.Open();
                    commandRemark.ExecuteNonQuery();
                    conn.Close();
                }

            }
            catch (Exception )
            {

            }

        }
    }
}