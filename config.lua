---Variable to set function of the device
Device_type = "Clock:Season"

---Timer setting (in seconds) for time in between loop iterations
Main_timer = 10 -- seconds

--#region Networking IRL

---IPv4 address of the endpoint receiving data.
---This endpoint will route all packages to their
---location and/or database
Gateway_IPv4 = ""

---Default route for current Minecraft server
Gateway_route = "/Minecraft_server"

--#endregion

--#region Networking in server

---Channel for the main communication between deviced
Channel_network = 1

---Channel for GPS data communication
Channel_gps = 2

---Listen for a client to analyse its data thats been broadcasted
Listen_for_client = 29

--#endregion

--#region External inventories

---Side where a vault is located
Vault_side = "back"

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

--#endregion

--#region Old configs

hight = 15
useChests = true
chestSlot = 15

--#endregion