using Microsoft.AspNetCore.Mvc;
using server.Model.Authentication;
using server.Services;
using System.Threading.Tasks;

namespace server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthenticateController : ControllerBase
    {
        private readonly IAuthenticationService _authenticationService;

        public AuthenticateController(IAuthenticationService authenticationService)
        {
            _authenticationService = authenticationService;
        }

        [HttpGet]
        [Route("login")]
        public async Task<IActionResult> Login([FromQuery] LoginRequest request)
        {
            var result = await _authenticationService.Login(request);
            return Ok(result);
        }

        [HttpPost]
        [Route("register")]
        public async Task<IActionResult> Register([FromBody] RegisterRequest request)
        {
            var result = await _authenticationService.Register(request);
            return Ok(result);
        }
    }
}
