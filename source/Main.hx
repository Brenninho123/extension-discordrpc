package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import discord.Discord;

class Main extends Sprite
{
    private static var appStartTime:Float = 0;

    public function new()
    {
        super();
        addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):Void
    {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        appStartTime = Date.now().getTime();

        // Initialize Discord RPC
        Discord.initialize();

        // Default Presence
        setPresence("Launching Application...", "Initializing");

        // Shutdown hook
        Lib.current.stage.addEventListener(Event.DEACTIVATE, onClose);
    }

    /**
     * Change Discord Presence easily
     */
    public static function setPresence(details:String, state:String):Void
    {
        Discord.changePresence(details, state);
    }

    /**
     * Example state change simulation
     */
    public static function enterMainMenu():Void
    {
        setPresence("In Main Menu", "Waiting for player");
    }

    public static function startGame(song:String, difficulty:String):Void
    {
        setPresence("Playing: " + song, "Difficulty: " + difficulty);
    }

    private function onClose(e:Event):Void
    {
        Discord.shutdown();
    }
}