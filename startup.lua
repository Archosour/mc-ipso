os.loadAPI("brave.lua")
--os.loadAPI("config.lua")

--{ varables }--
local input = {...}
local x = 0
local logs = 1
local saps = 2
local ready = false
local mined = 0
--local rest = {[1] = 9, [2] = 16}

function refuel()
	turtle.select(1)
	while turtle.getFuelLevel() < 50 do
		turtle.refuel(1)
	end
	turtle.select(1)
end

--{ setup }--
wireless, side = brave.findModem(true)
if wireless then
	modem = peripheral.wrap(side)
end
modem.open(1)


refuel()
while turtle.down() do
end
turtle.up()


while true do
	turtle.select(saps)
	turtle.place()
	while ready == false do
		local n,m = turtle.inspect()
		if m["name"] ~= "minecraft:sapling" then
			ready = true
		end
	end
	ready = false
	refuel()
	for x = 1,7,1 do
		if turtle.dig() then
			mined = mined + 1
		end
		if turtle.digUp() then
			mined = mined + 1
		end
		turtle.up()
	end
	while turtle.down() do
	end
	turtle.select(logs)
	items = turtle.getItemCount()
	if items > 40 then
		turtle.dropDown(items - 32)
	end
	turtle.select(saps)
	items = turtle.getItemCount()
	if items > 40 then
		turtle.dropDown(items - 32)
	end
	turtle.up()
	turtle.select(3)
	turtle.dropDown()
	table = {[1]=mined,[2]=true,[3]="blocksMined"}
	modem.transmit(1,1, brave.sendInfo(3, table))
	mined = 0
end


