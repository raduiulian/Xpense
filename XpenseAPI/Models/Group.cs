using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XpenseAPI.Models
{
    public class Group
    {
        public int id { get; set; }
        public virtual ICollection<User> userList { get; set; }

        public Group()
        {
            userList = new HashSet<User>();
        }
    }
}