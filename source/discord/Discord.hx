package discord;

#if desktop
import sys.thread.Thread;
import discord_rpc.DiscordRpc;
#end

class Discord
{
    #if desktop
    public static var clientID:String = "YOUR_DISCORD_APPLICATION_ID";
    private static var started:Bool = false;
    #end

    /**
     * Initialize Discord RPC
     */
    public static function initialize():Void
    {
        #if desktop
        if (started) return;

        var options:DiscordRpcOptions = {
            clientID: clientID,
            onReady: onReady,
            onError: onError,
            onDisconnected: onDisconnected
        };

        DiscordRpc.start(options);
        started = true;

        // Background process loop
        Thread.create(function() {
            while (true)
            {
                DiscordRpc.process();
                Sys.sleep(2);
            }
        });
        #end
    }

    /**
     * Change Rich Presence
     */
    public static function changePresence(details:String, state:String):Void
    {
        #if desktop
        if (!started) return;

        DiscordRpc.presence({
            details: details,
            state: state,
            largeImageKey: "logo",
            largeImageText: "Extension Discord RPC",
            startTimestamp: Date.now().getTime()
        });
        #end
    }

    /**
     * Shutdown RPC
     */
    public static function shutdown():Void
    {
        #if desktop
        if (!started) return;

        DiscordRpc.shutdown();
        started = false;
        #end
    }

    #if desktop
    private static function onReady():Void
    {
        trace("Discord RPC Ready!");
    }

    private static function onError(code:Int, message:String):Void
    {
        trace("Discord RPC Error: " + code + " - " + message);
    }

    private static function onDisconnected(code:Int, message:String):Void
    {
        trace("Discord RPC Disconnected: " + code + " - " + message);
    }
    #end
}
