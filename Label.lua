local Label = {}
Label.__index = Label

function Label.new(tab, options)
    -- options: {text, y}
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -30, 0, 28)
    lbl.Position = UDim2.new(0, 15, 0, options.y or 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = options.text or "Label"
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 18
    lbl.TextColor3 = Color3.fromRGB(200, 255, 255)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = tab._content
    return lbl
end

return Label