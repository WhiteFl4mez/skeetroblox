local Toggle = {}
Toggle.__index = Toggle

function Toggle.new(tab, options)
    -- options: {text, y, default, callback}
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -30, 0, 36)
    frame.Position = UDim2.new(0, 15, 0, options.y or 0)
    frame.BackgroundTransparency = 1
    frame.Parent = tab._content

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -50, 1, 0)
    lbl.Position = UDim2.new(0, 0, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = options.text or "Toggle"
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 18
    lbl.TextColor3 = Color3.fromRGB(200, 255, 255)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 36, 0, 20)
    toggle.Position = UDim2.new(1, -40, 0.5, -10)
    toggle.BackgroundColor3 = options.default and Color3.fromRGB(0,255,128) or Color3.fromRGB(40,40,48)
    toggle.Text = ""
    toggle.BorderSizePixel = 0
    toggle.AutoButtonColor = false
    toggle.Parent = frame

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggle

    local state = options.default or false
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.BackgroundColor3 = state and Color3.fromRGB(0,255,128) or Color3.fromRGB(40,40,48)
        if options.callback then options.callback(state) end
    end)
    return frame
end

return Toggle