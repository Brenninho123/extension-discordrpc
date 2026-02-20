package discord;

import cpp.Lib;

class NativeDiscord
{
    private static var _init = Lib.load("extension-discordrpc", "discord_init", 1);
    private static var _shutdown = Lib.load("extension-discordrpc", "discord_shutdown", 0);
    private static var _update = Lib.load("extension-discordrpc", "discord_update", 2);

    public static function init(appId:String):Void
    {
        #if cpp
        _init(appId);
        #end
    }

    public static function shutdown():Void
    {
        #if cpp
        _shutdown();
        #end
    }

    public static function update(details:String, state:String):Void
    {
        #if cpp
        _update(details, state);
        #end
    }
}