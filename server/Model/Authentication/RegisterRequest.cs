using System.ComponentModel.DataAnnotations;

namespace server.Model.Authentication
{
    public class RegisterRequest
    {
        [Required(ErrorMessage = "Kullanıcı adınızı girin!")]
        public string Username { get; set; }

        [EmailAddress]
        [Required(ErrorMessage = "E-posta adresinizi girin!")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Parolanızı girin!")]
        [MinLength(4, ErrorMessage = "Parolanız en az 4 karakter olabilir!")]
        public string Password { get; set; }
    }
}
