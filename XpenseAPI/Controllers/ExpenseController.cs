using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using XpenseAPI.Models;
using XpenseAPI.ViewModels.Expense;
namespace XpenseAPI.Controllers
{
    [RoutePrefix("api/Expense")]
    public class ExpenseController : ApiController
    {
        [HttpGet]
        [Route("GetAllExpenses")]
        public IEnumerable<ExpenseViewModel> GetAllExpenses()
        {
            using (var dbContext = new ApplicationDBContext())
            {
                var expenses = dbContext.expenses.ToList().Select(u => new ExpenseViewModel { Id = u.id, Value = u.value, Type = u.type });
                return expenses;
            };
        }

        [HttpGet]
        [Route("GetExpense/{id}")]
        public IEnumerable<ExpenseViewModel> GetExpense([FromUri]int id)
        {
            using (var dbContext = new ApplicationDBContext())
            {
                var expense = dbContext.expenses.Where(e => e.userId == id).ToList().Select(u => new ExpenseViewModel { Id = u.id, Value = u.value, Type = u.type });
                return expense;
            };
        }

        [HttpPost]
        [Route("CreateExpense")]
        public Expense CreateExpense([FromBody] CreateExpenseViewModel expenseViewModel)
        {
            using (var dbContext = new ApplicationDBContext())
            {
                var expense = new Expense
                {
                    value = expenseViewModel.Value,
                    userId = expenseViewModel.UserId,
                    type = expenseViewModel.Type
                };
                dbContext.expenses.Add(expense);
                dbContext.SaveChanges();
                return expense;
            };
        }

        [HttpDelete]
        [Route("DeleteExpense/{id}")]
        public Expense DeleteExpense([FromUri] int id)
        {
            using (var dbContext = new ApplicationDBContext())
            {

                var expense = dbContext.expenses.FirstOrDefault(e => e.id == id);
                dbContext.expenses.Remove(expense);
                dbContext.SaveChanges();
                return expense;
            };
        }

        [HttpPut]
        [Route("UpdateExpense")]
        public Expense UpdateFood([FromBody] UpdateExpenseViewModel updateViewModel)
        {
            using ( var dbContext = new ApplicationDBContext())
            {

                var expense = dbContext.expenses.FirstOrDefault(e => e.id == updateViewModel.Id);
                expense.value = updateViewModel.Value;
                expense.type = updateViewModel.Type;
                dbContext.SaveChanges();
                return expense;
            };
        }
    }
}
