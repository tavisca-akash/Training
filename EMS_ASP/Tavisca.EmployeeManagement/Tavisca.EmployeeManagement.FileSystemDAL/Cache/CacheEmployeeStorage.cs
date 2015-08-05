using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tavisca.EmployeeManagement.Interface;
using Newtonsoft.Json;
using Tavisca.EmployeeManagement.ErrorSpace;

namespace Tavisca.EmployeeManagement.FileStorage
{
    public class CacheEmployeeStorage : IEmployeeStorage
    {
        public CacheEmployeeStorage(ICacheManager manager)
        {
            _innerStorage = new EmployeeStorage();
            _cacheManager = manager;
        }

        IEmployeeStorage _innerStorage;
        ICacheManager _cacheManager;

        readonly string KEYFORMAT = "emp.{0}";
        readonly string CACHEMANAGER = "employee";

        public Model.Employee Save(Model.Employee employee)
        {
            var result = _innerStorage.Save(employee);
            _cacheManager.Add(string.Format(KEYFORMAT, result.Id), result, CACHEMANAGER);
            return result;
        }

        public Model.Employee Get(string employeeId,string pageNo)
        {
            Model.Employee result;
         //  result = _cacheManager.Get(string.Format(KEYFORMAT, employeeId), CACHEMANAGER) as Model.Employee;
          // if (result == null)
          // {
                result = _innerStorage.Get(employeeId,pageNo);
            _cacheManager.Add(string.Format(KEYFORMAT, employeeId), result, CACHEMANAGER);
         // }
            return result;
        }
        public Model.Remark SaveRemark(string employeeId, Model.Remark remark)
        {
            var result = _innerStorage.SaveRemark(employeeId,remark);
            _cacheManager.Add(string.Format(KEYFORMAT, employeeId), result, CACHEMANAGER);
            return result;
        
        }
        public bool UpdatePassword(string oldPassword,string newPassword,string emailId)
        {
            var result =_innerStorage.UpdatePassword(oldPassword,newPassword,emailId);
            _cacheManager.Add(string.Format(KEYFORMAT, emailId), result, CACHEMANAGER);
            return result;
        }
        public List<Model.Employee> GetAll()
        {
            return _innerStorage.GetAll();
        }
        public Model.Employee Authenticate(string emailId, string password)
        {
            var result = _innerStorage.Authenticate(emailId, password);
            _cacheManager.Add(string.Format(KEYFORMAT, emailId), result, CACHEMANAGER);
            return result;
        }
        public string CountRemark(string employeeId)
        {
            var result = _innerStorage.CountRemark(employeeId);
            _cacheManager.Add(string.Format(KEYFORMAT, employeeId), result, CACHEMANAGER);
            return result;
        }
    }
}
