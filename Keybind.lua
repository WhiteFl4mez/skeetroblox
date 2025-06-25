local Keybind = {}
Keybind.__index = Keybind

function Keybind.new(tab, options)
    -- options: {text, y, callback}
    local UIS = game:GetService("UserInputService")
    local keybind = {key = nil}

    local keybindLabel = Instance.new("TextLabel")
    keybindLabel.Size = UDim2.new(1, -30, 0, 28)
    keybindLabel.Position = UDim2.new(0, 15, 0, options.y or 0)
    keybindLabel.BackgroundTransparency = 1
    keybindLabel.Text = (options.text or "Keybind") .. ": [None]"
    keybindLabel.Font = Enum.Font.Gotham
    keybindLabel.TextSize = 18
    keybindLabel.TextColor3 = Color3.fromRGB(200, 255, 255)
    keybindLabel.TextXAlignment = Enum.TextXAlignment.Left
    keybindLabel.Parent = tab._content

    local setKeybindBtn = Instance.new("TextButton")
    setKeybindBtn.Size = UDim2.new(1, -30, 0, 36)
    setKeybindBtn.Position = UDim2.new(0, 15, 0, (options.y or 0) + 28)
    setKeybindBtn.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
    setKeybindBtn.Text = "Set Keybind"
    setKeybindBtn.Font = Enum.Font.Gotham
    setKeybindBtn.TextSize = 18
    setKeybindBtn.TextColor3 = Color3.fromRGB(0,255,128)
    setKeybindBtn.BorderSizePixel = 0
    setKeybindBtn.AutoButtonColor = true
    setKeybindBtn.Parent = tab._content

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = setKeybindBtn

    local waitingForKeybind = false

    setKeybindBtn.MouseButton1Click:Connect(function()
        if waitingForKeybind then return end
        waitingForKeybind = true
        setKeybindBtn.Text = "Press any key..."
        keybindLabel.Text = (options.text or "Keybind") .. ": [Waiting...]"
        local connection
        connection = UIS.InputBegan:Connect(function(input, processed)
            if not processed and input.UserInputType == Enum.UserInputType.Keyboard then
                keybind.key = input.KeyCode
                keybindLabel.Text = (options.text or "Keybind") .. ": [" .. tostring(keybind.key.Name) .. "]"
                setKeybindBtn.Text = "Set Keybind"
                waitingForKeybind = false
                connection:Disconnect()
            end
        end)
    end)

    UIS.InputBegan:Connect(function(input, processed)
        if not processed and keybind.key and input.KeyCode == keybind.key then
            if options.callback then options.callback() end
        end
    end)

    return keybind
end

return Keybind