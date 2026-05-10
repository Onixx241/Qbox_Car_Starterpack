# Qbox Car Starterpack

A simple, customizable resource for Qbox on FiveM, providing server owners with an NPC that gives out vehicles to players. Easily configure the type of car and the PED model through server convars.

## Features

- **NPC Giveaway:** Adds an interactive NPC to your Qbox server that distributes vehicles to players.
- **Simple Integration:** Drop-in ready for your FiveM server.

## Installation

1. **Download the resource:**
   - Clone the repo or download the ZIP and place the folder in your server’s `resources` directory.

2. **Add to your server.cfg:**
   ```bash
   ensure Qbox-Car-Starterpack
   ```

3. **Configure the resource via convars in your server.cfg:**
   ```bash
   set car_model "adder"        # Replace with the vehicle you want to give (e.g., "sultan", "zentorno")
   set ped_model "a_m_m_skater_01"  # Replace with the desired PED model
   ```
4. **Add Sql table to database:**
   - Run Mysql.sql on your database file to create necessary table for the resource
   
## Usage

- The configured NPC will spawn in the designated location.
- Players can interact with the NPC to receive the specified vehicle.
- Adjust `car_model` and `ped_model` convars at any time to update the NPC's behavior.
- Edit the vector4 in client.lua with the location and heading you want to put the npc at.
## Example Configuration

```
setr starter_given_vehicle "sultan"
setr starter_npc_model "a_m_m_eastsa_01"
```
