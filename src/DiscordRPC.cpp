#include "../include/DiscordRPC.h"
#include <iostream>

namespace discordrpc
{
    void init(const char* appId)
    {
        std::cout << "[DiscordRPC] Initialized with App ID: " << appId << std::endl;
    }

    void shutdown()
    {
        std::cout << "[DiscordRPC] Shutdown called." << std::endl;
    }

    void update(const char* details, const char* state)
    {
        std::cout << "[DiscordRPC] Update -> Details: "
                  << details << " | State: "
                  << state << std::endl;
    }
}

// Haxe Bindings

extern "C"
{

    void discord_init(value appId)
    {
        discordrpc::init(val_string(appId));
    }
    DEFINE_PRIM(discord_init, 1);

    void discord_shutdown()
    {
        discordrpc::shutdown();
    }
    DEFINE_PRIM(discord_shutdown, 0);

    void discord_update(value details, value state)
    {
        discordrpc::update(val_string(details), val_string(state));
    }
    DEFINE_PRIM(discord_update, 2);
}
