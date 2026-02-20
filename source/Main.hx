package;

import openfl.display.Sprite;
import openfl.events.Event;
import lime.app.Application;
import sys.thread.Thread;

#if desktop
import discord_rpc.DiscordRpc;
#end

class Main extends Sprite
{
    #if desktop
    public static var CLIENT_ID:String = "YOUR_DISCORD_APPLICATION_ID";
    #end

    public function new()
    {
        super();
        addEventListener(Event.ADDED_TO_STAGE, init);
    }

    function init(e:Event):Void
    {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        #if desktop
        initDiscord();
        #end
    }

    #if desktop
    function initDiscord():Void
    {
        var options:DiscordRpcOptions = {
            clientID: CLIENT_ID,
            onReady: onReady,
            onError: onError,
            onDisconnected: onDisconnected
        };

        DiscordRpc.start(options);

        // Update loop
        Thread.create(function() {
            while (true)
            {
                DiscordRpc.process();
                Sys.sleep(2);
            }
        });
    }

    function onReady():Void
    {
        trace("Discord RPC Ready!");

        DiscordRpc.presence({
            details: "Using Extension Discord RPC",
            state: "Main Menu",
            largeImageKey: "logo",
            largeImageText: "Extension Discord RPC",
            startTimestamp: Date.now().getTime()
        });
    }

    function onError(code:Int, message:String):Void
    {
        trace("Discord RPC Error: " + code + " - " + message);
    }

    function onDisconnected(code:Int, message:String):Void
    {
        trace("Discord RPC Disconnected: " + code + " - " + message);
    }
    #end
}
