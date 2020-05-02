--Copyright ZAUB1
--N'hesitez pas a rejoindre mon discord : https://discord.gg/yFuSEGj
--Et a me contacter directement pour tout bug ou suggestions

--ESX INIT--

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
end)

local nbPizza = 0
--CONFIGURATION--

local pizzeria = { x = -1285.73, y = -1387.15, z = 3.44 } --Configuration marker prise de service
local pizzeriafin = { x = -1282.740, y = -1386.488, z = 3.44 } --Configuration marker fin de service
local spawnfaggio = { x = -1278.39, y = -1386.84, z = 3.38 } --Configuration du point de spawn du faggio

local livpt = { --Configuration des points de livraisons (repris ceux de Maykellll1 / NetOut)
    [1] = { name = "Vinewood Hills", x = -1220.50, y = 666.95, z = 143.10 },
    [2] = { name = "Vinewood Hills", x = -1338.97, y = 606.31, z = 133.37 },
    [3] = { name = "Rockford Hills", x = -1051.85, y = 431.66, z = 76.06 },
    [4] = { name = "Rockford Hills", x = -904.04, y = 191.49, z = 68.44 },
    [5] = { name = "Rockford Hills", x = -21.58, y = -23.70, z = 72.24 },
    [6] = { name = "Hawick", x = -904.04, y = 191.49, z = 68.44 },
    [7] = { name = "Alta", x = 225.39, y = -283.63, z = 28.25 },
    [8] = { name = "Pillbox Hills", x = 5.62, y = -707.72, z = 44.97 },
    [9] = { name = "Mission Row", x = 284.50, y = -938.50, z = 28.35 },
    [10] = { name = "Rancho", x = 411.59, y = -1487.54, z = 29.14 },
    [11] = { name = "Davis", x = 85.19, y = -1958.18, z = 20.12 },
    [12] = { name = "Chamberlain Hills", x = -213.00, y = -1617.35, z = 37.35 },
    [13] = { name = "La Puerta", x = -1015.65, y = -1515.05, z = 5.51 },
    [14] = { name = _U('client'), x = -1004.788, y = -1154.824, z = 1.64603 },
    [15] = { name = _U('client'), x = -1113.937, y = -1193.136, z = 1.827304 },
    [16] = { name = _U('client'), x = -1075.903, y = -1026.452, z = 4.031562 },
    [17] = { name = _U('client'), x = -1056.485, y = -1001.234, z = 1.639098 },
    [18] = { name = _U('client'), x = -1090.886, y = -926.188, z = 2.630009 },
    [19] = { name = _U('client'), x = -1075.903, y = -1026.452, z = 4.031562 },
    [20] = { name = _U('client'), x = -1181.652, y = -988.6455, z = 1.634243 },
    [21] = { name = _U('client'), x = -1151.11, y = -990.905, z = 1.638789 },
    [22] = { name = _U('client'), x = -1022.788, y = -896.3149, z = 4.908271 },
    [23] = { name = _U('client'), x = -1060.738, y = -826.829, z = 18.69866 },
    [24] = { name = _U('client'), x = -968.6487, y = -1329.453, z = 5.144861 },
    [25] = { name = _U('client'), x = -1185.5, y = -1386.238, z = 4.112149 },
    [26] = { name = _U('client'), x = -1132.848, y = -1456.029, z = 4.372081 },
    [27] = { name = _U('client'), x = -1125.602, y = -1544.203, z = 5.391256 },
    [28] = { name = _U('client'), x = -1084.74, y = -1558.709, z = 4.10145 },
    [29] = { name = _U('client'), x = -1098.367, y = -1679.272, z = 3.853804 },
    [30] = { name = _U('client'), x = -1155.863, y = -1574.202, z = 8.344403 },
    [31] = { name = _U('client'), x = -1122.675, y = -1557.524, z = 5.277201 },
    [32] = { name = _U('client'), x = -1108.679, y = -1527.393, z = 6.265457 },
    [33] = { name = _U('client'), x = -1273.549, y = -1382.664, z = 3.81341 },
    [34] = { name = _U('client'), x = -1342.454, y = -1234.849, z = 5.420023 },
    [35] = { name = _U('client'), x = -1351.21, y = -1128.669, z = 3.626104 },
    [36] = { name = _U('client'), x = -1343.232, y = -1043.639, z = 7.303696 },
    [37] = { name = _U('client'), x = -729.2556, y = -880.1547, z = 22.22747 },
    [38] = { name = _U('client'), x = -831.3006, y = -864.8558, z = 20.22383 },
    [39] = { name = _U('client'), x = -810.4093, y = -978.4364, z = 13.74061 },
    [40] = { name = _U('client'), x = -683.8874, y = -876.8568, z = 24.02004 },
    [41] = { name = _U('client'), x = -1031.316, y = -903.0217, z = 3.692086 },
    [42] = { name = _U('client'), x = -1262.703, y = -1123.342, z = 7.092357 },
    [43] = { name = _U('client'), x = -1225.079, y = -1208.524, z = 7.619214 },
    [44] = { name = _U('client'), x = -1207.095, y = -1263.851, z = 6.378308 },
    [45] = { name = _U('client'), x = -1086.787, y = -1278.122, z = 5.09411 },
    [46] = { name = _U('client'), x = -886.1298, y = -1232.698, z = 5.006698 },
    [47] = { name = _U('client'), x = -753.5927, y = -1512.016, z = 4.370816 },
    [48] = { name = _U('client'), x = -696.3545, y = -1386.89, z = 4.846177 }
}

