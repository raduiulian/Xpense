using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XpenseAPI.Models
{
    public class User
    {
        public int id { get; set; }
        public string username { get; set; }
        public string password { get; set; }
        public string email { get; set; }
        public string name { get; set; }
        public bool premiumMember { get; set; }
        public virtual ICollection<Group> groupList { get; set; }

        public User()
        {
            groupList = new HashSet<Group>();
        }
    }
}