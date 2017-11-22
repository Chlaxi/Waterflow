This was the exam assignment for the Scientific Computing course at Roskilde University.

I tried to make a simulation of how water flows and fills up a space, using cellular automata.
The grey tiles are slowly filled with water, which is represented by them getting a blueish colour. The intensity of the colour increases, based on how much water there is on the tile.
Each tile will slowly gain water from adjecent tiles with more water in them, and send it to an adjecent tile, which has less water in it. This way the water will eventually spread across the map and even out.

---Controls---
Right click: Create a full tile of water. If clicked on a water tile, the tile switches between infinite (imagine waterfalls) or limited supply.

Left click: Adds terrain. The water will avoid these tiles and go around it.

W/S: Decrease/increase the amount of water, which is sent to other tiles at a time (slow down/speed up feature) NOTE: Sometimes the water won't spread, if the value is too high.

Space: Start/pause the simulation.

D: Debugmode. Allows you to see the values of the water tiles

R: Resets the map (doesn't pause it).

---Note---
The report is also included, with more detail information.
Made using Processing.