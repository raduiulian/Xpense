using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XpenseAPI.ViewModels.Users
{
    public class ResultViewModel
    {
        public string Success { get; set; }
        public string Message { get; set; }
        public int Id { get; set; }
        public string PremiumMember { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
    }
}