#ifndef DISCORD_RPC_H
#define DISCORD_RPC_H

#include <hxcpp.h>

namespace discordrpc
{
    void init(const char* appId);
    void shutdown();
    void update(const char* details, const char* state);
}

#endif
