RegisterNetEvent('collectiblecards:openCardUI', function(cardData)
    SetNuiFocus(true, true)

    SendNUIMessage({
        action = 'openCard',
        card = cardData
    })
end)

RegisterNetEvent('collectiblecards:openBinderUI', function(binderData)
    SetNuiFocus(true, true)

    SendNUIMessage({
        action = 'openBinder',
        binder = binderData
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
    cb('ok')
end)
