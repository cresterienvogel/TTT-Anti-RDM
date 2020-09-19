util.AddNetworkString("Reports Choice")
util.AddNetworkString("Reports Add")
util.AddNetworkString("Reports Menu")

function Reports.Confirm(attacker, victim)
	if not victim.CanReport then
		return
	end

	if XPA then
		if attacker.AmountToPunish >= 6 then
			XPA.Ban(attacker, 1440, "RDM x6")
			return
		end
	end

	victim.RoundsToPass = 3
	victim.CanReport = false
	attacker.AmountToPunish = attacker.AmountToPunish + 1
	attacker:ChatPrint(victim:Name() .. " decided that your kill was RDM")
end

net.Receive("Reports Add", function(_, pl)
	local attacker = net.ReadEntity()
	if not IsValid(attacker) or pl.KilledBy ~= attacker then
		return
	end
	Reports.Confirm(attacker, pl)
end)

hook.Add("PlayerDeath", "Reports", function(victim, _, attacker)
	if not IsValid(attacker) or not attacker:IsPlayer() or attacker:IsTraitor() or victim == attacker then
		return
	end
	
	if not victim.CanReport then
		return
	end
	
	if GetRoundState() == ROUND_POST then
		return
	end

	victim.KilledBy = attacker
	net.Start("Reports Choice")
		net.WriteEntity(attacker)
	net.Send(victim)
end)

hook.Add("PlayerInitialSpawn", "Reports", function(pl)
	pl.AmountToPunish = 0
	pl.RoundsToPass = 0
	pl.CanReport = true
end)

hook.Add("TTTBeginRound", "Reports", function()
	for _, pl in pairs(player.GetAll()) do
		pl.KilledBy = pl

		if pl.RoundsToPass > 0 then
			pl.CanReport = false
			pl.RoundsToPass = pl.RoundsToPass - 1
		else
			pl.CanReport = true
		end

		if pl.AmountToPunish > 0 then
			pl:Kill()
			pl.AmountToPunish = pl.AmountToPunish - 1
		end
	end
end)
