namespace XpenseAPI.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class InitialMigration : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Expenses",
                c => new
                    {
                        id = c.Int(nullable: false, identity: true),
                        userId = c.Int(),
                        value = c.Single(nullable: false),
                    })
                .PrimaryKey(t => t.id)
                .ForeignKey("dbo.Users", t => t.userId)
                .Index(t => t.userId);
            
            CreateTable(
                "dbo.Users",
                c => new
                    {
                        id = c.Int(nullable: false, identity: true),
                        username = c.String(),
                        password = c.String(),
                        name = c.String(),
                        premiumMember = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.id);
            
            CreateTable(
                "dbo.Groups",
                c => new
                    {
                        id = c.Int(nullable: false, identity: true),
                    })
                .PrimaryKey(t => t.id);
            
            CreateTable(
                "dbo.GroupUsers",
                c => new
                    {
                        Group_id = c.Int(nullable: false),
                        User_id = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.Group_id, t.User_id })
                .ForeignKey("dbo.Groups", t => t.Group_id, cascadeDelete: true)
                .ForeignKey("dbo.Users", t => t.User_id, cascadeDelete: true)
                .Index(t => t.Group_id)
                .Index(t => t.User_id);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Expenses", "userId", "dbo.Users");
            DropForeignKey("dbo.GroupUsers", "User_id", "dbo.Users");
            DropForeignKey("dbo.GroupUsers", "Group_id", "dbo.Groups");
            DropIndex("dbo.GroupUsers", new[] { "User_id" });
            DropIndex("dbo.GroupUsers", new[] { "Group_id" });
            DropIndex("dbo.Expenses", new[] { "userId" });
            DropTable("dbo.GroupUsers");
            DropTable("dbo.Groups");
            DropTable("dbo.Users");
            DropTable("dbo.Expenses");
        }
    }
}
