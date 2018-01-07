--Copyright ZAUB1
--N'hesitez pas a rejoindre mon discord : https://discord.gg/yFuSEGj
--Et a me contacter directement pour tout bug ou suggestions

--ESX INIT--

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

--CONFIGURATION--

local pizzeria = { x = -1285.73, y = -1387.15, z = 3.44} --Configuration marker prise de service
local pizzeriafin = { x = -1282.740, y = -1386.488, z = 3.44} --Configuration marker fin de service
local spawnfaggio = { x = -1278.39, y = -1386.84, z = 3.38 } --Configuration du point de spawn du faggio

local livpt = { --Configuration des points de livraisons (repris ceux de Maykellll1 / NetOut)
	[1] = {name = "Vinewood Hills",x = -1220.50, y = 666.95 , z = 143.10},
	[2] = {name = "Vinewood Hills",x = -1338.97, y = 606.31 , z = 133.37},
	[3] = {name = "Rockford Hills",x = -1051.85, y = 431.66 , z = 76.06 },
	[4] = {name = "Rockford Hills",x = -904.04 , y = 191.49 , z = 68.44 },
	[5] = {name = "Rockford Hills",x = -21.58  , y = -23.70 , z = 72.24 },
	[6] = {name = "Hawick"        ,x = -904.04 , y = 191.49 , z = 68.44 },
	[7] = {name = "Alta"          ,x = 225.39  , y = -283.63, z = 28.25 },
	[8] = {name = "Pillbox Hills" ,x = 5.62    , y = -707.72, z = 44.97 },
	[9] = {name = "Mission Row"   ,x = 284.50  , y = -938.50 , z = 28.35},
	[10] ={name = "Rancho"        ,x = 411.59  , y = -1487.54, z = 29.14},
	[11] ={name = "Davis"         ,x = 85.19   , y = -1958.18, z = 20.12},
	[12] ={name ="Chamberlain Hills",x = -213.00, y =-1617.35 , z =37.35},
	[13] ={name ="La puerta"      ,x = -1015.65, y =-1515.05 ,z = 5.51}
}

local blips = {
	{title="Pizzeria", colour=51, id=103, x = -1285.73, y = -1387.15, z = 3.44}, --Configuration du point sur la carte
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

Citizen.CreateThread(function() --Thread d'ajout du point de la pizzeria sur la carte

	for _, info in pairs(blips) do
		
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
	end
	
end)

Citizen.CreateThread(function() --Thread lancement + livraison depuis le marker vert
	while true do

		Citizen.Wait(0)

		if isInJobPizz == false then

			DrawMarker(1,pizzeria.x,pizzeria.y,pizzeria.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,0,255,0, 200, 0, 0, 0, 0)

			if GetDistanceBetweenCoords(pizzeria.x, pizzeria.y, pizzeria.z, GetEntityCoords(GetPlayerPed(-1),true)) < 1.5 then
				HelpText("Appuyez sur ~INPUT_CONTEXT~ pour lancer la livraison de ~r~pizza",0,1,0.5,0.8,0.6,255,255,255,255)
				
				if IsControlJustPressed(1,38) then

					notif = true
					isInJobPizz = true
					isToHouse = true
					livr = math.random(1, 13)

					px = livpt[livr].x
					py = livpt[livr].y
					pz = livpt[livr].z
					distance = round(GetDistanceBetweenCoords(pizzeria.x, pizzeria.y, pizzeria.z, px,py,pz))
					paie = distance * coefflouze

					spawn_faggio()
					goliv(livpt,livr)

					TriggerServerEvent("pizza:itemadd")
					TriggerEvent("pNotify:SendNotification", {
						text = "+1 pizza",
						type = "success",
						queue = "global",
						timemout = 3000,
						layout = "bottomRight"
					})
				end
			end
		end

		if isToHouse == true then

			destinol = livpt[livr].name

			while notif == true do

			TriggerEvent("pNotify:SendNotification", {
				text = "Direction : " ..destinol.. " pour livrer la pizza",
				type = "info",
				queue = "global",
				timeout = 4000,
				layout = "bottomRight"
			})

			notif = false

			i = 1
		end

			DrawMarker(1,livpt[livr].x,livpt[livr].y,livpt[livr].z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,0,255,0, 200, 0, 0, 0, 0)

			if GetDistanceBetweenCoords(px,py,pz, GetEntityCoords(GetPlayerPed(-1),true)) < 3 then
				HelpText("Appuyez sur ~INPUT_CONTEXT~ pour livrer la pizza",0,1,0.5,0.8,0.6,255,255,255,255)

				if IsControlJustPressed(1,38) then

					notif2 = true
					posibilidad = math.random(1, 100)
					afaitunepizzamin = true

					TriggerServerEvent("pizza:itemrm")
					TriggerEvent("pNotify:SendNotification", {
						text = "-1 pizza",
						type = "error",
						queue = "global",
						timemout = 3000,
						layout = "bottomRight"
					})

					if (posibilidad > 70) and (posibilidad < 90) then

						pourboire = math.random(100, 200)

						TriggerEvent("pNotify:SendNotification", {
							text = "Un petit pourboire : " .. pourboire .. "$",
							type = "success",
							queue = "global",
							timeout = 4000,
							layout = "bottomRight"
						})

						TriggerServerEvent("pizza:pourboire", pourboire)

					end

					isToHouse = false
					isToPizzaria = true

					RemoveBlip(liv)
					SetNewWaypoint(pizzeria.x,pizzeria.y)

				end
			end
		end

		if isToPizzaria == true then

			while notif2 == true do

			TriggerEvent("pNotify:SendNotification", {
				text = "Direction la pizzeria !",
				type = "info",
				queue = "global",
				timeout = 4000,
				layout = "bottomRight"
			})

			notif2 = false

		end
			DrawMarker(1,pizzeria.x,pizzeria.y,pizzeria.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,0,255,0, 200, 0, 0, 0, 0)
				
				if GetDistanceBetweenCoords(pizzeria.x,pizzeria.y,pizzeria.z, GetEntityCoords(GetPlayerPed(-1),true)) < 3 then
					HelpText("Appuyez sur ~INPUT_CONTEXT~ pour recuperer les pizzas",0,1,0.5,0.8,0.6,255,255,255,255)
					
					if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("faggio2"))  then
						
						if IsControlJustPressed(1,38) then
							
							if IsInVehicle() then

								TriggerEvent("pNotify:SendNotification", {
									text = "Nous vous remercions de votre travail, voici votre paie : " .. paie .. "$",
									type = "success",
									queue = "global",
									timeout = 4000,
									layout = "bottomRight"
								})

								TriggerServerEvent("pizza:pourboire", paie)
								
								isInJobPizz = true
								isToHouse = true
								livr = math.random(1, 13)

								px = livpt[livr].x
								py = livpt[livr].y
								pz = livpt[livr].z

								distance = round(GetDistanceBetweenCoords(pizzeria.x, pizzeria.y, pizzeria.z, px,py,pz))
								paie = distance * coefflouze

								goliv(livpt,livr)

								TriggerServerEvent("pizza:itemadd")

							else

								notifmoto1 = true

								while notifmoto1 == true do

									TriggerEvent("pNotify:SendNotification", {
										text = "Et la moto tu l'a oublié ?",
										type = "error",
										queue = "global",
										timeout = 4000,
										layout = "bottomRight"
									})

									notifmoto1 = false

								end
							end
						end
					else

						notifmoto2 = true

						while notifmoto2 == true do

							TriggerEvent("pNotify:SendNotification", {
								text = "Et la moto tu l'a oublié ?",
								type = "error",
								queue = "global",
								timeout = 4000,
								layout = "bottomRight"
							})

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

		end
	end
end)

