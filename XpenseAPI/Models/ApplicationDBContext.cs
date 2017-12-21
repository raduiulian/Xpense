using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace XpenseAPI.Models
{
    public class ApplicationDBContext : DbContext
    {
        public ApplicationDBContext() : base("defaultconnection")
        {

        }
        public DbSet<Expense> expenses { get; set; }
        public DbSet<User> users { get; set; }
        public DbSet<Group> groups { get; set; }
    }
}