local blips = {
    { title = _U('pizza_shop'), colour = 51, id = 267, x = -1285.73, y = -1387.15, z = 3.44 }, --Configuration du point sur la carte
}

local coefflouze = 0.1 --Coeficient multiplicateur qui en fonction de la distance definit la paie

--INIT--

local isInJobPizz = false
local livr = 0
local plateab = "POPJOBS"
local isToHouse = false
local isToPizzaria = false
local paie = 0

local pourboire = 0
local posibilidad = 0
local px = 0
local py = 0
local pz = 0

--THREADS--

Citizen.CreateThread(function()
    --Thread d'ajout du point de la pizzeria sur la carte

    for _, info in pairs(blips) do

        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 1.0)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end

end)

Citizen.CreateThread(function()
    --Thread lancement + livraison depuis le marker vert
    while true do

        Citizen.Wait(0)

        if isInJobPizz == false then

            DrawMarker(1, pizzeria.x, pizzeria.y, pizzeria.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001, 0, 255, 0, 200, 0, 0, 0, 0)

            if GetDistanceBetweenCoords(pizzeria.x, pizzeria.y, pizzeria.z, GetEntityCoords(GetPlayerPed(-1), true)) < 1.5 then
                HelpText(_U('help_text'), 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)

                if IsControlJustPressed(1, 38) then
                    notif = true
                    isInJobPizz = true
                    isToHouse = true
                    livr = math.random(1, 48)

                    px = livpt[livr].x
                    py = livpt[livr].y
                    pz = livpt[livr].z
                    distance = round(GetDistanceBetweenCoords(pizzeria.x, pizzeria.y, pizzeria.z, px, py, pz))
                    paie = distance * coefflouze

                    spawn_faggio()
                    goliv(livpt, livr)
                    nbPizza = math.random(1, 3)

                    TriggerServerEvent("pizza:itemadd", nbPizza)
                end
            end
        end

        if isToHouse == true then

            destinol = livpt[livr].name

            while notif == true do

                ESX.ShowAdvancedNotification(_U('pizza_shop'), _U('delivery'), -- title, subtitle
                        _U('deliver_text_1') .. destinol .. _U('deliver_text_2'), -- message
                        Config.ContactPhoto, 9) -- contact photo, symbol

                notif = false

                i = 1
            end

            DrawMarker(1, livpt[livr].x, livpt[livr].y, livpt[livr].z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001, 0, 255, 0, 200, 0, 0, 0, 0)

            if GetDistanceBetweenCoords(px, py, pz, GetEntityCoords(GetPlayerPed(-1), true)) < 3 then
                HelpText(_U('deliver_help'), 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)

                if IsControlJustPressed(1, 38) then

                    notif2 = true
                    posibilidad = math.random(1, 100)
                    afaitunepizzamin = true

                    TriggerServerEvent("pizza:itemrm")
                    nbPizza = nbPizza - 1

                    if (posibilidad > 70) and (posibilidad < 90) then

                        pourboire = math.random(100, 200)

                        ESX.ShowAdvancedNotification(_U('pizza_shop'), _U('delivery'), -- title, subtitle
                                _U('tip') .. pourboire .. _U('currency'), -- message
                                Config.ContactPhoto, 9) -- contact photo, symbol

                        TriggerServerEvent("pizza:pourboire", pourboire)

                    end

                    RemoveBlip(liv)
                    Wait(250)
                    if nbPizza == 0 then
                        isToHouse = false
                        isToPizzaria = true
                    else
                        isToHouse = true
                        isToPizzaria = false
                        livr = math.random(1, 48)

                        px = livpt[livr].x
                        py = livpt[livr].y
                        pz = livpt[livr].z

                        distance = round(GetDistanceBetweenCoords(pizzeria.x, pizzeria.y, pizzeria.z, px, py, pz))
                        paie = distance * coefflouze

                        goliv(livpt, livr)
                    end


                end
            end
        end

        if isToPizzaria == true then

            while notif2 == true do
                SetNewWaypoint(pizzeria.x, pizzeria.y)

                ESX.ShowAdvancedNotification(_U('pizza_shop'), _U('new_delivery'), -- title, subtitle
                        _U('next_order'), -- message
                        Config.ContactPhoto, 9) -- contact photo, symbol

                notif2 = false

            end
            DrawMarker(1, pizzeria.x, pizzeria.y, pizzeria.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001, 0, 255, 0, 200, 0, 0, 0, 0)

            if GetDistanceBetweenCoords(pizzeria.x, pizzeria.y, pizzeria.z, GetEntityCoords(GetPlayerPed(-1), true)) < 3 and afaitunepizzamin == true then
                HelpText(_U('retrieve_pizza'), 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)

                if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("faggio2")) then

                    if IsControlJustPressed(1, 38) then

                        if IsInVehicle() then

                            afaitunepizzamin = false

                            ESX.ShowAdvancedNotification(_U('pizza_shop'), _U('delivery'), -- title, subtitle
                                    _U('payout') .. paie .. _U('currency'), -- message
                                    Config.ContactPhoto, 9) -- contact photo, symbol

                            TriggerServerEvent("pizza:pourboire", paie)

                            isInJobPizz = true
                            isToHouse = true
                            livr = math.random(1, 48)

                            px = livpt[livr].x
                            py = livpt[livr].y
                            pz = livpt[livr].z

                            distance = round(GetDistanceBetweenCoords(pizzeria.x, pizzeria.y, pizzeria.z, px, py, pz))
                            paie = distance * coefflouze

                            goliv(livpt, livr)
                            nbPizza = math.random(1, 3)

                            TriggerServerEvent("pizza:itemadd", nbPizza)

                        else

                            notifmoto1 = true

                            while notifmoto1 == true do

                                ESX.ShowAdvancedNotification(_U('pizza_shop'), _U('delivery'), -- title, subtitle
                                        _U('forgot_bike'), -- message
                                        Config.ContactPhoto, 9) -- contact photo, symbol

                                notifmoto1 = false

                            end
                        end
                    end
                else

                    notifmoto2 = true

                    while notifmoto2 == true do

                        ESX.ShowAdvancedNotification(_U('pizza_shop'), _U('delivery'), -- title, subtitle
                                _U('forgot_bike'), -- message
                                Config.ContactPhoto, 9) -- contact photo, symbol

                        notifmoto2 = false

                    end
                end
            end
        end
        if IsEntityDead(GetPlayerPed(-1)) then

            isInJobPizz = false
            livr = 0
            isToHouse = false
            isToPizzaria = false

            paie = 0
            px = 0
            py = 0
            pz = 0
            RemoveBlip(liv)

        end
    end
