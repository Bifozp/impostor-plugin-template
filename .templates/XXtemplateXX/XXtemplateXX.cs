using System.Threading.Tasks;
using Impostor.Api.Games.Managers;
using Impostor.Api.Innersloth;
using Impostor.Api.Plugins;
using Microsoft.Extensions.Logging;

namespace Impostor.Plugins.XXtemplateXX
{
    [ImpostorPlugin("gg.impostor.XLtemplateLX")]
    public class XXtemplateXX : PluginBase
    {
        private readonly ILogger<XXtemplateXX> _logger;
        private readonly IGameManager _gameManager;

        public XXtemplateXX(ILogger<XXtemplateXX> logger, IGameManager gameManager)
        {
            _logger = logger;
            _gameManager = gameManager;
        }

        public override async ValueTask EnableAsync()
        {
            _logger.LogInformation("XXtemplateXX is being enabled.");

            var game = await _gameManager.CreateAsync(new GameOptionsData());
            if (game == null)
            {
                _logger.LogWarning("XXtemplateXX game creation was cancelled");
            }
            else
            {
                game.DisplayName = "Example game";
                await game.SetPrivacyAsync(true);

                _logger.LogInformation("Created game {0}.", game.Code.Code);
            }
        }

        public override ValueTask DisableAsync()
        {
            _logger.LogInformation("XXtemplateXX is being disabled.");
            return default;
        }
    }
}
