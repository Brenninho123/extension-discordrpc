package discord;

#if windows
import sys.thread.Thread;
#end

class Discord
{
    private static var started:Bool = false;
    private static var clientID:String = "YOUR_DISCORD_APPLICATION_ID";

    public static function initialize():Void
    {
        #if windows
        if (started) return;

        trace("Discord RPC Initialized (Stub Mode)");
        started = true;

        Thread.create(function() {
            while (started)
            {
                Sys.sleep(2);
            }
        });
        #end
    }

    public static function changePresence(details:String, state:String):Void
    {
        #if windows
        if (!started) return;

        trace("[Discord RPC]");
        trace("Details: " + details);
        trace("State: " + state);
        #end
    }

    public static function shutdown():Void
    {
        #if windows
        if (!started) return;

        trace("Discord RPC Shutdown");
        started = false;
        #end
    }
}