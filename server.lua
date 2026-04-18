ESX = exports['es_extended']:getSharedObject()

math.randomseed(os.time())

-- 🃏 Kartenliste (hier später automatisch erweiterbar)
local Cards = {
    { name = 'example', item = 'collectible_card_example', image = 'collectible_card_example.png', label = 'Beispiel Karte' },
    { name = 'card2', item = 'collectible_card_card2', image = 'example.png', label = 'Karte 2' },
    { name = 'card3', item = 'collectible_card_card3', image = 'example.png', label = 'Karte 3' }
}

-- 📌 Version Check (GitHub)
local function CheckVersion()
    if not Config.GithubVersionURL or Config.GithubVersionURL:find('USERNAME/REPOSITORY', 1, true) then
        print('[PRISM Sammelkarten] Versionscheck übersprungen (GithubVersionURL Platzhalter).')
        return
    end

    PerformHttpRequest(Config.GithubVersionURL, function(code, res)
        if code == 200 then
            local latest = res:gsub('%s+', '')

            if latest ~= Config.Version then
                print('[PRISM Sammelkarten] ⚠️ Update verfügbar: ' .. latest)
                print('[PRISM Sammelkarten] Aktuell: ' .. Config.Version)
            else
                print('[PRISM Sammelkarten] ✔ Version aktuell')
            end
        else
            print('[PRISM Sammelkarten] ❌ GitHub Check fehlgeschlagen')
        end
    end, 'GET')
end

CreateThread(function()
    Wait(2000)
    CheckVersion()
end)

local function openCardForPlayer(src, cardItem)
    for _, c in pairs(Cards) do
        if c.item == cardItem then
            TriggerClientEvent('collectiblecards:openCardUI', src, c)
            return
        end
    end
end

-- 🎴 Karte anschauen
RegisterNetEvent('collectiblecards:useCard', function(cardItem)
    local src = source
    openCardForPlayer(src, cardItem)
end)

-- 🎁 Boosterpack Randomizer (3–5 Karten)
local function getRandomBoosterCount()
    return math.random(3, 5)
end

local function openBoosterForPlayer(src)
    local reward = {}
    local count = getRandomBoosterCount()

    for i = 1, count do
        local card = Cards[math.random(1, #Cards)]
        table.insert(reward, card)
        exports.ox_inventory:AddItem(src, card.item, 1)
    end

    TriggerClientEvent('collectiblecards:showBoosterRewards', src, reward)
end

RegisterNetEvent('collectiblecards:openBooster', function()
    local src = source
    openBoosterForPlayer(src)
end)

local function openBinderForPlayer(src, metadata)
    if not metadata then
        metadata = {
            binderId = 'binder_' .. os.time() .. math.random(1000, 9999),
            cards = {}
        }
    end

    TriggerClientEvent('collectiblecards:openBinderUI', src, {
        binderId = metadata.binderId,
        cards = metadata.cards,
        allCards = Cards
    })
end

-- 📚 Sammelbuch öffnen (nur UI + Metadata Basis)
RegisterNetEvent('collectiblecards:useBinder', function(metadata)
    local src = source
    openBinderForPlayer(src, metadata)
end)

for _, card in pairs(Cards) do
    ESX.RegisterUsableItem(card.item, function(source)
        openCardForPlayer(source, card.item)
    end)
end

ESX.RegisterUsableItem('collectible_booster', function(source)
    openBoosterForPlayer(source)
end)

ESX.RegisterUsableItem('collectible_binder', function(source)
    openBinderForPlayer(source, nil)
end)

-- ➕ Karte ins Sammelbuch (Basis Hook)
RegisterNetEvent('collectiblecards:insertIntoBinder', function(data)
    local src = source

    if not data or not data.binderId or not data.card then return end

    print(('[PRISM] Karte %s in Binder %s gelegt'):format(data.card, data.binderId))

    -- HIER später ox_inventory metadata update einbauen
end)
