using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XpenseAPI.ViewModels.Expense
{
    public class ExpenseViewModel
    {
        public int Id { get; set; }
        public float Value { get; set; }
        public string Type { get; set;  }
    }
}