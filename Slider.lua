local Slider = {}
Slider.__index = Slider

local function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function Slider.new(tab, options)
    -- options: {text, min, max, default, y, callback}
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -30, 0, 28)
    lbl.Position = UDim2.new(0, 15, 0, options.y or 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = (options.text or "Slider") .. ": " .. tostring(options.default or 0)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 18
    lbl.TextColor3 = Color3.fromRGB(200, 255, 255)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = tab._content

    local sliderBG = Instance.new("Frame")
    sliderBG.Size = UDim2.new(1, -30, 0, 12)
    sliderBG.Position = UDim2.new(0, 15, 0, (options.y or 0) + 32)
    sliderBG.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
    sliderBG.BorderSizePixel = 0
    sliderBG.Parent = tab._content

    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 6)
    sliderCorner.Parent = sliderBG

    local min, max, default = options.min or 0, options.max or 100, options.default or 0

    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    sliderBar.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
    sliderBar.BorderSizePixel = 0
    sliderBar.Parent = sliderBG

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 6)
    barCorner.Parent = sliderBar

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 20, 0, 20)
    knob.Position = UDim2.new((default-min)/(max-min), -10, 0.5, -10)
    knob.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
    knob.BorderSizePixel = 0
    knob.Parent = sliderBG
    knob.ZIndex = 2

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    local dragging = false

    local function setSlider(rel)
        rel = math.clamp(rel, 0, 1)
        local value = round(min + (max-min)*rel, 1)
        sliderBar.Size = UDim2.new(rel, 0, 1, 0)
        knob.Position = UDim2.new(rel, -10, 0.5, -10)
        lbl.Text = (options.text or "Slider") .. ": " .. tostring(value)
        if options.callback then options.callback(value) end
    end

    local UIS = game:GetService("UserInputService")

    local function beginDrag(input)
        dragging = true
        local function update(input)
            local rel = (input.Position.X - sliderBG.AbsolutePosition.X) / sliderBG.AbsoluteSize.X
            setSlider(rel)
        end
        local moveConn, upConn
        moveConn = UIS.InputChanged:Connect(function(moveInput)
            if dragging and moveInput.UserInputType == Enum.UserInputType.MouseMovement then
                update(moveInput)
            end
        end)
        upConn = UIS.InputEnded:Connect(function(endInput)
            if endInput.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
                moveConn:Disconnect()
                upConn:Disconnect()
            end
        end)
    end

    sliderBG.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            beginDrag(input)
            local rel = (input.Position.X - sliderBG.AbsolutePosition.X) / sliderBG.AbsoluteSize.X
            setSlider(rel)
        end
    end)
    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            beginDrag(input)
        end
    end)

    return {label = lbl, slider = sliderBG}
end

return Slider