Citizen.CreateThread(function() -- Thread de "fin de service" depuis le point rouge
	while true do

	Citizen.Wait(0)

		if isInJobPizz == true then

			DrawMarker(1,pizzeriafin.x,pizzeriafin.y,pizzeriafin.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,0,0, 200, 0, 0, 0, 0)

			if GetDistanceBetweenCoords(pizzeriafin.x, pizzeriafin.y, pizzeriafin.z, GetEntityCoords(GetPlayerPed(-1),true)) < 1.5 then
				HelpText("Appuyez sur ~INPUT_CONTEXT~ pour arreter la livraison de ~r~pizza",0,1,0.5,0.8,0.6,255,255,255,255)

				if IsControlJustPressed(1,38) then

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

						SetEntityAsMissionEntity( vehicleu, true, true )
			            deleteCar( vehicleu )

			 			TriggerEvent("pNotify:SendNotification", {
					 		text = "Merci d'avoir travaillé, bonne journée",
			 				type = "success",
			 				queue = "global",
			 				timeout = 4000,
			 				layout = "bottomRight"
			 			})

						TriggerServerEvent("pizza:paiefinale")
						
						SetWaypointOff()

			 			afaitunepizzamin = false

			 		else

			 			local vehicleu = GetVehiclePedIsIn(GetPlayerPed(-1), false)

						SetEntityAsMissionEntity( vehicleu, true, true )
			            deleteCar( vehicleu )

			 			TriggerEvent("pNotify:SendNotification", {
					 		text = "Merci quand même (pour rien), bonne journée",
			 				type = "error",
			 				queue = "global",
			 				timeout = 4000,
			 				layout = "bottomRight"
			 			})
			 		end
			 	end
			end
		end
	end
end)

--FONCTIONS--

function goliv(livpt,livr) -- Fonction d'ajout du point en fonction de la destination de livraison chosie
	liv = AddBlipForCoord(livpt[livr].x,livpt[livr].y, livpt[livr].z)
	SetBlipSprite(liv, 1)
	SetNewWaypoint(livpt[livr].x,livpt[livr].y)
end

function spawn_faggio() -- Thread spawn faggio

	Citizen.Wait(0)

	local myPed = GetPlayerPed(-1)
	local player = PlayerId()
	local vehicle = GetHashKey('faggio2')

	RequestModel(vehicle)

	while not HasModelLoaded(vehicle) do
		Wait(1)
	end

	local plate = math.random(100, 900)
	local spawned_car = CreateVehicle(vehicle, spawnfaggio.x,spawnfaggio.y,spawnfaggio.z, 431.436, - 996.786, 25.1887, true, false)

	local plate = "CTZN"..math.random(100, 900)

    SetVehicleNumberPlateText(spawned_car, plate)
	SetVehicleOnGroundProperly(spawned_car)
	SetVehicleLivery(spawned_car, 2)
	SetPedIntoVehicle(myPed, spawned_car, - 1)
	SetModelAsNoLongerNeeded(vehicle)

	Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
end

function round(num, numDecimalPlaces)
	local mult = 5^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function deleteCar( entity ) 
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) ) --Native qui del le vehicule
end

function IsInVehicle() --Fonction de verification de la presence ou non en vehicule du joueur
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

function HelpText(text, state) --Fonction qui permet de creer les "Help Text" (Type "Appuyez sur ...")
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, state, 0, -1)
end
