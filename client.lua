local ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('collectiblecards:openCardUI', function(card, hasBinder)
    SetNuiFocus(true, true)

    SendNUIMessage({
        action = 'openCard',
        card = card,
        hasBinder = hasBinder
    })
end)

RegisterNetEvent('collectiblecards:openBinderUI', function(binder)
    SetNuiFocus(true, true)

    SendNUIMessage({
        action = 'openBinder',
        binder = binder
    })
end)

RegisterNetEvent('collectiblecards:showBoosterRewards', function(cards)
    SetNuiFocus(true, true)

    SendNUIMessage({
        action = 'showBoosterRewards',
        cards = cards
    })
end)

RegisterNUICallback('closeUI', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('insertIntoBinder', function(data, cb)
    TriggerServerEvent('collectiblecards:insertIntoBinder', data)
    SetNuiFocus(false, false)
    cb('ok')
end)
