package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import discord.Discord;

class PlayState extends Sprite
{
    private var songName:String;
    private var difficulty:String;
    private var isPaused:Bool = false;
    private var isGameOver:Bool = false;

    public function new(song:String, diff:String)
    {
        super();
        songName = song;
        difficulty = diff;

        addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):Void
    {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        // Set presence when song starts
        updatePresence();

        // Keyboard listener for pause simulation
        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
    }

    private function updatePresence():Void
    {
        if (isGameOver)
        {
            Discord.changePresence("Game Over", songName + " [" + difficulty + "]");
        }
        else if (isPaused)
        {
            Discord.changePresence("Paused", songName + " [" + difficulty + "]");
        }
        else
        {
            Discord.changePresence("Playing: " + songName, "Difficulty: " + difficulty);
        }
    }

    private function onKeyPress(e:KeyboardEvent):Void
    {
        switch (e.keyCode)
        {
            case Keyboard.P:
                togglePause();

            case Keyboard.R:
                triggerGameOver();
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

    public function endSong():Void
    {
        Discord.changePresence("Song Complete!", songName + " [" + difficulty + "]");
    }
}