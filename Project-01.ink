/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/

VAR sister_name = ""
VAR torches = 0
VAR sword = 0
VAR health = 100

-> memory

== memory ==
Hiking in the woods around your house one day you stumble across the entrance to a cave. You wonder if you should call your sister over to explore it with you. What is her name?

* [Cindy]
    ~ sister_name = "Cindy" 
    -> outside_cave
* [Stephanie]
    ~ sister_name = "Stephanie"
    -> outside_cave
* [Maggie]
    ~ sister_name = "Maggie"
    -> outside_cave
    
    == outside_cave ==
    You decide it's best if you go in and take a look by yourself first.
    * [Explore the cave] -> cave_mouth

== cave_mouth ==
You are at the enterance to a cave. {not torch_pickup:There is a torch on the floor.} The cave extends to the east and west.


You have {torches} torches

+ [Take the east tunnel] -> east_tunnel
+ [Take the west tunnel] -> west_tunnel
* [Pick up the torch] -> torch_pickup


== east_tunnel ==
You are in the east tunnel. It is very dark, you can't see anything.
*  {torches > 0} [Light Torch] -> east_tunnel_lit
+ [Go Back] -> cave_mouth
-> END

== west_tunnel==
You are in the west tunnel. You hear a strange sound but can't see what is making it
* {torches > 0} [Light Torch] -> west_tunnel_lit
+ [Run in fear] -> cave_mouth
->END

== west_tunnel_lit ==
You use your torch to light the tunnel and realize that this section of the cave is an old mining tunnel. There are wooden supports around you and some old, strangely marked barrels in the corner. You look for the strange sound only to see a large snake staring right back at you.
{sister_name == "Maggie": It's a good thing you didn't bring Maggie, she is terrified of snakes.| }
* {torches > 0} [Throw Torch] -> mad_snake
* [Try to fight it] -> snake_bite
* [Turn tail and run] -> cave_mouth

== mad_snake ==
 You throw the torch to no effect but just as you are about to run you see a brilliant light. The torch caughgt one of the wooden supports on fire and the flames are slowly growing in size. As they slowly creep toward you you recognize the danger signs on the barrel. It is TNT.
~ torches = 0 
* [Run for your life] -> On_fire
* [Get down and crawl under the smoke] -> Down_under
* [Stay and die] -> Dumb_death
-> END

== On_fire ==
You make a mad dash for the exit but right before you reach it a flaming beam lands on you and you catch on fire.
~ health = health - 33
* ->Death_crispy

== Death_crispy ==
The fire slowly cooks your to a medium well death.
->END

== Down_under ==
You slowly crawl to the cave exit but right as you make it, you come face to face with the snake. You lock eyes for what seems like an eternity but it quickly slithers away. You breathe a sigh of relief before getting up and running back to the cave mouth.
-> cave_mouth2

== cave_mouth2 ==
You have lost your torch and the thrill of exploration. You return home before you get yourself seriously hurt.
->END 

== Dumb_death ==
You lost your will to live and decided just to give up and accept your fate. You died an agonizing death being cooked to meduim well by the flames.
->END
=== torch_pickup ===
~ torches = torches + 1
You now have a torch. May it light the way.
* [Go Back] -> cave_mouth
-> END

== snake_bite ==

{sword == 1: You use the sword to slay the snake -> cave_mouth}


What were you thinking? You are bitten by the snake before you even have the chance to attack and die a slow, agonizing death.
->END

=== east_tunnel_lit ===
The light of your torch glints off of the thousands of coins in the room.
* [Stuff as many coins as you can hold into your pockets] -> gold_pickup
+ [Return to cave mouth] -> cave_mouth_poor
-> END

=== gold_pickup ===
You see a small opening on the other side of the tunnel but sas you step toward it the room begins to shake and boulders start crashing down around you. 
* [Stand awestruck] -> boulder_death
* [Run for your life] -> cave_mouth_rich
* [Dive into the opening] -> cave_opening 
-> END

== cave_opening== 
You dive into the small opening and find yourself in a cramped cavern. The sound of rumbling and crashing debris slowly stops in the tunnel. You use your torch to light the small and see a gleaming sword mounted on the far wall. You also notice that you are bleeding from your side.
~ health = health - 10
* [Take the sword] -> sword_pickup
* [Return to the cave mouth] -> cave_mouth

== sword_pickup ==
~ sword = sword + 1
You now have a sword to protect you from the horrors of the cave. As you are about to leave you notice a small chalice sitting on an altar in a dark corner of the cavern. It appears to be filled with water. 
* [Take a drink] -> chalice 
* [Go Back] -> cave_mouth

== chalice ==
You go up and take a drink of the mysterious liquid and notice that your wound has closed. You also feel stronger for some reason, how strange.
{health < 100: {health + 50}}
You have {health} health
* [Return to cave mouth] -> cave_mouth

== boulder_death ==
You were crushed by the falling boulders and died young and poor.
-> END

=== cave_mouth_rich ===
Congratulations, you survived the tunnel collapse and are now richer than when you entered.
-> END

== cave_mouth_poor ==
You were to scared to risk taking any gold from the cave and walk home sad and poor.
-> END