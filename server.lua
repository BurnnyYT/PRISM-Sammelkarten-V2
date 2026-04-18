ESX = exports['es_extended']:getSharedObject()
    TriggerClientEvent('collectiblecards:openBinderUI', src, {
        binderId = metadata.binderId,
        cards = metadata.cards,
        allCards = LoadedCards
    })
end)

RegisterNetEvent('collectiblecards:insertIntoBinder', function(data)
    local src = source

    if not data.card then return end

    local binders = exports.ox_inventory:Search(src, 'slots', 'collectible_binder')

    if not binders or #binders < 1 then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'PRISM Sammelkarten',
            description = 'Du hast kein Sammelbuch dabei.',
            type = 'error'
        })
        return
    end

    local binder = binders[1]
    local metadata = binder.metadata or {}

    if not metadata.binderId then
        metadata.binderId = 'binder_' .. os.time() .. math.random(1000,9999)
    end

    if not metadata.cards then
        metadata.cards = {}
    end

    metadata.cards[data.card] = true

    exports.ox_inventory:SetMetadata(src, binder.slot, metadata)
    exports.ox_inventory:RemoveItem(src, 'collect_card_' .. string.lower(data.card), 1)

    TriggerClientEvent('ox_lib:notify', src, {
        title = 'PRISM Sammelkarten',
        description = 'Karte wurde ins Sammelbuch gelegt.',
        type = 'success'
    })
end)

RegisterNetEvent('collectiblecards:removeFromBinder', function(data)
    local src = source

    local binders = exports.ox_inventory:Search(src, 'slots', 'collectible_binder')
    if not binders or #binders < 1 then return end

    local binder = binders[1]
    local metadata = binder.metadata or {}

    if metadata.cards and metadata.cards[data.card] then
        metadata.cards[data.card] = false

        exports.ox_inventory:SetMetadata(src, binder.slot, metadata)
        exports.ox_inventory:AddItem(src, 'collect_card_' .. string.lower(data.card), 1)
    end
end)

RegisterNetEvent('collectiblecards:openBooster', function()
    local src = source
    local reward = {}

    local amount = math.random(Config.CardsPerBoosterMin, Config.CardsPerBoosterMax)

    for i = 1, amount do
        local card = LoadedCards[math.random(1, #LoadedCards)]
        table.insert(reward, card)

        exports.ox_inventory:AddItem(src, card.item, 1)
    end

    TriggerClientEvent('collectiblecards:showBoosterRewards', src, reward)
end)
