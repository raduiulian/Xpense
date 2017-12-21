namespace XpenseAPI.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class amadaugatemail : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Expenses", "type", c => c.String());
            AddColumn("dbo.Users", "email", c => c.String());
        }
        
        public override void Down()
        {
            DropColumn("dbo.Users", "email");
            DropColumn("dbo.Expenses", "type");
        }
    }
}
