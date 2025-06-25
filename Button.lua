local Button = {}
Button.__index = Button

function Button.new(tab, options)
    -- options: {text, y, callback}
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -30, 0, 36)
    btn.Position = UDim2.new(0, 15, 0, options.y or 0)
    btn.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
    btn.Text = options.text or "Button"
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 18
    btn.TextColor3 = Color3.fromRGB(0,255,128)
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = true
    btn.Parent = tab._content

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    if options.callback then
        btn.MouseButton1Click:Connect(options.callback)
    end

    return btn
end

return Button