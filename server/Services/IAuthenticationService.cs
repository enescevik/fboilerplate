using server.Model;
using server.Model.Authentication;
using System.Threading.Tasks;

namespace server.Services
{
    public interface IAuthenticationService
    {
        Task<Result<LoginResponse>> Login(LoginRequest model);
        Task<Result> Register(RegisterRequest model);
    }
}
