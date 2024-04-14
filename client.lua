

Citizen.CreateThread(function()
    for k,v in pairs(Config.Npcs) do 
        RequestModel(v.Skin)
        while not HasModelLoaded(v.Skin) do Citizen.Wait(8) end 
        ped = CreatePed(1, GetHashKey(v.Skin), v.Coords.x, v.Coords.y, v.Coords.z - 1, v.Heading, false, false)
        SetBlockingOfNonTemporaryEvents(ped, true) 
        FreezeEntityPosition(ped, true)
        SetPedSuffersCriticalHits(ped, false)
        SetEntityInvincible(ped, true)
    end
    while true do 
        Citizen.Wait(0)
        coords = GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(Config.Npcs) do 
            if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.Coords.x, v.Coords.y, v.Coords.z) < 2.48 then 
                Draw3DText(v.Coords.x, v.Coords.y, v.Coords.z + 1, v.Name)
                Draw3DText(v.Coords.x, v.Coords.y, v.Coords.z, Config.Talk)
                if IsControlJustPressed(0, 38) then 
                    local randomIndex = math.random(1, #v.RandomMessages)
                    local randomMessage = v.RandomMessages[randomIndex]
                    ShowSubtitle(randomMessage, 4800)
                end
            end
        end
    end
end)

function Draw3DText(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local p = GetGameplayCamCoords()
	local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
	local scale = (1 / distance) * 0.68
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov 
	if onScreen then
	SetTextScale(0.0, scale)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x, _y)
	end
end

function ShowSubtitle(message, duration)
    BeginTextCommandPrint('STRING')
    AddTextComponentString(message)
    EndTextCommandPrint(duration, true)
end