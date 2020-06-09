--// Made by: Scion Spy
--// Made For: Bejebajay
--// Version: 1.4.0

--// Description:
-- --// Entering a Stations NFZ will print a local message to the user. -- Also posts on "Exit_Station"
-- --// Leaving the NFZ will also print a local message to the user.

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

--// ToDo:
-- --// Add a warning when [user] fires weapons within NFZ
-- --// Add a "Saftey" mech.

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

--// Let's define our argments.
NFZ = NFZ or {};

local NFZ_Running = true  -- --// Well, we want the Sys to be running!!
local NFZ_Saftey = true-- -- --// Saftey's start engaged.
local docked = false-- -- -- --// We're assuming we logged out in space.
local inNFZ = false -- -- -- --// We're assuming we logged out outside the NFZ.

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

--// Contents
-- --// Events
-- -- --// ENTER_ZONE_dock
-- -- --// ENTERED_STATION
-- -- --// LEAVING_STATION
-- -- --// ENTER_ZONE_NFZ
-- -- --// LEAVE_Zone_NFZ
-- --// Commands
-- -- --// NFZ_Toggle

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


function NFZ:OnEvent(event, data)
    if NFZ_Running == false then return end

    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

    if event == "ENTER_ZONE_dock" then
        docked = true
    end

    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

    if event == "ENTERED_STATION" then
        docked = true
    end

    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

    if event == "LEAVING_STATION" then
        docked = false
    end

    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

    if event == "ENTER_ZONE_NFZ" then
        if inNFZ == true then return end --// Prevents "turret Spam"
        inNFZ = true

        print("\127ff8000** \127ffb3baYou've entered an NFZ -- Shooting other players within the NFZ may lead to the Stations Defenses aiding your target!!")

        if NFZ_Saftey == true then
            --// Select weapons group 0;
        end;
    end

    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

    if event == "LEAVE_ZONE_NFZ" then
        if docked == false then
            if inNFZ == false then return end --// Prevents "turret Spam"
            inNFZ = false
            print("\127ff8000** \127ffb3baYou have left the NFZ -- Players may attack you without the stations Defenses aiding you!!")
        end

        if NFZ_Saftey == true then
            --// Select weapons group 1;
        end;
    end

    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

    if event == "WEAPON_GROUP_CHANGED" then

        if inNFZ == true then
            if NFZ_Saftey == true then
                --// Select weapons group 0;
            end;
        end;

    end

end


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


function NFZ_Help()
    print("\127ffb3batoggle.nfz - Toggles on/off the NFZ Warnings.");
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function NFZ_Toggle()

    if NFZ_Running == true then
        NFZ_Running = false print("\127ff8000** \127ffffffNFZ Warning disabled. || The NFZ Warning System re-enable on logout.");
    else NFZ_Running = true print("\127ff8000** \127ffffffNFZ Warning enabled.");
    end;

end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function NFZ_Saftey()

    if NFZ_Saftey == true then
        NFZ_Saftey = false; print("\127ff0000Warning: \127ffffffNFZ Saftey's have been released!!");
    else NFZ_Saftey = true; print("\127ffffffNFZ Saftey's Engaged."); end;

end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


--// NFZ Event.
RegisterEvent(NFZ, "ENTERED_STATION");
RegisterEvent(NFZ, "LEAVING_STATION");
RegisterEvent(NFZ, "ENTER_ZONE_NFZ");
RegisterEvent(NFZ, "LEAVE_ZONE_NFZ");


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

--// NFZ Commands.
RegisterUserCommand("help.nfz", NFZ_Help);
RegisterUserCommand("toggle.nfz", NFZ_Toggle);
--//RegisterUserCommand("nfzsaftey", NFZ_Saftey);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
