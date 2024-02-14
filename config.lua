---Variable to set function of the device
Device_type = "Turtle:Mining"

---Timer setting (in seconds) for time in between loop iterations
Main_timer = 10 -- seconds

---IPv4 address of the endpoint receiving data.
---This endpoint will route all packages to their
---location and/or database
Gateway_IPv4 = ""

---Default route for current Minecraft server
Gateway_route = "/Minecraft_server"

---Channel for the main communication between deviced
Channel_network = 1

---Channel for GPS data communication
Channel_gps = 2

---Listen for a client to analyse its data thats been broadcasted
Listen_for_client = 29

---Side where a vault is located
Vault_side = "back"

---Side where a speedcontroller is located
Speedcontroller_side = "front"

---Side to output a signal for when a vault has reached its high level
Overflow_redstone_side = "front"

---Side where a tank is located
Tank_side = "back"

---Ammount of fluid (in Mili buckets) the fluid tank can store
---This is currently not detectable
Tank_max_level = 792000

---Level above which the inventory/tank is considerd full
Hysteresis_high = 0.9

---Level below which the inventory/tank is considerd empty
Hysteresis_low  = 0.6

---Side to output a signal to (de)activate a valve
Valve_signal_side = "bottom"

---Default output level on startup
Valve_signal_default = true

---Slot for combustable items to be used as fuel
Fuel_slot = 16

---Hight of tunnels mined my the turtle
Tunnel_hight = 28

---Width of the tunnel, currently supported: 3 and 4
Tunnel_width = 4

---Turtle will attempt to clear fluids during operation
Clear_fluids = true

---If set to true, the turtle will place a path below itself
Place_base_block = true

---Mode on how a light block has to be placed. Valid options are:
--- "None" - No light sources will be placed
--- "Torch" - will place light source behind itself
--- "Glowstone" - will place the light source below itself
Light_block_type = "None"

---Distance between two light source blocks to be placed by turtle
Light_block_interval = 5

Light_slot = 14

---Mode to use chests and which type. Valid option are:
--- "None"
--- "Ender chest"
Chest_dump_type = "Ender chest"

---Slot for chests to store mined items.
Chest_slot = 15
