package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import discord.Discord;

class PlayState extends Sprite
{
    // Game info
    public var gameMode:String;
    public var levelName:String;
    public var difficulty:String;

    // Song / match info
    public var totalLength:Float; // in seconds
    private var startTimestamp:Float;

    // Gameplay stats
    private var score:Int = 0;
    private var isPaused:Bool = false;
    private var isGameOver:Bool = false;

    public function new(mode:String, level:String, diff:String, length:Float = 120)
    {
        super();

        gameMode = mode;
        levelName = level;
        difficulty = diff;
        totalLength = length;

        addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):Void
    {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        startTimestamp = Date.now().getTime();

        updatePresence();

        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
        addEventListener(Event.ENTER_FRAME, update);
    }

    // ==========================
    // Core Update Loop
    // ==========================

    private function update(e:Event):Void
    {
        if (isPaused || isGameOver) return;

        // Simulate score increase
        score += 1;

        // Check if level ended
        if (getElapsedTime() >= totalLength)
        {
            endGame();
        }
    }

    // ==========================
    // Presence System
    // ==========================

    private function updatePresence():Void
    {
        var details:String;
        var state:String;

        if (isGameOver)
        {
            details = "Game Over";
            state = levelName + " • Score: " + score;
        }
        else if (isPaused)
        {
            details = "Paused";
            state = levelName + " • Score: " + score;
        }
        else
        {
            details = formatModeDetails();
            state = levelName + " [" + difficulty + "] • Score: " + score;
        }

        Discord.changePresence(details, state);
    }

    private function formatModeDetails():String
    {
        switch (gameMode.toLowerCase())
        {
            case "rhythm":
                return "Playing Rhythm Mode";

            case "story":
                return "Story Mode";

            case "freeplay":
                return "Freeplay";

            case "arcade":
                return "Arcade Mode";

            case "survival":
                return "Survival Mode";

            default:
                return "Playing " + gameMode;
        }
    }

    // ==========================
    // Controls
    // ==========================

    private function onKeyPress(e:KeyboardEvent):Void
    {
        switch (e.keyCode)
        {
            case Keyboard.P:
                togglePause();

            case Keyboard.R:
                triggerGameOver();

            case Keyboard.S:
                score += 100;
                updatePresence();
        }
    }

    private function togglePause():Void
    {
        if (isGameOver) return;

        isPaused = !isPaused;
        updatePresence();
    }

    private function triggerGameOver():Void
    {
        isGameOver = true;
        isPaused = false;
        updatePresence();
    }

    private function endGame():Void
    {
        removeEventListener(Event.ENTER_FRAME, update);
        Discord.changePresence("Level Complete!", levelName + " • Final Score: " + score);
    }

    // ==========================
    // Time Utilities
    // ==========================

    private function getElapsedTime():Float
    {
        return (Date.now().getTime() - startTimestamp) / 1000;
    }

    private function getRemainingTime():Float
    {
        return totalLength - getElapsedTime();
    }
}