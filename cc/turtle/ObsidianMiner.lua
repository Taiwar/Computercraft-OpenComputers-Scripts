--Intended to be put on a turtle, sitting level to obsidian blocks

success = 0
data = 0
turncycle = 0

-- Detects Block in front of the turtle and sets variables according to detection
function detectObs()
  if turtle.detect() then -- Is there actually a block in front
    success, data = turtle.inspect() -- Further information on block
    if success then
      if data.name == "minecraft:obsidian" then -- Mines obsidian if found and resets turncycle 
        print("found obsidian; mining...")
        turtle.dig()
        turncycle = 0 
      else -- Block detected, but no obsidian
        print("no obsidian in front")
        moveObs(true) 
      end  
    end
 else -- No block detected
    print("air in front")
    moveObs(false)
 end
end

function moveObs(param) -- Moves accordingly to what has been detected, how efficient these moving patterns are and if they always work - I have no idea, but they work reasonably well for now ;)
  if not param then  -- Air ahead
    if turncycle < 4 then -- Keeps track of times turned, so that it doesn't endlessly spin around
      print("Moving forwards")
      turtle.forward()
      turtle.turnRight()
      turncycle = turncycle + 1
      detectObs()
    else
      print("no obsidian around me")
      if not turtle.forward() then
        print("path blocked, turning")
        turtle.turnRight()
        detectObs()
      else
        print("successfully moved, searching obsidian...")
        turncycle = 0
        detectObs()
      end
    end      
  else -- Wrong block ahead
    print("turning Left")
    turtle.turnLeft()
    detectObs()
  end  
end

print("How much obsidian?")

loops = tonumber(read()) -- Requests player input for number of obsidianblocks to mine
for i = 1, loops do -- Main script loop
  print("loop: "..i)
  detectObs() 
end
print("Successfully mined " .. loops .. " obsidian") 
           
