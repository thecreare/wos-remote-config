# Waste of Space - Remote Config

Whitelist and other information for things in the hit game "Waste of Space"

## How to query

Using `query.luau`

```lua
local Modem = GetPart("Modem")
local Disk = GetPart("Disk")
local Query = require("query.luau")(Modem, Disk)

local whitelist = Query("amoungus/whitelist.json")
-- Should print creare's id
print(whitelist[1]["id"])
```

## Whitelist/Blacklist Format

Whitelist/blacklist files are lists of objects containing a userid `id` and other information

```json
{
    "id": 00000,
    "display": "cool person",
}
```