end)

Citizen.CreateThread(function()
    -- Thread de "fin de service" depuis le point rouge
    while true do

        Citizen.Wait(0)

        if isInJobPizz == true then

            DrawMarker(1, pizzeriafin.x, pizzeriafin.y, pizzeriafin.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001, 255, 0, 0, 200, 0, 0, 0, 0)

            if GetDistanceBetweenCoords(pizzeriafin.x, pizzeriafin.y, pizzeriafin.z, GetEntityCoords(GetPlayerPed(-1), true)) < 1.5 then
                HelpText(_U('stop_delivery_help'), 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)

                if IsControlJustPressed(1, 38) then
                    TriggerServerEvent('pizza:deleteAllPizz')
                    isInJobPizz = false
                    livr = 0
                    isToHouse = false
                    isToPizzaria = false

                    paie = 0
                    px = 0
                    py = 0
                    pz = 0

                    if afaitunepizzamin == true then

                        local vehicleu = GetVehiclePedIsIn(GetPlayerPed(-1), false)

                        SetEntityAsMissionEntity(vehicleu, true, true)
                        deleteCar(vehicleu)

                        ESX.ShowAdvancedNotification(_U('pizza_shop'), _U('delivery'), -- title, subtitle
                                _U('thanks_no_check'), -- message
                                Config.ContactPhoto, 9) -- contact photo, symbol

                        TriggerServerEvent("pizza:paiefinale")

                        SetWaypointOff()

                        afaitunepizzamin = false

                    else

                        local vehicleu = GetVehiclePedIsIn(GetPlayerPed(-1), false)

                        SetEntityAsMissionEntity(vehicleu, true, true)
                        deleteCar(vehicleu)

                        ESX.ShowAdvancedNotification(_U('pizza_shop'), _U('delivery'), -- title, subtitle
                                _U('thanks_for_nothing'), -- message
                                Config.ContactPhoto, 9) -- contact photo, symbol

                    end
                end
            end
        end
    end
end)

