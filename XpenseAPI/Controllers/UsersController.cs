using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using XpenseAPI.Models;
using XpenseAPI.ViewModels.Users;
namespace XpenseAPI.Controllers
{
    [RoutePrefix("api/Users")]
    public class UsersController : ApiController
    {
        [Route("Register")]
        [HttpPost]
        public ResultViewModel Register([FromBody] RegisterViewModel registerViewModel)
        {
            using (var dbContext = new ApplicationDBContext())
            {
                var myResult = dbContext.users.FirstOrDefault(user => user.username == registerViewModel.Username || user.email == registerViewModel.Email);


                if (myResult == null)
                {
                    User newUser = new User()
                    {
                        username = registerViewModel.Username,
                        password = registerViewModel.Password,
                        email = registerViewModel.Email,
                        name = registerViewModel.Name,
                        premiumMember = (registerViewModel.PremiumMember == "True") ? true : false
                    };
                    dbContext.users.Add(newUser);
                    dbContext.SaveChanges();
                    return new ResultViewModel()
                    {
                        Success = "true",
                        Message = "User created successfully",
                        Id = newUser.id,
                        PremiumMember = newUser.premiumMember.ToString(),
                        Name = newUser.name,
                        Email = newUser.email
                    };

                }
                else return new ResultViewModel()
                {
                    Success = "false",
                    Message = "User already registered",

                };
            }
        }
        [Route("Login/")]
        [HttpPost]
        public ResultViewModel Login([FromBody] LoginViewModel loginViewModel)
        {
            using (var dbContext = new ApplicationDBContext())
            {
                var myResult = dbContext.users.FirstOrDefault(user => user.username == loginViewModel.Username && user.password == loginViewModel.Password);
                if (myResult == null)
                    return new ResultViewModel()
                    {
                        Success = "false",
                        Message = "User does not exist",

                    };
                else return new ResultViewModel()
                {
                    Success = "true",
                    Message = "Successful",
                    Id = myResult.id,
                    PremiumMember = myResult.premiumMember.ToString(),
                    Name = myResult.name,
                    Email = myResult.email
                };
            }

        }
    }
}
