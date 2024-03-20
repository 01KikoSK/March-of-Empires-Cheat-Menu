-- March of Empires Cheat Menu by Trongkim3

-- Array of resources to modify
-- Order must be the same as in the game
local resources = {
    'Gold',
    'Food',
    'Stone',
    'Iron',
}

-- Initialize cheat with the names of the resources
local cheat = CheatManager:newCheat('March of Empires Cheat', resources)

-- Function to modify the resources
function cheat:modifyResources(amount)
    for i, resource in ipairs(self.resources) do
        local address = findAddress(resource)
        if (address) then
            self:log('Found ' .. resource .. ' at ' .. address)
            writeMemory(address, amount)
        else
            self:log('Could not find ' .. resource)
        end
    end
end

-- Menu to modify the resources
function cheat:menu()
    if (self.active) then
        self:registerInt('Amount', 1, 999999, 99999)
        local amount = self:getValue('Amount')
        if (self:confirm('Set ' .. self.name .. ' to ' .. amount .. '?')) then
            self:modifyResources(amount)
            self:drawSuccessMessage('Successfully set ' .. self.name)
        end
        self.active = false
    else
        self:registerCheat(true)
        self:drawInfoMessage('Select an option to modify ' .. self.name)
        self:registerButton('Set', 'Amount', 'Set ' .. self.name)
    end
end