--FONCTIONS--

function goliv(livpt, livr)
    -- Fonction d'ajout du point en fonction de la destination de livraison chosie
    liv = AddBlipForCoord(livpt[livr].x, livpt[livr].y, livpt[livr].z)
    SetBlipSprite(liv, 1)
    SetNewWaypoint(livpt[livr].x, livpt[livr].y)
end

function spawn_faggio()
    -- Thread spawn faggio

    Citizen.Wait(0)

    local myPed = GetPlayerPed(-1)
    local player = PlayerId()
    local vehicle = GetHashKey('faggio2')

    RequestModel(vehicle)

    while not HasModelLoaded(vehicle) do
        Wait(1)
    end

    local plateJob = math.random(1000, 9999)
    local spawned_car = CreateVehicle(vehicle, spawnfaggio.x, spawnfaggio.y, spawnfaggio.z, 431.436, -996.786, 25.1887, true, false)

    local plate = "PIZZ" .. plateJob

    SetVehicleNumberPlateText(spawned_car, plate)
    SetVehicleOnGroundProperly(spawned_car)
    SetVehicleLivery(spawned_car, 2)
    SetPedIntoVehicle(myPed, spawned_car, -1)
    SetModelAsNoLongerNeeded(vehicle)

    Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
end

function round(num, numDecimalPlaces)
    local mult = 5 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function deleteCar(entity)
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(entity)) --Native qui del le vehicule
end

function IsInVehicle()
    --Fonction de verification de la presence ou non en vehicule du joueur
    local ply = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(ply) then
        return true
    else
        return false
    end
end

function HelpText(text, state)
    --Fonction qui permet de creer les "Help Text" (Type "Appuyez sur ...")
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, state, 0, -1)
end
