# PRISM Sammelkarten

Sammelkarten-Resource fuer FiveM mit ESX, `ox_inventory` und NUI-Ansicht fuer Karten, Booster und Sammelbuch.

## Voraussetzungen

Diese Resource setzt folgende Dependencies voraus:

- `es_extended`
- `ox_lib`
- `ox_inventory`
- `oxmysql`

## Installation

1. Ordner in deinen Resources-Ordner legen, z. B.:
   - `resources/[local]/PRISMSammelkarten-main`
2. Sicherstellen, dass alle Dependencies laufen.
3. Resource in `server.cfg` starten.

Beispiel fuer die Startreihenfolge:

```cfg
ensure oxmysql
ensure ox_lib
ensure ox_inventory
ensure es_extended
ensure PRISMSammelkarten-main
```

## ox_inventory Items (Pflicht)

Fuege die folgenden Items in deine `ox_inventory` Item-Definitionen ein (z. B. `ox_inventory/data/items.lua` oder dein eigenes Item-File):

```lua
['collectible_card_example'] = {
    label = 'Beispiel Karte',
    weight = 50,
    stack = true,
    close = true,
    description = 'Eine Sammelkarte.',
},

['collectible_card_card2'] = {
    label = 'Karte 2',
    weight = 50,
    stack = true,
    close = true,
    description = 'Eine Sammelkarte.',
},

['collectible_card_card3'] = {
    label = 'Karte 3',
    weight = 50,
    stack = true,
    close = true,
    description = 'Eine Sammelkarte.',
},

['collectible_booster'] = {
    label = 'Booster Pack',
    weight = 100,
    stack = true,
    close = true,
    description = 'Enthaelt mehrere zufaellige Sammelkarten.',
},

['collectible_binder'] = {
    label = 'Sammelbuch',
    weight = 200,
    stack = false,
    close = true,
    description = 'Zum Sammeln und Verwalten deiner Karten.',
},
```

## Was aktuell nutzbar ist

- Einzelne Karten koennen genutzt werden (NUI oeffnet sich).
- Booster koennen geoeffnet werden und geben zufaellige Karten.
- Sammelbuch kann geoeffnet werden (UI-Basis ist vorhanden).

## Test (quick check)

1. Resource neu starten (`ensure PRISMSammelkarten-main`).
2. Testitems vergeben, z. B. ueber Konsole/Admin-Tool:
   - `collectible_card_example`
   - `collectible_booster`
   - `collectible_binder`
3. Items im Inventar benutzen und pruefen, ob die UIs aufgehen.

## Konfiguration

In `config.lua` kannst du Version und Props anpassen.

Wichtig:
- `Config.GithubVersionURL` ist aktuell ein Platzhalter und sollte auf dein Repo zeigen, wenn du den Versionscheck verwenden willst.

## Hinweise

- Standardmaessig ist nur `images/example.png` enthalten.
- Wenn du eigene Kartenbilder verwenden willst, Dateien in `images/` ablegen und die `Cards`-Liste in `server.lua` anpassen.
