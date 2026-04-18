window.addEventListener('message', function(e) {
    const ui = document.getElementById('ui')
    const booster = document.getElementById('booster')
    const img = document.getElementById('img')
    const appendCloseButton = () => {
        const btn = document.createElement('button')
        btn.textContent = 'Schließen'
        btn.onclick = closeUI
        booster.appendChild(btn)
    }

    if (e.data.action === 'openCard') {
        ui.style.display = 'block'
        booster.style.display = 'none'
        img.src = '../images/' + e.data.card.image
    }

    if (e.data.action === 'showBoosterRewards') {
        ui.style.display = 'none'
        booster.style.display = 'block'
        booster.innerHTML = '<h3>Booster Belohnungen</h3>'

        e.data.cards.forEach(c => {
            let img = document.createElement('img')
            img.src = '../images/' + c.image
            img.style.width = '150px'
            booster.appendChild(img)
        })

        appendCloseButton()
    }

    if (e.data.action === 'openBinder') {
        ui.style.display = 'none'
        booster.style.display = 'block'
        booster.innerHTML = '<h3>Sammelbuch</h3>'

        if (!e.data.binder || !Array.isArray(e.data.binder.cards) || e.data.binder.cards.length === 0) {
            const empty = document.createElement('p')
            empty.textContent = 'Noch keine Karten im Sammelbuch.'
            booster.appendChild(empty)
            appendCloseButton()
            return
        }

        e.data.binder.cards.forEach(c => {
            let card = document.createElement('p')
            card.textContent = typeof c === 'string' ? c : (c.label || c.name || 'Unbekannte Karte')
            booster.appendChild(card)
        })

        appendCloseButton()
    }

})

function closeUI() {
    fetch(`https://${GetParentResourceName()}/closeUI`, {
        method: 'POST'
    })

    const ui = document.getElementById('ui')
    const booster = document.getElementById('booster')

    ui.style.display = 'none'
    booster.style.display = 'none'
    booster.innerHTML = ''
}
