local o = require 'telem.lib.ObjectModel'
local t = require 'telem.lib.util'

local InputAdapter = o.class()
InputAdapter.type = 'InputAdapter'

function InputAdapter:constructor()
    assert(self.type ~= InputAdapter.type, 'InputAdapter cannot be instantiated')

    self.prefix = ''

    -- boot components
    self:setBoot(function ()
        self.components = {}
    end)()
end

function InputAdapter:setBoot(proc)
    assert(type(proc) == 'function', 'proc must be a function')

    self.boot = proc

    return self.boot
end

function InputAdapter:addComponentByPeripheralID (id)
    local tempComponent = peripheral.wrap(id)

    assert(tempComponent, 'Could not find peripheral ID ' .. id)

    self.components[id] = tempComponent
end

function InputAdapter:addComponentByPeripheralType (type)
    local key = type .. '_' .. #{self.components}

    local tempComponent = peripheral.find(type)

    assert(tempComponent, 'Could not find peripheral type ' .. type)

    self.components[key] = tempComponent
end

function InputAdapter:read ()
    self:boot()

    t.err(self.type .. ' has not implemented read()')
end

return InputAdapter