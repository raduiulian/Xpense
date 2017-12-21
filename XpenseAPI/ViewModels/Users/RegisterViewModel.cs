using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XpenseAPI.ViewModels.Users
{
    public class RegisterViewModel
    {
        public string Name { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string PremiumMember { get; set; }
        public string Email { get; set; }
    }
}