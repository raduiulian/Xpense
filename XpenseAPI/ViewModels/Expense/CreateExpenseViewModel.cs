using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XpenseAPI.ViewModels.Expense
{
    public class CreateExpenseViewModel
    {
        public float Value { get; set; }
        public int UserId { get; set; }
        public string Type { get; set; }
    }
}