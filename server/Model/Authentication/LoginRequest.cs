using System.ComponentModel.DataAnnotations;

namespace server.Model.Authentication
{
    public class LoginRequest
    {
        [Required(ErrorMessage = "Kullanıcı adınızı girin!")]
        public string Username { get; set; }

        [Required(ErrorMessage = "Parolanızı girin!")]
        public string Password { get; set; }
    }
}
