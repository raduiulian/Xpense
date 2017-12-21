using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XpenseAPI.Models
{
    public class Expense
    {


        public int id { get; set; }
        public int? userId { get; set; }
        public virtual User user { get; set; }
        public string type { get; set; }
        public float value { get; set; }
    }
}