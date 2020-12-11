using System;

namespace server.Model.Authentication
{
    public class LoginResponse
    {
        public DateTime Expiration { get; set; }
        public string Token { get; set; }
    }
}
