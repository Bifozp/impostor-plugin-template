using Impostor.Api.Events;
using Impostor.Api.Plugins;
using Impostor.Plugins.XXtemplateXX.Handlers;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace Impostor.Plugins.XXtemplateXX
{
    public class XXtemplateXXStartup : IPluginStartup
    {
        public void ConfigureHost(IHostBuilder host)
        {
        }

        public void ConfigureServices(IServiceCollection services)
        {
            services.AddSingleton<IEventListener, GameEventListener>();
            services.AddSingleton<IEventListener, PlayerEventListener>();
            services.AddSingleton<IEventListener, MeetingEventListener>();
            services.AddSingleton<IEventListener, AnnouncementsListener>();
        }
    }
}
