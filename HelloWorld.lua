-- Unit er wow for at få noget
local name = UnitName("Player")


SLASH_HELLO1 = '/helloworld'
SLASH_HELLO2 = '/hellow'

-- SLASH_BANK1 = '/banks'

SLASH_TESTER1 = '/test1'

local function tester(a, b)
    -- print("this was a test " .. a.. " " .. b)
    print(a)
    print(b)
    print(a, b)
end


-- local function Guild(numb)
--     -- local test = C_BattleNet.GetGuildBankItemInfo(2,1)
--     -- message(test)
--     -- message("did it happen?")

--     local tabID = 3 -- Replace with the desired guild bank tab ID
--     local slotID = numb -- Replace with the desired slot ID

--     local itemName, itemIcon, itemStackCount, itemLocked = GetGuildBankItemInfo(tabID, slotID)
--     local itemLink = GetGuildBankItemLink(3,numb)
--     if itemName then
--         local localizedItemName = GetItemInfo(itemName)
--         if localizedItemName then
--             print("Item Name:", localizedItemName)
--         else
--             print("Item Name:", itemName)
--         end
--         print("Item Icon:", itemIcon)
--         print("Item Stack Count:", itemStackCount)
--         print("Item Locked:", itemLocked)
--         print("Item itemLink:", itemLink)
--     else
--         print("Invalid guild bank item.")
--     end

-- end


local function Greeting(name)
    local greeting = "Hello " .. "player: " .. name .. "!"

    message(greeting)
end

-- /helloWorld
local function HelloWorldHandler(name)
    local userAddedName = string.len(name) > 0

    if (userAddedName) then
        Greeting(name)
    else
        local Playername = UnitName("Player")
        Greeting(Playername)
    end
end

SlashCmdList["HELLO"] = HelloWorldHandler
-- SlashCmdList["BANK"] = Guild
SlashCmdList["TESTER"] = tester

-- message("hello word! \n Claay skal hjælpe med at lave random addons ")
-- .. means compining the string
-- Hello player {Kercash}!
-- message("Hello " .. "player: " .. name .. "!")
