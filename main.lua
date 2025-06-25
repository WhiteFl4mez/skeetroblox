local Skeet = require(script.Parent.Skeet)

-- Create a window
local window = Skeet.newWindow({
    title = "Skeet Demo",
    icon = "rbxassetid://7733960981",
    size = UDim2.new(0, 600, 0, 420)
})

-- Add a tab
local mainTab = window:addTab("Main", "rbxassetid://7734053494")

-- Add controls to the tab
mainTab:addLabel({text = "Welcome to Skeet!", y = 0})
mainTab:addButton({
    text = "Click Me",
    y = 40,
    callback = function()
        print("Button clicked!")
    end
})
mainTab:addSlider({
    text = "Volume",
    min = 0,
    max = 100,
    default = 50,
    y = 90,
    callback = function(val)
        print("Slider value:", val)
    end
})
mainTab:addToggle({
    text = "Enable Feature",
    y = 150,
    default = false,
    callback = function(state)
        print("Toggle state:", state)
    end
})
mainTab:addKeybind({
    text = "Test Keybind",
    y = 200,
    callback = function()
        print("Keybind pressed!")
    end
})
