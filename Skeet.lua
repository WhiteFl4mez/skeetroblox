local Skeet = {}
Skeet.__index = Skeet

-- Load controls
local Controls = {}
Controls.Button = require(script.Parent.Button)
Controls.Slider = require(script.Parent.Slider)
Controls.Toggle = require(script.Parent.Toggle)
Controls.Label = require(script.Parent.Label)
Controls.Keybind = require(script.Parent.Keybind)

-- Window creation
function Skeet.newWindow(options)
    -- ...existing code for creating ScreenGui, MainFrame, Tabs, etc...
    -- Instead of hardcoding, store references and allow adding tabs/controls dynamically
    local self = setmetatable({}, Skeet)
    -- ...initialize self._gui, self._mainFrame, self._tabs, self._tabFrames, etc...
    -- ...store options like title, icon, size...
    -- ...setup tab switching logic...
    -- ...setup exploit-safe parenting...
    return self
end

function Skeet:addTab(tabName, tabIcon)
    -- ...create tab button and scrolling frame for content...
    -- ...return a Tab object (see below)...
end

-- Tab object
local Tab = {}
Tab.__index = Tab

function Tab:addButton(options)
    return Controls.Button.new(self, options)
end

function Tab:addSlider(options)
    return Controls.Slider.new(self, options)
end

function Tab:addToggle(options)
    return Controls.Toggle.new(self, options)
end

function Tab:addLabel(options)
    return Controls.Label.new(self, options)
end

function Tab:addKeybind(options)
    return Controls.Keybind.new(self, options)
end

Skeet.Tab = Tab

return Skeet