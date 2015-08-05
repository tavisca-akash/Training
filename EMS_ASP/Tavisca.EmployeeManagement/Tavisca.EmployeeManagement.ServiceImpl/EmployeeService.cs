using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tavisca.EmployeeManagement.DataContract;
using Tavisca.EmployeeManagement.EnterpriseLibrary;
using Tavisca.EmployeeManagement.Interface;
using Tavisca.EmployeeManagement.ServiceContract;
using Tavisca.EmployeeManagement.Translator;

namespace Tavisca.EmployeeManagement.ServiceImpl
{
    public class EmployeeService : IEmployeeService
    {
        public EmployeeService(IEmployeeManager manager)
        {
            _manager = manager;
        }

        IEmployeeManager _manager;

        public DataContract.EmployeeResponse Get(string employeeId, string pageNo)
        {
            EmployeeResponse response = new EmployeeResponse();
            try
            {
                var result = _manager.Get(employeeId,pageNo);
                if (result == null)
                {
                    response.Status.StatusCode = "500";
                    response.Status.Message = "Error in getting Employee";


                    return response;
                }
                response.Employee= result.ToDataContract();
                return response;
            }
            catch (Exception ex)
            {
                //var rethrow = ExceptionPolicy.HandleException("service.policy", ex);
                //if (rethrow) throw;
                //return null;
                ExceptionPolicy.HandleException("service.policy", ex);
                response.Status.StatusCode = "500";
                response.Status.Message = "Error in getting Employee";
                return response;
            }
        }

        public DataContract.GetAllEmployee GetAll()
        {
            GetAllEmployee response = new GetAllEmployee();
            try
            {
                var result = _manager.GetAll();
                if (result == null)
                {
                    response.Status.StatusCode = "500";
                    response.Status.Message = "Error in getting Employee list";


                    return response;
                }
                response.AllEmployeeList= result.Select(employee => employee.ToDataContract()).ToList();
                return response;
            }
            catch (Exception ex)
            {
                //var rethrow = ExceptionPolicy.HandleException("service.policy", ex);
                //if (rethrow) throw;
                //return null;
                ExceptionPolicy.HandleException("service.policy", ex);
                response.Status.StatusCode = "500";
                response.Status.Message = "Error in getting Employee list";
                return response;
            }

        }
        public RemarkCount CountRemark(string employeeId)
        {
            RemarkCount response = new RemarkCount();
            try
            {
                response.totalRemark = _manager.CountRemark(employeeId);
                if (response.totalRemark == null)
                {
                    response.Status.StatusCode = "500";
                    response.Status.Message = "Error in counting remark";


                    return response;
                }
                return response;
            }
            catch (Exception ex)
            {
                ExceptionPolicy.HandleException("service.policy", ex);
                response.Status.StatusCode = "500";
                response.Status.Message = "Error in counting remark";
                return response;
            }
        }
    }
}
