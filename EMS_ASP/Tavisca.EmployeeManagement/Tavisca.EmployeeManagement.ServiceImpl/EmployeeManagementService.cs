using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tavisca.EmployeeManagement.ServiceContract;
using Tavisca.EmployeeManagement.Interface;
using Tavisca.EmployeeManagement.Translator;
using Tavisca.EmployeeManagement.EnterpriseLibrary;
using Tavisca.EmployeeManagement.DataContract;

namespace Tavisca.EmployeeManagement.ServiceImpl
{
    public class EmployeeManagementService : IEmployeeManagementService
    {
        public EmployeeManagementService(IEmployeeManagementManager manager)
        {
            _manager = manager;
        }

        IEmployeeManagementManager _manager;

        public DataContract.EmployeeResponse Create(DataContract.Employee employee)
        {
            EmployeeResponse response = new EmployeeResponse();
            try
            {
                employee.JoiningDate = DateTime.UtcNow;
                var result = _manager.Create(employee.ToDomainModel());
                if (result == null)
                {
                    response.Status.StatusCode = "500";
                    response.Status.Message = "Error in creating employee";


                    return response;
                }
                response.Employee = result.ToDataContract();
                return response;
            }
            catch (Exception ex)
            {
                //Exception newEx;
                //var rethrow = ExceptionPolicy.HandleException("service.policy", ex, out newEx);
                //throw newEx;


                ExceptionPolicy.HandleException("service.policy", ex);
                response.Status.StatusCode = "500";
                response.Status.Message = "Error in creating Employee";
                return response;
            }
        }

        public DataContract.RemarkResponse AddRemark(string employeeId, DataContract.Remark remark)
        {
            RemarkResponse response = new RemarkResponse();
            try
            {
                var result = _manager.AddRemark(employeeId, remark.ToDomainModel());
                if (result == null)
                {
                    response.Status.StatusCode = "500";
                    response.Status.Message = "Error in creating employee";


                    return response;
                }
                response.Remark = result.ToDataContract();
                return response;
            }
            catch (Exception ex)
            {
                //Exception newEx;
                //var rethrow = ExceptionPolicy.HandleException("service.policy", ex, out newEx);
                //throw newEx;
                ExceptionPolicy.HandleException("service.policy", ex);
                response.Status.StatusCode = "500";
                response.Status.Message = "Error in creating Employee";
                return response;
            }
        }

        public DataContract.EmployeeResponse Authenticate(DataContract.Credentials credentials)
        {
            EmployeeResponse response = new EmployeeResponse();
            var result = _manager.Authenticate(credentials.EmailId, credentials.Password);
            if (result == null)
            {
                response.Status.StatusCode = "500";
                response.Status.Message = "Error in creating employee";


                return response;
            }
            response.Employee = result.ToDataContract();
            return response;
        }

        public Result UpdatePassword(DataContract.ChangePassword changePassword)
        {
            Result response = new Result();
            try
            {
                var result = _manager.UpdatePassword(changePassword.OldPassword, changePassword.NewPassword, changePassword.EmailId);
                if (result == false)
                {
                    response.Status.StatusCode = "500";
                    response.Status.Message = "Error in updating password";
                    return response;
                }
                return response;
            }
            catch (Exception ex)
            {

                //Exception newEx;
                //var rethrow = ExceptionPolicy.HandleException("service.policy", ex, out newEx);
                //throw newEx;
                ExceptionPolicy.HandleException("service.policy", ex);
                response.Status.StatusCode = "500";
                response.Status.Message = "Error in creating Employee";
                return response;
            }

        }
    }
}
