net.Receive("Reports Choice", function()
    local attacker = net.ReadEntity()
    
    local fr = vgui.Create("XPFrame")
    fr:SetTitle("You got killed by " .. attacker:Name())
    fr:SetSize(300, 115)
    fr:Center()

    local rdm = vgui.Create("XPButton", fr)
    rdm:SetText("That was RDM")
    rdm:Dock(TOP)

    rdm.DoClick = function()
        net.Start("Reports Add")
            net.WriteEntity(attacker)
        net.SendToServer()
	fr:Remove()
    end

    local cancel = vgui.Create("XPButton", fr)
    cancel:SetText("Nah, it's ok")
    cancel:Dock(TOP)

    cancel.DoClick = function()
        fr:Remove()
    end
end)
