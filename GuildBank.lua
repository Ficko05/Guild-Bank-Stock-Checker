SLASH_BANK1 = '/banks'

SLASH_SCAN1 = '/scans'

SLASH_CHECK1 = '/check'

SLASH_TESTERS1 = '/tt'

local tabID = 3                        -- Replace with the desired guild bank tab ID
local MAX_GUILDBANK_SLOTS_PER_TAB = 98 -- Replace with the correct guild bank slots


local function GetItemNameFromItemLink(itemLink)
    local itemName = itemLink:match("%|h%[(.-)%]|h")
    return itemName
end


local function getStock(itemKey, tablename)
    if tablename[itemKey] then
        return tablename[itemKey]
    else
        print("nothing: ", itemKey)
        return 0 -- Return 0 if the item key is not found in the table
    end
end

local function getStockTemp(itemKey, tempItemsTable)
    if tempItemsTable[itemKey] then
        return tempItemsTable[itemKey]
    else
        print("nothing 2")
        return 0 -- Return 0 if the item key is not found in the table
    end
end

local function ModifyTempStock(itemKey, newStock, tempItemsTable)
    tempItemsTable[itemKey] = newStock
end


local function getItemNameFromID(itemID)
    local itemName = GetItemInfo(itemID)
    -- print(itemName)
    return itemName
end

local function GetItemLinkFromGuildIDSlot(SlotID)
    local itemLink = GetGuildBankItemLink(tabID, SlotID)
    if itemLink then
        return itemLink
    end
end
-- gets itemID from ItemLink
local function GetItemIDFromItemLink(itemLink)
    local itemId = tonumber(itemLink:match("item:(%d+)"))
    -- print(itemId)
    return itemId
end


local function CheckStockNeeded()
    -- local val = GetItemNameFromItemLink(GetItemLinkFromGuildIDSlot(1))
    -- print(val)

    -- table.wipe(tempTable)
    

    local tempTable = ItemsTable
    -- local tempTable = {}



    for slotID = 1, MAX_GUILDBANK_SLOTS_PER_TAB do
        local itemLink = GetGuildBankItemLink(tabID, slotID)

        -- dont delete itemStackCount, will not work without it
        local itemStackCount, itemCount = GetGuildBankItemInfo(tabID, slotID)

        if itemLink then
            -- local linkName = GetItemNameFromItemLink(itemLink)

            local ItemID = GetItemIDFromItemLink(itemLink)
            local ItemName = getItemNameFromID(ItemID)

            -- gets stock value from key "itemName"
            local StockFromTable = getStock(ItemName, ItemsTable)

            -- gets Tempstock value from key "itemName"
            -- local StockFromTempTable = getStockTemp(ItemName, tempTable)

            local NewStockValue = StockFromTable - itemCount

            ModifyTempStock(ItemName, NewStockValue, tempTable)

            -- Checking values in development
            -- local StockFromTempTable = getStockTemp(ItemName, tempTable)
            -- print("name: ", ItemName, " StockFromTempTable: ", StockFromTempTable)
        end
    end


    for itemNames, quantity in pairs(tempTable) do
        if quantity >= 0 then
            for slotID = 1, MAX_GUILDBANK_SLOTS_PER_TAB do
                local itemLink = GetGuildBankItemLink(tabID, slotID)
                if itemLink then
                    local itemName, itemLink = GetItemInfo(itemLink)
                    local currentItemName = itemName
                    if currentItemName == itemNames then
                        print("Buy:", itemLink, "Quantity:", quantity)
                        break
                    end
                end
            end
        end
    end

    print("----------------------------------------------")
    -- local tempTable = ItemsTable
    -- wipe(tempTable)
end



SlashCmdList["CHECK"] = CheckStockNeeded

-- Everything below here was just for testing and pretesting
-- --------------------------




-- local function Testers()
--     local testers1 = ItemsTable
--     print("Items in ItemsTable:")

--     for itemName, stockQuantity in pairs(ItemsTable) do
--         print("Item Name:", itemName, "Stock Quantity:", stockQuantity)
--     end
-- end



-- gets info of the tab
local function TabInfo(tabID)
    local tabName, _, tabIcon = GetGuildBankTabInfo(tabID)
    print("----------------------------------")
    print("Guild Bank Tab:", tabID)
    print("Tab Name:", tabName)
    print("Tab Icon:", tabIcon)
    print("----------------------------------")
end


local function IterateOverTabSlots()
    for slotID = 1, MAX_GUILDBANK_SLOTS_PER_TAB do
        local itemLink = GetGuildBankItemLink(tabID, slotID)
        local itemStackCount, itemCount = GetGuildBankItemInfo(tabID, slotID)
        if itemLink then
            print("Slot:", slotID)
            -- print("Item Stack Count:", itemStackCount)
            -- print("Item Quantity:", itemQuantity)
            print("Item itemLink:", itemLink)
            -- print("Item Icon:", itemIcon)
            print("Item itemCount:", itemCount)
            print("----------------")
        end
    end
end

-- shoulds return info of a spesific item in a tab
local function Guild(numb)
    local slotID = numb -- Replace with the desired slot ID

    TabInfo(tabID)

    local itemName, itemIcon, itemStackCount, itemLocked, itemCount = GetGuildBankItemInfo(tabID, slotID)
    local itemLink = GetGuildBankItemLink(tabID, numb)

    if itemName then
        -- local localizedItemName = GetItemInfo(itemName)
        -- if localizedItemName then
        --     print("Item Name:", localizedItemName)
        -- else
        --     print("Item Name:", itemName)
        -- end


        -- print("----------------------------------")
        -- print("Item Name:", itemName)
        -- print("Item Icon:", itemIcon)
        -- print("Item Stack Count:", itemStackCount)
        -- print("Item Locked:", itemLocked)
        print("Item itemLink:", itemLink)
        print("Item itemCount:", itemCount)
        print("----------------------------------")
    else
        print("Invalid guild bank item.")
    end
end


SlashCmdList["BANK"] = Guild
SlashCmdList["SCAN"] = IterateOverTabSlots
-- SlashCmdList["TESTERS"] = Testers
